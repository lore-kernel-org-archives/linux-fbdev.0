From: Chris Zhong <zyw@rock-chips.com>
Date: Tue, 18 Jul 2017 11:20:41 +0000
Subject: [PATCH v2 1/2] video/hdmi: Introduce helpers for the HDMI audio infoframe payload
Message-Id: <1500376842-6739-1-git-send-email-zyw@rock-chips.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: seanpaul@chromium.org, dianders@chromium.org, briannorris@chromium.org
Cc: linux-rockchip@lists.infradead.org, mark.yao@rock-chips.com, heiko@sntech.de, Chris Zhong <zyw@rock-chips.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Shashank Sharma <shashank.sharma@intel.com>, Jose Abreu <joabreu@synopsys.com>, Jani Nikula <jani.nikula@intel.com>, Thierry Reding <treding@nvidia.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

The DP is using the same audio infoframe payload as hdmi, per DP 1.3
spec, but it has a different header. Provide a new interface here,
it just packs the payload.

Signed-off-by: Chris Zhong <zyw@rock-chips.com>
---

Changes in v2: None

 drivers/video/hdmi.c | 66 ++++++++++++++++++++++++++++++++++++++--------------
 include/linux/hdmi.h |  3 ++-
 2 files changed, 50 insertions(+), 19 deletions(-)

diff --git a/drivers/video/hdmi.c b/drivers/video/hdmi.c
index 1cf907e..e0b041e 100644
--- a/drivers/video/hdmi.c
+++ b/drivers/video/hdmi.c
@@ -240,6 +240,49 @@ int hdmi_audio_infoframe_init(struct hdmi_audio_infoframe *frame)
 EXPORT_SYMBOL(hdmi_audio_infoframe_init);
 
 /**
+ * hdmi_audio_infoframe_pack_payload() - write HDMI audio infoframe payload to
+ * binary buffer
+ * @frame: HDMI audio infoframe
+ * @buffer: destination buffer
+ * @size: size of buffer
+ *
+ * Packs the information contained in the @frame structure into a binary
+ * representation that can be written into the corresponding controller
+ * registers.
+ *
+ * Returns 0 on success or a negative error code on failure.
+ */
+ssize_t hdmi_audio_infoframe_pack_payload(struct hdmi_audio_infoframe *frame,
+					  void *buffer, size_t size)
+{
+	unsigned char channels;
+	u8 *ptr = buffer;
+
+	if (size < frame->length)
+		return -ENOSPC;
+
+	memset(buffer, 0, size);
+
+	if (frame->channels >= 2)
+		channels = frame->channels - 1;
+	else
+		channels = 0;
+
+	ptr[0] = ((frame->coding_type & 0xf) << 4) | (channels & 0x7);
+	ptr[1] = ((frame->sample_frequency & 0x7) << 2) |
+		 (frame->sample_size & 0x3);
+	ptr[2] = frame->coding_type_ext & 0x1f;
+	ptr[3] = frame->channel_allocation;
+	ptr[4] = (frame->level_shift_value & 0xf) << 3;
+
+	if (frame->downmix_inhibit)
+		ptr[4] |= BIT(7);
+
+	return 0;
+}
+EXPORT_SYMBOL(hdmi_audio_infoframe_pack_payload);
+
+/**
  * hdmi_audio_infoframe_pack() - write HDMI audio infoframe to binary buffer
  * @frame: HDMI audio infoframe
  * @buffer: destination buffer
@@ -256,22 +299,15 @@ EXPORT_SYMBOL(hdmi_audio_infoframe_init);
 ssize_t hdmi_audio_infoframe_pack(struct hdmi_audio_infoframe *frame,
 				  void *buffer, size_t size)
 {
-	unsigned char channels;
 	u8 *ptr = buffer;
 	size_t length;
+	int ret;
 
 	length = HDMI_INFOFRAME_HEADER_SIZE + frame->length;
 
 	if (size < length)
 		return -ENOSPC;
 
-	memset(buffer, 0, size);
-
-	if (frame->channels >= 2)
-		channels = frame->channels - 1;
-	else
-		channels = 0;
-
 	ptr[0] = frame->type;
 	ptr[1] = frame->version;
 	ptr[2] = frame->length;
@@ -279,16 +315,10 @@ ssize_t hdmi_audio_infoframe_pack(struct hdmi_audio_infoframe *frame,
 
 	/* start infoframe payload */
 	ptr += HDMI_INFOFRAME_HEADER_SIZE;
-
-	ptr[0] = ((frame->coding_type & 0xf) << 4) | (channels & 0x7);
-	ptr[1] = ((frame->sample_frequency & 0x7) << 2) |
-		 (frame->sample_size & 0x3);
-	ptr[2] = frame->coding_type_ext & 0x1f;
-	ptr[3] = frame->channel_allocation;
-	ptr[4] = (frame->level_shift_value & 0xf) << 3;
-
-	if (frame->downmix_inhibit)
-		ptr[4] |= BIT(7);
+	ret = hdmi_audio_infoframe_pack_payload(frame, ptr,
+					size - HDMI_INFOFRAME_HEADER_SIZE);
+	if (ret)
+		return ret;
 
 	hdmi_infoframe_set_checksum(buffer, length);
 
diff --git a/include/linux/hdmi.h b/include/linux/hdmi.h
index d271ff2..d93c709 100644
--- a/include/linux/hdmi.h
+++ b/include/linux/hdmi.h
@@ -272,7 +272,8 @@ struct hdmi_audio_infoframe {
 int hdmi_audio_infoframe_init(struct hdmi_audio_infoframe *frame);
 ssize_t hdmi_audio_infoframe_pack(struct hdmi_audio_infoframe *frame,
 				  void *buffer, size_t size);
-
+ssize_t hdmi_audio_infoframe_pack_payload(struct hdmi_audio_infoframe *frame,
+					  void *buffer, size_t size);
 enum hdmi_3d_structure {
 	HDMI_3D_STRUCTURE_INVALID = -1,
 	HDMI_3D_STRUCTURE_FRAME_PACKING = 0,
-- 
2.7.4

