import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

admin.initializeApp();

export const onVideoCreated = functions.firestore.onDocumentCreated("videos/{videoId}", async (event) => {
  const spawn = require("child-process-promise").spawn;
  const video = event.data!.data();
  await spawn("ffmpeg", [
    "-i",
    video.fileUrl,
    "-ss",
    "00:00:01.000",
    "-vframes",
    "1",
    "-vf",
    "scale=150:-1",
    `/tmp/${event.params.videoId}.jpg`,
  ]);
  const storage = admin.storage();
  const [file, _] = await storage.bucket().upload(`/tmp/${event.params.videoId}.jpg`, {
    destination: `thumbnails/${event.params.videoId}.jpg`,
  });
  await file.makePublic();
  await event.data?.ref.update({ thumbnailUrl: file.publicUrl() });
  const db = admin.firestore();
  db.collection("users").doc(video.creatorUid).collection("videos").doc(event.params.videoId).set({
    thumbnailUrl: file.publicUrl(),
    videoId: event.params.videoId,
  });
});
