From: Julia Lawall <julia@diku.dk>
Date: Mon, 22 Feb 2010 07:13:44 +0000
Subject: question about drivers/video/au1200fb.c
Message-Id: <Pine.LNX.4.64.1002220813130.18401@ask.diku.dk>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

The code below seems suspicious.  Which definition of hi1 is
the right one?

This is not intended as a proper patch.  I can send a proper patch when I
know what to do.

julia



diff -u -p a/drivers/video/au1200fb.c b/drivers/video/au1200fb.c
--- a/drivers/video/au1200fb.c
+++ b/drivers/video/au1200fb.c
@@ -661,7 +661,6 @@ static int set_brightness(unsigned int b
 		brightness = 30;
 	}
 	divider = (lcd->pwmdiv & 0x3FFFF) + 1;
-	hi1 = (lcd->pwmhi >> 16) + 1;
 	hi1 = (((brightness & 0xFF) + 1) * divider >> 8);
 	lcd->pwmhi &= 0xFFFF;
 	lcd->pwmhi |= (hi1 << 16);
@@ -1296,7 +1295,6 @@ static void set_global(u_int cmd, struct
 			pdata->brightness = 30;
 		}
 		divider = (lcd->pwmdiv & 0x3FFFF) + 1;
-		hi1 = (lcd->pwmhi >> 16) + 1;
 		hi1 = (((pdata->brightness & 0xFF)+1) * divider >> 8);
 		lcd->pwmhi &= 0xFFFF;
 		lcd->pwmhi |= (hi1 << 16);
