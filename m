From: Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>
Date: Tue, 28 Jun 2011 15:05:12 +0000
Subject: [PATCH] video: update author email for atmel-pwm-bl backlight driver
Message-Id: <1309273512-9360-1-git-send-email-hans-christian.egtvedt@atmel.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

This patch updates the email address of the atmel-pwm-bl backlight driver
supported by me to an email account I will use on a more regular basis in the
future.

Signed-off-by: Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>
---
 drivers/video/backlight/atmel-pwm-bl.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/backlight/atmel-pwm-bl.c b/drivers/video/backlight/atmel-pwm-bl.c
index 0443a4f..7c6a88a 100644
--- a/drivers/video/backlight/atmel-pwm-bl.c
+++ b/drivers/video/backlight/atmel-pwm-bl.c
@@ -243,6 +243,6 @@ static void __exit atmel_pwm_bl_exit(void)
 }
 module_exit(atmel_pwm_bl_exit);
 
-MODULE_AUTHOR("Hans-Christian egtvedt <hans-christian.egtvedt@atmel.com>");
+MODULE_AUTHOR("Hans-Christian Egtvedt <egtvedt@samfundet.no>");
 MODULE_DESCRIPTION("Atmel PWM backlight driver");
 MODULE_LICENSE("GPL");
-- 
1.7.4.1

