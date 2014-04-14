From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Date: Mon, 14 Apr 2014 21:59:46 +0000
Subject: [PATCHv2 04/11] ARM: OMAP3: Beagle: initialize all the struct pwm_lookup members
Message-Id: <1397512793-10325-5-git-send-email-alexandre.belloni@free-electrons.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1397512793-10325-1-git-send-email-alexandre.belloni@free-electrons.com>
In-Reply-To: <1397512793-10325-1-git-send-email-alexandre.belloni@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

This will allow to get rid of the .pwm_period_ns member of struct led_pwm as the
period will be set by the PWM core.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/mach-omap2/board-omap3beagle.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index d6ed819ff15c..f27e1ec90b5e 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -61,7 +61,14 @@
 
 static struct pwm_lookup pwm_lookup[] = {
 	/* LEDB -> PMU_STAT */
-	PWM_LOOKUP("twl-pwmled", 1, "leds_pwm", "beagleboard::pmu_stat"),
+	{
+		.provider = "twl-pwmled",
+		.index = 1,
+		.dev_id = "leds_pwm",
+		.con_id = "beagleboard::pmu_stat",
+		.period = 7812500,
+		.polarity = PWM_POLARITY_NORMAL,
+	},
 };
 
 static struct led_pwm pwm_leds[] = {
-- 
1.8.3.2

