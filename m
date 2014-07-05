From: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
Date: Sat, 05 Jul 2014 12:12:05 +0000
Subject: [PATCH] video: backlight: jornada720_lcd.c:  Cleaning up variable that is never used
Message-Id: <1404562325-18471-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jingoo Han <jg1.han@samsung.com>, Bryan Wu <cooloney@gmail.com>
Cc: Rickard Strandqvist <rickard.strandqvist@sonymobile.com>, Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>, Lee Jones <lee.jones@linaro.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

From: Rickard Strandqvist <rickard.strandqvist@sonymobile.com>

Variable ar assigned a value that is never used.
I have also removed all the code that thereby serves no purpose.

This was found using a static code analysis program called cppcheck

Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
---
 drivers/video/backlight/jornada720_lcd.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/video/backlight/jornada720_lcd.c b/drivers/video/backlight/jornada720_lcd.c
index da3876c..b304319 100644
--- a/drivers/video/backlight/jornada720_lcd.c
+++ b/drivers/video/backlight/jornada720_lcd.c
@@ -56,12 +56,10 @@ static int jornada_lcd_get_contrast(struct lcd_device *ld)
 
 static int jornada_lcd_set_contrast(struct lcd_device *ld, int value)
 {
-	int ret;
-
 	jornada_ssp_start();
 
 	/* start by sending our set contrast cmd to mcu */
-	ret = jornada_ssp_byte(SETCONTRAST);
+	jornada_ssp_byte(SETCONTRAST);
 
 	/* push the new value */
 	if (jornada_ssp_byte(value) != TXDUMMY) {
-- 
1.7.10.4

