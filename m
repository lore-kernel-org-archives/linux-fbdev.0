From: Chaithrika U S <chaithrika-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 2/4] da850/omap-l138: Add callback to control LCD panel power
Date: Fri, 27 Nov 2009 12:14:09 +0530
Message-ID: <1259304249-19439-1-git-send-email-chaithrika@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Cc: akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, linux-fbdev-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, krzysztof.h1-IjDXvh/HVVUAvxtiuMwx3w@public.gmane.org

Add the platform specific callback to control LCD panel and
backlight power.

Signed-off-by: Chaithrika U S <chaithrika-l0cyMroinI0@public.gmane.org>
---
This patch applies to DaVinci GIT tree at
http://git.kernel.org/?p=linux/kernel/git/khilman/linux-davinci.git;a=summary

 arch/arm/mach-davinci/board-da850-evm.c |   24 ++++++++++++++----------
 1 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
index 8e0722f..63a6301 100644
--- a/arch/arm/mach-davinci/board-da850-evm.c
+++ b/arch/arm/mach-davinci/board-da850-evm.c
@@ -351,6 +351,15 @@ static struct davinci_mmc_config da850_mmc_config = {
 	.version	= MMC_CTLR_VERSION_2,
 };
 
+static void da850_panel_power_ctrl(int val)
+{
+	/* lcd backlight */
+	gpio_set_value(DA850_LCD_BL_PIN, val);
+
+	/* lcd power */
+	gpio_set_value(DA850_LCD_PWR_PIN, val);
+}
+
 static int da850_lcd_hw_init(void)
 {
 	int status;
@@ -368,17 +377,11 @@ static int da850_lcd_hw_init(void)
 	gpio_direction_output(DA850_LCD_BL_PIN, 0);
 	gpio_direction_output(DA850_LCD_PWR_PIN, 0);
 
-	/* disable lcd backlight */
-	gpio_set_value(DA850_LCD_BL_PIN, 0);
-
-	/* disable lcd power */
-	gpio_set_value(DA850_LCD_PWR_PIN, 0);
-
-	/* enable lcd power */
-	gpio_set_value(DA850_LCD_PWR_PIN, 1);
+	/* Switch off panel power and backlight */
+	da850_panel_power_ctrl(0);
 
-	/* enable lcd backlight */
-	gpio_set_value(DA850_LCD_BL_PIN, 1);
+	/* Switch on panel power and backlight */
+	da850_panel_power_ctrl(1);
 
 	return 0;
 }
@@ -686,6 +689,7 @@ static __init void da850_evm_init(void)
 		pr_warning("da850_evm_init: lcd initialization failed: %d\n",
 				ret);
 
+	sharp_lk043t1dg01_pdata.panel_power_ctrl = da850_panel_power_ctrl,
 	ret = da8xx_register_lcdc(&sharp_lk043t1dg01_pdata);
 	if (ret)
 		pr_warning("da850_evm_init: lcdc registration failed: %d\n",
-- 
1.5.6
