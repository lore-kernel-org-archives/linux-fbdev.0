From: Steve Longerbeam <slongerbeam@gmail.com>
Date: Wed, 20 Jul 2016 01:11:00 +0000
Subject: [PATCH v2 02/13] gpu: ipu-cpmem: Add ipu_cpmem_set_uv_offset()
Message-Id: <1468977071-29240-3-git-send-email-steve_longerbeam@mentor.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1467932621-358-1-git-send-email-steve_longerbeam@mentor.com>
 <1468977071-29240-1-git-send-email-steve_longerbeam@mentor.com>
In-Reply-To: <1468977071-29240-1-git-send-email-steve_longerbeam@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: p.zabel@pengutronix.de, plagnioj@jcrosoft.com, tomi.valkeinen@ti.com
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Steve Longerbeam <steve_longerbeam@mentor.com>

Adds ipu_cpmem_set_uv_offset(), to set planar U/V offsets.

Signed-off-by: Steve Longerbeam <steve_longerbeam@mentor.com>
---
 drivers/gpu/ipu-v3/ipu-cpmem.c | 7 +++++++
 include/video/imx-ipu-v3.h     | 1 +
 2 files changed, 8 insertions(+)

diff --git a/drivers/gpu/ipu-v3/ipu-cpmem.c b/drivers/gpu/ipu-v3/ipu-cpmem.c
index 6494a4d..a36c35e 100644
--- a/drivers/gpu/ipu-v3/ipu-cpmem.c
+++ b/drivers/gpu/ipu-v3/ipu-cpmem.c
@@ -253,6 +253,13 @@ void ipu_cpmem_set_buffer(struct ipuv3_channel *ch, int bufnum, dma_addr_t buf)
 }
 EXPORT_SYMBOL_GPL(ipu_cpmem_set_buffer);
 
+void ipu_cpmem_set_uv_offset(struct ipuv3_channel *ch, u32 u_off, u32 v_off)
+{
+	ipu_ch_param_write_field(ch, IPU_FIELD_UBO, u_off / 8);
+	ipu_ch_param_write_field(ch, IPU_FIELD_VBO, v_off / 8);
+}
+EXPORT_SYMBOL_GPL(ipu_cpmem_set_uv_offset);
+
 void ipu_cpmem_interlaced_scan(struct ipuv3_channel *ch, int stride)
 {
 	ipu_ch_param_write_field(ch, IPU_FIELD_SO, 1);
diff --git a/include/video/imx-ipu-v3.h b/include/video/imx-ipu-v3.h
index a7a28db..48c8dc5 100644
--- a/include/video/imx-ipu-v3.h
+++ b/include/video/imx-ipu-v3.h
@@ -194,6 +194,7 @@ void ipu_cpmem_set_resolution(struct ipuv3_channel *ch, int xres, int yres);
 void ipu_cpmem_set_stride(struct ipuv3_channel *ch, int stride);
 void ipu_cpmem_set_high_priority(struct ipuv3_channel *ch);
 void ipu_cpmem_set_buffer(struct ipuv3_channel *ch, int bufnum, dma_addr_t buf);
+void ipu_cpmem_set_uv_offset(struct ipuv3_channel *ch, u32 u_off, u32 v_off);
 void ipu_cpmem_interlaced_scan(struct ipuv3_channel *ch, int stride);
 void ipu_cpmem_set_axi_id(struct ipuv3_channel *ch, u32 id);
 void ipu_cpmem_set_burstsize(struct ipuv3_channel *ch, int burstsize);
-- 
1.9.1

