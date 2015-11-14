From: Enric Balletbo i Serra <eballetbo@gmail.com>
Date: Sat, 14 Nov 2015 18:38:19 +0000
Subject: [PATCH] [media] hdmi: added functions for MPEG InfoFrames
Message-Id: <1447526299-4222-1-git-send-email-enric.balletbo@collabora.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org
Cc: Mauro Carvalho Chehab <mchehab@osg.samsung.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, Hans Verkuil <hans.verkuil@cisco.com>, Martin Bugge <marbugge@cisco.com>, Thierry Reding <treding@nvidia.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>

The MPEG Source (MS) InfoFrame is in EIA/CEA-861B. It describes aspects of
the compressed video stream that were used to produce the uncompressed
video.

The patch adds functions to work with MPEG InfoFrames.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---
 drivers/video/hdmi.c | 156 +++++++++++++++++++++++++++++++++++++++++++++++=
++++
 include/linux/hdmi.h |  24 ++++++++
 2 files changed, 180 insertions(+)

diff --git a/drivers/video/hdmi.c b/drivers/video/hdmi.c
index 1626892..d37e821 100644
--- a/drivers/video/hdmi.c
+++ b/drivers/video/hdmi.c
@@ -388,6 +388,81 @@ ssize_t hdmi_vendor_infoframe_pack(struct hdmi_vendor_=
infoframe *frame,
 }
 EXPORT_SYMBOL(hdmi_vendor_infoframe_pack);
=20
+/**
+ * hdmi_mpeg_infoframe_init() - initialize an HDMI MPEG infoframe
+ * @frame: HDMI MPEG infoframe
+ *
+ * Returns 0 on success or a negative error code on failure.
+ */
+int hdmi_mpeg_infoframe_init(struct hdmi_mpeg_infoframe *frame)
+{
+	memset(frame, 0, sizeof(*frame));
+
+	frame->type =3D HDMI_INFOFRAME_TYPE_MPEG;
+	frame->version =3D 1;
+	frame->length =3D HDMI_MPEG_INFOFRAME_SIZE;
+
+	return 0;
+}
+EXPORT_SYMBOL(hdmi_mpeg_infoframe_init);
+
+/**
+ * hdmi_mpeg_infoframe_pack() - write HDMI MPEG infoframe to binary buffer
+ * @frame: HDMI MPEG infoframe
+ * @buffer: destination buffer
+ * @size: size of buffer
+ *
+ * Packs the information contained in the @frame structure into a binary
+ * representation that can be written into the corresponding controller
+ * registers. Also computes the checksum as required by section 5.3.5 of
+ * the HDMI 1.4 specification.
+ *
+ * Returns the number of bytes packed into the binary buffer or a negative
+ * error code on failure.
+ */
+ssize_t hdmi_mpeg_infoframe_pack(struct hdmi_mpeg_infoframe *frame,
+				 void *buffer, size_t size)
+{
+	u8 *ptr =3D buffer;
+	size_t length;
+
+	length =3D HDMI_INFOFRAME_HEADER_SIZE + frame->length;
+
+	if (size < length)
+		return -ENOSPC;
+
+	memset(buffer, 0, size);
+
+	ptr[0] =3D frame->type;
+	ptr[1] =3D frame->version;
+	ptr[2] =3D frame->length;
+	ptr[3] =3D 0; /* checksum */
+
+	/* start infoframe payload */
+	ptr +=3D HDMI_INFOFRAME_HEADER_SIZE;
+
+	/*
+	 * The MPEG Bit Rate is stored as a 32-bit number and is expressed in
+	 * Hertz. MB#0 contains the least significant byte while MB#3 contains
+	 * the most significant byte. If the MPEG Bit Rate is unknown or this
+	 * field doesn=E2=80=99t apply, then all of the bits in Data Bytes 1-4 sh=
all
+	 * be set to 0.
+	 */
+	ptr[0] =3D frame->bitrate & 0x000000ff;
+	ptr[1] =3D (frame->bitrate & 0x0000ff00) >> 8;
+	ptr[2] =3D (frame->bitrate & 0x00ff0000) >> 16;
+	ptr[3] =3D (frame->bitrate & 0xff000000) >> 24;
+
+	ptr[4] =3D frame->picture_type;
+	if (frame->repeated)
+		ptr[4] |=3D BIT(4);
+
+	hdmi_infoframe_set_checksum(buffer, length);
+
+	return length;
+}
+EXPORT_SYMBOL(hdmi_mpeg_infoframe_pack);
+
 /*
  * hdmi_vendor_any_infoframe_pack() - write a vendor infoframe to binary b=
uffer
  */
@@ -435,6 +510,8 @@ hdmi_infoframe_pack(union hdmi_infoframe *frame, void *=
buffer, size_t size)
 		length =3D hdmi_vendor_any_infoframe_pack(&frame->vendor,
 							buffer, size);
 		break;
+	case HDMI_INFOFRAME_TYPE_MPEG:
+		length =3D hdmi_mpeg_infoframe_pack(&frame->mpeg, buffer, size);
 	default:
 		WARN(1, "Bad infoframe type %d\n", frame->any.type);
 		length =3D -EINVAL;
@@ -457,6 +534,8 @@ static const char *hdmi_infoframe_type_get_name(enum hd=
mi_infoframe_type type)
 		return "Source Product Description (SPD)";
 	case HDMI_INFOFRAME_TYPE_AUDIO:
 		return "Audio";
+	case HDMI_INFOFRAME_TYPE_MPEG:
+		return "MPEG";
 	}
 	return "Reserved";
 }
@@ -899,6 +978,41 @@ static void hdmi_audio_infoframe_log(const char *level,
 			frame->downmix_inhibit ? "Yes" : "No");
 }
=20
+static const char *hdmi_mpeg_picture_get_name(enum hdmi_mpeg_picture_type =
type)
+{
+	switch (type) {
+	case HDMI_MPEG_PICTURE_TYPE_UNKNOWN:
+		return "Unknown";
+	case HDMI_MPEG_PICTURE_TYPE_I:
+		return "Intra-coded picture";
+	case HDMI_MPEG_PICTURE_TYPE_B:
+		return "Bi-predictive picture";
+	case HDMI_MPEG_PICTURE_TYPE_P:
+		return "Predicted picture";
+	}
+	return "Reserved";
+}
+
+/**
+ * hdmi_mpeg_infoframe_log() - log info of HDMI MPEG infoframe
+ * @level: logging level
+ * @dev: device
+ * @frame: HDMI MPEG infoframe
+ */
+static void hdmi_mpeg_infoframe_log(const char *level,
+				     struct device *dev,
+				     struct hdmi_mpeg_infoframe *frame)
+{
+	hdmi_infoframe_log_header(level, dev,
+				  (struct hdmi_any_infoframe *)frame);
+
+	hdmi_log("    bit rate: %d Hz\n", frame->bitrate);
+	hdmi_log("    frame type: %s\n",
+			hdmi_mpeg_picture_get_name(frame->picture_type));
+	hdmi_log("    repeated frame: %s\n",
+			frame->repeated ? "Yes" : "No");
+}
+
 static const char *
 hdmi_3d_structure_get_name(enum hdmi_3d_structure s3d_struct)
 {
@@ -987,6 +1101,9 @@ void hdmi_infoframe_log(const char *level,
 	case HDMI_INFOFRAME_TYPE_VENDOR:
 		hdmi_vendor_any_infoframe_log(level, dev, &frame->vendor);
 		break;
+	case HDMI_INFOFRAME_TYPE_MPEG:
+		hdmi_mpeg_infoframe_log(level, dev, &frame->mpeg);
+		break;
 	}
 }
 EXPORT_SYMBOL(hdmi_infoframe_log);
@@ -1138,6 +1255,42 @@ static int hdmi_audio_infoframe_unpack(struct hdmi_a=
udio_infoframe *frame,
 }
=20
 /**
+ * hdmi_mpeg_infoframe_unpack() - unpack binary buffer to a HDMI MPEG info=
frame
+ * @buffer: source buffer
+ * @frame: HDMI MPEG infoframe
+ *
+ * Unpacks the information contained in binary @buffer into a structured
+ * @frame of the HDMI MPEG information frame. Also verifies the checksum as
+ * required by section 5.3.5 of the HDMI 1.4 specification.
+ *
+ * Returns 0 on success or a negative error code on failure.
+ */
+static int hdmi_mpeg_infoframe_unpack(struct hdmi_mpeg_infoframe *frame,
+				     void *buffer)
+{
+	u8 *ptr =3D buffer;
+
+	if (ptr[0] !=3D HDMI_INFOFRAME_TYPE_MPEG ||
+	    ptr[1] !=3D 1 ||
+	    ptr[2] !=3D HDMI_MPEG_INFOFRAME_SIZE) {
+		return -EINVAL;
+	}
+
+	if (hdmi_infoframe_checksum(buffer, HDMI_INFOFRAME_SIZE(MPEG)) !=3D 0)
+		return -EINVAL;
+
+	ptr +=3D HDMI_INFOFRAME_HEADER_SIZE;
+
+	frame->bitrate =3D (ptr[3] << 24) | (ptr[2] << 16) |
+			 (ptr[1] << 8) | ptr[0];
+
+	frame->picture_type =3D ptr[4] & 0x03;
+	frame->repeated =3D ptr[4] & BIT(4) ? true : false;
+
+	return 0;
+}
+
+/**
  * hdmi_vendor_infoframe_unpack() - unpack binary buffer to a HDMI vendor =
infoframe
  * @buffer: source buffer
  * @frame: HDMI Vendor infoframe
@@ -1234,6 +1387,9 @@ int hdmi_infoframe_unpack(union hdmi_infoframe *frame=
, void *buffer)
 	case HDMI_INFOFRAME_TYPE_VENDOR:
 		ret =3D hdmi_vendor_any_infoframe_unpack(&frame->vendor, buffer);
 		break;
+	case HDMI_INFOFRAME_TYPE_MPEG:
+		ret =3D hdmi_mpeg_infoframe_unpack(&frame->mpeg, buffer);
+		break;
 	default:
 		ret =3D -EINVAL;
 		break;
diff --git a/include/linux/hdmi.h b/include/linux/hdmi.h
index e974420..f480373 100644
--- a/include/linux/hdmi.h
+++ b/include/linux/hdmi.h
@@ -32,11 +32,13 @@ enum hdmi_infoframe_type {
 	HDMI_INFOFRAME_TYPE_AVI =3D 0x82,
 	HDMI_INFOFRAME_TYPE_SPD =3D 0x83,
 	HDMI_INFOFRAME_TYPE_AUDIO =3D 0x84,
+	HDMI_INFOFRAME_TYPE_MPEG =3D 0x85,
 };
=20
 #define HDMI_IEEE_OUI 0x000c03
 #define HDMI_INFOFRAME_HEADER_SIZE  4
 #define HDMI_AVI_INFOFRAME_SIZE    13
+#define HDMI_MPEG_INFOFRAME_SIZE   10
 #define HDMI_SPD_INFOFRAME_SIZE    25
 #define HDMI_AUDIO_INFOFRAME_SIZE  10
=20
@@ -297,6 +299,26 @@ int hdmi_vendor_infoframe_init(struct hdmi_vendor_info=
frame *frame);
 ssize_t hdmi_vendor_infoframe_pack(struct hdmi_vendor_infoframe *frame,
 				   void *buffer, size_t size);
=20
+enum hdmi_mpeg_picture_type {
+	HDMI_MPEG_PICTURE_TYPE_UNKNOWN =3D 0x00,
+	HDMI_MPEG_PICTURE_TYPE_I =3D 0x01,
+	HDMI_MPEG_PICTURE_TYPE_B =3D 0x02,
+	HDMI_MPEG_PICTURE_TYPE_P =3D 0x03,
+};
+
+struct hdmi_mpeg_infoframe {
+	enum hdmi_infoframe_type type;
+	unsigned char version;
+	unsigned char length;
+	u32 bitrate;
+	enum hdmi_mpeg_picture_type picture_type;
+	bool repeated;
+};
+
+int hdmi_mpeg_infoframe_init(struct hdmi_mpeg_infoframe *frame);
+ssize_t hdmi_mpeg_infoframe_pack(struct hdmi_mpeg_infoframe *frame,
+				   void *buffer, size_t size);
+
 union hdmi_vendor_any_infoframe {
 	struct {
 		enum hdmi_infoframe_type type;
@@ -314,6 +336,7 @@ union hdmi_vendor_any_infoframe {
  * @spd: spd infoframe
  * @vendor: union of all vendor infoframes
  * @audio: audio infoframe
+ * @mpeg: mpeg infoframe
  *
  * This is used by the generic pack function. This works since all infofra=
mes
  * have the same header which also indicates which type of infoframe shoul=
d be
@@ -325,6 +348,7 @@ union hdmi_infoframe {
 	struct hdmi_spd_infoframe spd;
 	union hdmi_vendor_any_infoframe vendor;
 	struct hdmi_audio_infoframe audio;
+	struct hdmi_mpeg_infoframe mpeg;
 };
=20
 ssize_t
--=20
2.1.0

