From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Date: Mon, 14 Apr 2014 21:59:47 +0000
Subject: [PATCHv2 05/11] ARM: pxa: hx4700: initialize all the struct pwm_lookup members
Message-Id: <1397512793-10325-6-git-send-email-alexandre.belloni@free-electrons.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1397512793-10325-1-git-send-email-alexandre.belloni@free-electrons.com>
In-Reply-To: <1397512793-10325-1-git-send-email-alexandre.belloni@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

This will allow to get rid of the .pwm_period_ns member of struct
platform_pwm_backlight_data as the period will be set by the PWM core.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/mach-pxa/hx4700.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-pxa/hx4700.c b/arch/arm/mach-pxa/hx4700.c
index a7c30eb0c8db..0788a1f171fe 100644
--- a/arch/arm/mach-pxa/hx4700.c
+++ b/arch/arm/mach-pxa/hx4700.c
@@ -574,7 +574,14 @@ static struct platform_device backlight = {
 };
 
 static struct pwm_lookup hx4700_pwm_lookup[] = {
-	PWM_LOOKUP("pxa27x-pwm.1", 0, "pwm-backlight", NULL),
+	{
+		.provider = "pxa27x-pwm.1",
+		.index = 0,
+		.dev_id = "pwm-backlight",
+		.con_id = NULL,
+		.period = 30923,
+		.polarity = PWM_POLARITY_NORMAL,
+	},
 };
 
 /*
-- 
1.8.3.2

