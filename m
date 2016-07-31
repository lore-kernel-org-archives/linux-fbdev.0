From: Steve Longerbeam <slongerbeam@gmail.com>
Date: Sun, 31 Jul 2016 19:42:16 +0000
Subject: [PATCH v3 01/12] gpu: ipu-cpmem: Add ipu_cpmem_set_uv_offset()
Message-Id: <1469994147-17549-2-git-send-email-steve_longerbeam@mentor.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1469994147-17549-1-git-send-email-steve_longerbeam@mentor.com>
In-Reply-To: <1469994147-17549-1-git-send-email-steve_longerbeam@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: p.zabel@pengutronix.de, plagnioj@jcrosoft.com, tomi.valkeinen@ti.com
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, Steve Longerbeam <steve_longerbeam@mentor.com>

Adds ipu_cpmem_set_uv_offset(), to set planar U/V offsets.

Signed-off-by: Steve Longerbeam <steve_longerbeam@mentor.com>

---

v3: no changes
v2: no changes
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
index 7adeaae..69c8658 100644
--- a/include/video/imx-ipu-v3.h
+++ b/include/video/imx-ipu-v3.h
@@ -184,6 +184,7 @@ void ipu_cpmem_set_resolution(struct ipuv3_channel *ch, int xres, int yres);
 void ipu_cpmem_set_stride(struct ipuv3_channel *ch, int stride);
 void ipu_cpmem_set_high_priority(struct ipuv3_channel *ch);
 void ipu_cpmem_set_buffer(struct ipuv3_channel *ch, int bufnum, dma_addr_t buf);
+void ipu_cpmem_set_uv_offset(struct ipuv3_channel *ch, u32 u_off, u32 v_off);
 void ipu_cpmem_interlaced_scan(struct ipuv3_channel *ch, int stride);
 void ipu_cpmem_set_axi_id(struct ipuv3_channel *ch, u32 id);
 void ipu_cpmem_set_burstsize(struct ipuv3_channel *ch, int burstsize);
-- 
1.9.1

