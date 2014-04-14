From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Date: Mon, 14 Apr 2014 21:59:51 +0000
Subject: [PATCHv2 09/11] ARM: pxa: hx4700: use PWM_LOOKUP to initialize struct pwm_lookup
Message-Id: <1397512793-10325-10-git-send-email-alexandre.belloni@free-electrons.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1397512793-10325-1-git-send-email-alexandre.belloni@free-electrons.com>
In-Reply-To: <1397512793-10325-1-git-send-email-alexandre.belloni@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/mach-pxa/hx4700.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-pxa/hx4700.c b/arch/arm/mach-pxa/hx4700.c
index 0788a1f171fe..c66ad4edc5e3 100644
--- a/arch/arm/mach-pxa/hx4700.c
+++ b/arch/arm/mach-pxa/hx4700.c
@@ -574,14 +574,8 @@ static struct platform_device backlight = {
 };
 
 static struct pwm_lookup hx4700_pwm_lookup[] = {
-	{
-		.provider = "pxa27x-pwm.1",
-		.index = 0,
-		.dev_id = "pwm-backlight",
-		.con_id = NULL,
-		.period = 30923,
-		.polarity = PWM_POLARITY_NORMAL,
-	},
+	PWM_LOOKUP("pxa27x-pwm.1", 0, "pwm-backlight", NULL,
+		   30923, PWM_POLARITY_NORMAL),
 };
 
 /*
-- 
1.8.3.2

