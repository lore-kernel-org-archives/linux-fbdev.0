From: vikas.korjani@intel.com
Date: Wed, 12 Aug 2015 09:27:08 +0000
Subject: [RFC 7/8] drm: Add support for pps and compression mode command packet
Message-Id: <1439373233-8188-8-git-send-email-vikas.korjani@intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1439373233-8188-1-git-send-email-vikas.korjani@intel.com>
In-Reply-To: <1439373233-8188-1-git-send-email-vikas.korjani@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-gfx@lists.freedesktop.org
Cc: linux-fbdev@vger.kernel.org, David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>

From: vkorjani <vikas.korjani@intel.com>

After enabling DSC we need to send compression mode command packet
and pps data packet, for which 2 new data types are added
07h  Compression Mode Data Type Write , short write, 2 parameters
0Ah  PPS Long Write (word count determines number of bytes)
This patch adds support to send these packets.

Cc: David Airlie <airlied@linux.ie>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-fbdev@vger.kernel.org

Signed-off-by: vkorjani <vikas.korjani@intel.com>
---
 drivers/gpu/drm/drm_mipi_dsi.c |   29 +++++++++++++++++++++++++++++
 include/drm/drm_mipi_dsi.h     |    4 +++-
 include/video/mipi_display.h   |    3 +++
 3 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_mipi_dsi.c b/drivers/gpu/drm/drm_mipi_dsi.c
index 2d5ca8ee..cd536d1 100644
--- a/drivers/gpu/drm/drm_mipi_dsi.c
+++ b/drivers/gpu/drm/drm_mipi_dsi.c
@@ -521,6 +521,35 @@ ssize_t mipi_dsi_dcs_write_buffer(struct mipi_dsi_device *dsi,
 EXPORT_SYMBOL(mipi_dsi_dcs_write_buffer);
 
 /**
+ *   mipi_dsi_dsc_pps_write_buffer() - transmit a DSC command with payload
+ *   @dsi: DSI peripheral device
+ *   @data: buffer containing data to be transmitted
+ *   @len: size of transmission buffer
+ *
+ *   function will automatically choose the right data type depending on
+ *   the command payload length.
+ *
+ *   Return: The number of bytes successfully transmitted or a negative error
+ *   code on failure.*/
+ssize_t mipi_dsi_dsc_pps_write_buffer(struct mipi_dsi_device *dsi,
+		const void *data, size_t len)
+{
+	 struct mipi_dsi_msg msg = {
+		.channel = dsi->channel,
+		.tx_buf = data,
+		.tx_len = len
+	 };
+
+	if (len = 0)
+		msg.type = MIPI_DSI_DCS_COMPRESSION_MODE;
+	else
+		msg.type = MIPI_DSI_PPS_LONG_WRITE;
+
+	return  mipi_dsi_device_transfer(dsi, &msg);
+}
+EXPORT_SYMBOL(mipi_dsi_dsc_pps_write_buffer);
+
+/**
  * mipi_dsi_dcs_write() - send DCS write command
  * @dsi: DSI peripheral device
  * @cmd: DCS command
diff --git a/include/drm/drm_mipi_dsi.h b/include/drm/drm_mipi_dsi.h
index f1d8d0d..2aa5120 100644
--- a/include/drm/drm_mipi_dsi.h
+++ b/include/drm/drm_mipi_dsi.h
@@ -197,7 +197,9 @@ ssize_t mipi_dsi_dcs_write_buffer(struct mipi_dsi_device *dsi,
 ssize_t mipi_dsi_dcs_write(struct mipi_dsi_device *dsi, u8 cmd,
 			   const void *data, size_t len);
 ssize_t mipi_dsi_dcs_read(struct mipi_dsi_device *dsi, u8 cmd, void *data,
-			  size_t len);
+				size_t len);
+ssize_t mipi_dsi_dsc_pps_write_buffer(struct mipi_dsi_device *dsi,
+				const void *data, size_t len);
 int mipi_dsi_dcs_nop(struct mipi_dsi_device *dsi);
 int mipi_dsi_dcs_soft_reset(struct mipi_dsi_device *dsi);
 int mipi_dsi_dcs_get_power_mode(struct mipi_dsi_device *dsi, u8 *mode);
diff --git a/include/video/mipi_display.h b/include/video/mipi_display.h
index ddcc8ca..880e6e6 100644
--- a/include/video/mipi_display.h
+++ b/include/video/mipi_display.h
@@ -38,6 +38,9 @@ enum {
 
 	MIPI_DSI_DCS_READ				= 0x06,
 
+	MIPI_DSI_DCS_COMPRESSION_MODE                   = 0x07,
+	MIPI_DSI_PPS_LONG_WRITE                         = 0x0A,
+
 	MIPI_DSI_SET_MAXIMUM_RETURN_PACKET_SIZE		= 0x37,
 
 	MIPI_DSI_END_OF_TRANSMISSION			= 0x08,
-- 
1.7.9.5

