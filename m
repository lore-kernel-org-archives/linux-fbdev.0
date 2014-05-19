From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Date: Mon, 19 May 2014 20:42:39 +0000
Subject: [PATCHv2 resend 08/11] ARM: shmobile: Armadillo 800 EVA: use PWM_LOOKUP to initialize struct pwm_loo
Message-Id: <1400532162-29483-9-git-send-email-alexandre.belloni@free-electrons.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1400532162-29483-1-git-send-email-alexandre.belloni@free-electrons.com>
In-Reply-To: <1400532162-29483-1-git-send-email-alexandre.belloni@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Acked-by: Simon Horman <horms@verge.net.au>
---
 arch/arm/mach-shmobile/board-armadillo800eva.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-armadillo800eva.c b/arch/arm/mach-shmobile/board-armadillo800eva.c
index 1bf61dad9a35..ca82b1e2ebab 100644
--- a/arch/arm/mach-shmobile/board-armadillo800eva.c
+++ b/arch/arm/mach-shmobile/board-armadillo800eva.c
@@ -407,14 +407,8 @@ static struct platform_device pwm_device = {
 };
 
 static struct pwm_lookup pwm_lookup[] = {
-	{
-		.provider = "renesas-tpu-pwm",
-		.index = 2,
-		.dev_id = "pwm-backlight.0",
-		.con_id = NULL,
-		.period = 33333,
-		.polarity = PWM_POLARITY_INVERSED,
-	},
+	PWM_LOOKUP("renesas-tpu-pwm", 2, "pwm-backlight.0", NULL,
+		   33333, PWM_POLARITY_INVERSED),
 };
 
 /* LCDC and backlight */
-- 
1.9.1

