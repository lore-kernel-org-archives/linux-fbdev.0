From: Afzal Mohammed <afzal@ti.com>
Date: Fri, 07 Dec 2012 11:56:19 +0000
Subject: [PATCH 08/10] video: da8xx-fb: store struct device *
Message-Id: <3d63942fbac547cec9620bc30dcf60b1c48f9eb0.1354874432.git.afzal@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1354874432.git.afzal@ti.com>
In-Reply-To: <cover.1354874432.git.afzal@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Vaibhav Hiremath <hvaibhav@ti.com>, Sekhar Nori <nsekhar@ti.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Afzal Mohammed <afzal@ti.com>

store struct device pointer so that dev_dbg/err can be used outside
of probe.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 drivers/video/da8xx-fb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/video/da8xx-fb.c b/drivers/video/da8xx-fb.c
index 19ee560..663b3c5 100644
--- a/drivers/video/da8xx-fb.c
+++ b/drivers/video/da8xx-fb.c
@@ -154,6 +154,7 @@ static inline void lcdc_write(unsigned int val, unsigned int addr)
 }
 
 struct da8xx_fb_par {
+	struct device		*dev;
 	resource_size_t p_palette_base;
 	unsigned char *v_palette_base;
 	dma_addr_t		vram_phys;
@@ -1295,6 +1296,7 @@ static int __devinit fb_probe(struct platform_device *device)
 	}
 
 	par = da8xx_fb_info->par;
+	par->dev = &device->dev;
 	par->lcdc_clk = fb_clk;
 	par->lcd_fck_rate = clk_get_rate(fb_clk);
 	if (fb_pdata->panel_power_ctrl) {
-- 
1.7.12

