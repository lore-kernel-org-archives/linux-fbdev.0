From: Steve Longerbeam <slongerbeam@gmail.com>
Date: Wed, 20 Jul 2016 01:11:01 +0000
Subject: [PATCH v2 03/13] gpu: ipu-cpmem: Add ipu_cpmem_get_burstsize()
Message-Id: <1468977071-29240-4-git-send-email-steve_longerbeam@mentor.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1467932621-358-1-git-send-email-steve_longerbeam@mentor.com>
 <1468977071-29240-1-git-send-email-steve_longerbeam@mentor.com>
In-Reply-To: <1468977071-29240-1-git-send-email-steve_longerbeam@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: p.zabel@pengutronix.de, plagnioj@jcrosoft.com, tomi.valkeinen@ti.com
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Steve Longerbeam <steve_longerbeam@mentor.com>

Adds ipu_cpmem_get_burstsize().

Signed-off-by: Steve Longerbeam <steve_longerbeam@mentor.com>
---
 drivers/gpu/ipu-v3/ipu-cpmem.c | 6 ++++++
 include/video/imx-ipu-v3.h     | 1 +
 2 files changed, 7 insertions(+)

diff --git a/drivers/gpu/ipu-v3/ipu-cpmem.c b/drivers/gpu/ipu-v3/ipu-cpmem.c
index a36c35e..fcb7dc8 100644
--- a/drivers/gpu/ipu-v3/ipu-cpmem.c
+++ b/drivers/gpu/ipu-v3/ipu-cpmem.c
@@ -275,6 +275,12 @@ void ipu_cpmem_set_axi_id(struct ipuv3_channel *ch, u32 id)
 }
 EXPORT_SYMBOL_GPL(ipu_cpmem_set_axi_id);
 
+int ipu_cpmem_get_burstsize(struct ipuv3_channel *ch)
+{
+	return ipu_ch_param_read_field(ch, IPU_FIELD_NPB) + 1;
+}
+EXPORT_SYMBOL_GPL(ipu_cpmem_get_burstsize);
+
 void ipu_cpmem_set_burstsize(struct ipuv3_channel *ch, int burstsize)
 {
 	ipu_ch_param_write_field(ch, IPU_FIELD_NPB, burstsize - 1);
diff --git a/include/video/imx-ipu-v3.h b/include/video/imx-ipu-v3.h
index 48c8dc5..5d59739 100644
--- a/include/video/imx-ipu-v3.h
+++ b/include/video/imx-ipu-v3.h
@@ -197,6 +197,7 @@ void ipu_cpmem_set_buffer(struct ipuv3_channel *ch, int bufnum, dma_addr_t buf);
 void ipu_cpmem_set_uv_offset(struct ipuv3_channel *ch, u32 u_off, u32 v_off);
 void ipu_cpmem_interlaced_scan(struct ipuv3_channel *ch, int stride);
 void ipu_cpmem_set_axi_id(struct ipuv3_channel *ch, u32 id);
+int ipu_cpmem_get_burstsize(struct ipuv3_channel *ch);
 void ipu_cpmem_set_burstsize(struct ipuv3_channel *ch, int burstsize);
 void ipu_cpmem_set_block_mode(struct ipuv3_channel *ch);
 void ipu_cpmem_set_rotation(struct ipuv3_channel *ch,
-- 
1.9.1

