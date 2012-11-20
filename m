From: Manjunathappa <prakash.pm@ti.com>
Date: Tue, 20 Nov 2012 12:53:01 +0000
Subject: [PATCH] video: da8xx-fb: clk_get on connection id fck
Message-Id: <1353415261-30080-1-git-send-email-prakash.pm@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

do clk_get on connection id "fck" to support OMAP based
platforms having multiple clocks for module. Without this
driver change clk_get fails on am335x.

This patch is based on the discussion in community
http://marc.info/?l=linux-kernel&m5166018907827&w=2

Signed-off-by: Manjunathappa <prakash.pm@ti.com>
Cc: Vaibhav Hiremath <hvaibhav@ti.com>
---
 arch/arm/mach-davinci/da830.c     |    2 +-
 arch/arm/mach-davinci/da850.c     |    2 +-
 arch/arm/mach-davinci/pm_domain.c |    1 +
 drivers/video/da8xx-fb.c          |    2 +-
 4 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-davinci/da830.c b/arch/arm/mach-davinci/da830.c
index deee5c2..ee8504f 100644
--- a/arch/arm/mach-davinci/da830.c
+++ b/arch/arm/mach-davinci/da830.c
@@ -408,7 +408,7 @@ static struct clk_lookup da830_clks[] = {
 	CLK(NULL,		"pwm2",		&pwm2_clk),
 	CLK("eqep.0",		NULL,		&eqep0_clk),
 	CLK("eqep.1",		NULL,		&eqep1_clk),
-	CLK("da8xx_lcdc.0",	NULL,		&lcdc_clk),
+	CLK("da8xx_lcdc.0",	"fck",		&lcdc_clk),
 	CLK("davinci-mcasp.0",	NULL,		&mcasp0_clk),
 	CLK("davinci-mcasp.1",	NULL,		&mcasp1_clk),
 	CLK("davinci-mcasp.2",	NULL,		&mcasp2_clk),
diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index b44dc84..bc75bdd 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -389,7 +389,7 @@ static struct clk_lookup da850_clks[] = {
 	CLK(NULL,		"rmii",		&rmii_clk),
 	CLK("davinci_emac.1",	NULL,		&emac_clk),
 	CLK("davinci-mcasp.0",	NULL,		&mcasp_clk),
-	CLK("da8xx_lcdc.0",	NULL,		&lcdc_clk),
+	CLK("da8xx_lcdc.0",	"fck",		&lcdc_clk),
 	CLK("davinci_mmc.0",	NULL,		&mmcsd0_clk),
 	CLK("davinci_mmc.1",	NULL,		&mmcsd1_clk),
 	CLK(NULL,		"aemif",	&aemif_clk),
diff --git a/arch/arm/mach-davinci/pm_domain.c b/arch/arm/mach-davinci/pm_domain.c
index 00946e2..c90250e 100644
--- a/arch/arm/mach-davinci/pm_domain.c
+++ b/arch/arm/mach-davinci/pm_domain.c
@@ -53,6 +53,7 @@ static struct dev_pm_domain davinci_pm_domain = {
 
 static struct pm_clk_notifier_block platform_bus_notifier = {
 	.pm_domain = &davinci_pm_domain,
+	.con_ids = { "fck", NULL, },
 };
 
 static int __init davinci_pm_runtime_init(void)
diff --git a/drivers/video/da8xx-fb.c b/drivers/video/da8xx-fb.c
index f0f21c8..bb68533 100644
--- a/drivers/video/da8xx-fb.c
+++ b/drivers/video/da8xx-fb.c
@@ -1248,7 +1248,7 @@ static int __devinit fb_probe(struct platform_device *device)
 		goto err_request_mem;
 	}
 
-	fb_clk = clk_get(&device->dev, NULL);
+	fb_clk = clk_get(&device->dev, "fck");
 	if (IS_ERR(fb_clk)) {
 		dev_err(&device->dev, "Can not get device clock\n");
 		ret = -ENODEV;
-- 
1.7.9.5

