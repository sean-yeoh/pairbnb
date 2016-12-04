$(document).on("turbolinks:load", function() {
  $("#listing_pictures").fileinput({
    showUpload: false,
    previewFileType: "image",
    allowedFileExtensions: ["jpg", "gif", "png", "jpeg"],
    previewClass: "bg-warning"
  });
});