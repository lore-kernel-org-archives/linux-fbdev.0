From: John Stanley <jpsinthemix@verizon.net>
Date: Sun, 31 Jul 2011 10:04:47 +0000
Subject: Patch fixing savagefb driver typo/regression in linux-3.0.0
Message-Id: <4E3528BF.2020601@verizon.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------020708060707030800050406"
List-Id: <linux-fbdev.vger.kernel.org>
To: linux-fbdev@vger.kernel.org

This is a multi-part message in MIME format.
--------------020708060707030800050406
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

   I have an old T22 Thinkpad with integrated Savage/IX-MV video. As of 
linux-3.0, the video is non-functional; the PC either hard hangs 
immediately or has totally garbled video, and then hard hangs, as soon 
as I attempt to edit a file or cat a file with more than a screen-full 
of text. The foregoing details are actually not important any more as in 
looking at the code changes I discovered a typo in
linux-3.0.0/drivers/video/savage/savagefb.h and have applied the 
attached patch to fix the issue.

PLEASE NOTE:
   I realize that the patch does not quite adhere to linux kernel patch 
coding-style conventions (in particular, spaces around logical 
operators, and lines not exceeding 80 chars), but I have simply changed an
'||' to an '&&' -- and NOT attempted to resolve pre-existing 
coding-style violations.

thanks much,
John

P.S. Many, many thanks for lifting the 800x600 resolution limit! I've 
been using a patch/hack to bump the limit to 1024x768 for an very long 
time...


--------------020708060707030800050406
Content-Type: text/plain;
 name="linux-3.0.0-savagefb-savage4-series-def-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="linux-3.0.0-savagefb-savage4-series-def-fix.patch"

This patch corrects a typo/regression in the savage driver code occurring in going
from linux-2.6.39.3 to linux-3.0.0.

In linux-2.6.39.3, there were two savage4 variants (S3_SAVAGE4 and S3_PROSAVAGE).
Hence, S3_SAVAGE4_SERIES was defined as

  S3_SAVAGE4 or S3_PROSAVAGE

In linux-3.0.0, two additional savage4 variants (S3_TWISTER and S3_PROSAVAGEDDR) have
been added. Hence S3_SAVAGE4_SERIES should be defined as

  S3_SAVAGE4, S3_PROSAVAGE, S3_TWISTER, or S3_PROSAVAGEDDR

In going from linux-2.6.39.3 to linux-3.0.0, the define statement for S3_SAVAGE4_SERIES
was incompletely modified: the '||' should have been changed to an '&&'; for an '||' will
set S3_SAVAGE4_SERIES true for any card.

Signed-off-by: John P. Stanley <jpsinthemix@verizon.net>

--- linux-3.0.0/drivers/video/savage/savagefb.h.orig	2011-07-21 22:17:23.000000000 -0400
+++ linux-3.0.0/drivers/video/savage/savagefb.h	2011-07-31 05:27:47.314798215 -0400
@@ -55,7 +55,7 @@
 
 #define S3_SAVAGE3D_SERIES(chip)  ((chip>=S3_SAVAGE3D) && (chip<=S3_SAVAGE_MX))
 
-#define S3_SAVAGE4_SERIES(chip)   ((chip>=S3_SAVAGE4) || (chip<=S3_PROSAVAGEDDR))
+#define S3_SAVAGE4_SERIES(chip)   ((chip>=S3_SAVAGE4) && (chip<=S3_PROSAVAGEDDR))
 
 #define S3_SAVAGE_MOBILE_SERIES(chip)  ((chip==S3_SAVAGE_MX) || (chip==S3_SUPERSAVAGE))
 

--------------020708060707030800050406--
