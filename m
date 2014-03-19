From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Date: Wed, 19 Mar 2014 13:03:22 +0000
Subject: [PATCH 09/16] avr32/at32ap: switch to the generic PWM framework
Message-Id: <1395234209-15546-10-git-send-email-alexandre.belloni@free-electrons.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1395234209-15546-1-git-send-email-alexandre.belloni@free-electrons.com>
In-Reply-To: <1395234209-15546-1-git-send-email-alexandre.belloni@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Switch to the pwm/pwm-atmel driver instead of misc/atmel_pwm

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/avr32/mach-at32ap/at32ap700x.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/avr32/mach-at32ap/at32ap700x.c b/arch/avr32/mach-at32ap/at32ap700x.c
index a1f4d1e91b52..db85b5ec3351 100644
--- a/arch/avr32/mach-at32ap/at32ap700x.c
+++ b/arch/avr32/mach-at32ap/at32ap700x.c
@@ -1553,7 +1553,7 @@ static struct resource atmel_pwm0_resource[] __initdata = {
 	IRQ(24),
 };
 static struct clk atmel_pwm0_mck = {
-	.name		= "pwm_clk",
+	.name		= "at91sam9rl-pwm",
 	.parent		= &pbb_clk,
 	.mode		= pbb_clk_mode,
 	.get_rate	= pbb_clk_get_rate,
@@ -1568,7 +1568,7 @@ struct platform_device *__init at32_add_device_pwm(u32 mask)
 	if (!mask)
 		return NULL;
 
-	pdev = platform_device_alloc("atmel_pwm", 0);
+	pdev = platform_device_alloc("at91sam9rl-pwm", 0);
 	if (!pdev)
 		return NULL;
 
@@ -1576,9 +1576,6 @@ struct platform_device *__init at32_add_device_pwm(u32 mask)
 				ARRAY_SIZE(atmel_pwm0_resource)))
 		goto out_free_pdev;
 
-	if (platform_device_add_data(pdev, &mask, sizeof(mask)))
-		goto out_free_pdev;
-
 	pin_mask = 0;
 	if (mask & (1 << 0))
 		pin_mask |= (1 << 28);
-- 
1.8.3.2

