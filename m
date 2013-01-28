From: Afzal Mohammed <afzal@ti.com>
Date: Mon, 28 Jan 2013 09:32:43 +0000
Subject: [PATCH v5 01/12] video: da8xx-fb: make io operations safe
Message-Id: <afbc9e3c14b1b7b8eed4b084f57365eaf1c8b718.1359356015.git.afzal@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1359356015.git.afzal@ti.com>
In-Reply-To: <cover.1359356015.git.afzal@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, Rob Landley <rob@landley.net>, Mike Turquette <mturquette@linaro.org>

Replace __raw_readl/__raw_writel with readl/writel; this driver is
reused on ARMv7 (AM335x SoC).

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---

v2: new patch

 drivers/video/da8xx-fb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/da8xx-fb.c b/drivers/video/da8xx-fb.c
index 720604c..35a33ca 100644
--- a/drivers/video/da8xx-fb.c
+++ b/drivers/video/da8xx-fb.c
@@ -141,12 +141,12 @@ static int frame_done_flag;
 
 static inline unsigned int lcdc_read(unsigned int addr)
 {
-	return (unsigned int)__raw_readl(da8xx_fb_reg_base + (addr));
+	return (unsigned int)readl(da8xx_fb_reg_base + (addr));
 }
 
 static inline void lcdc_write(unsigned int val, unsigned int addr)
 {
-	__raw_writel(val, da8xx_fb_reg_base + (addr));
+	writel(val, da8xx_fb_reg_base + (addr));
 }
 
 struct da8xx_fb_par {
-- 
1.7.12

