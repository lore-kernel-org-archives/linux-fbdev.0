From: John Stanley <jpsinthemix@verizon.net>
Date: Thu, 04 Aug 2011 00:41:00 +0000
Subject: [PATCH] savagedb: Fix savage4 series video chip detection regression
Message-Id: <4E39EA9C.3040700@verizon.net>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, adaplas@gmail.com, Andrew Morton <akpm@linux-foundation.org>, linux-fbdev@vger.kernel.org

From: John Stanley <jpsinthemix@verizon.net>

savagedb: Fix typo causing regression in savage4 series video chip detection

Two additional savage4 variants were added, but the S3_SAVAGE4_SERIES 
macro was incompletely modified, resulting in a false positive detection 
of a savage4 card regardless of which savage card is actually present. 
For non-savage4 series
cards, such as a Savage/IX-MV card, this results in garbled video and/or 
a hard-hang at boot time. Fix this by changing an '||' to an '&&' in the 
S3_SAVAGE4_SERIES macro.

Signed-off-by: John P. Stanley <jpsinthemix@verizon.net>
Reviewed-by: Tormod Volden <debian.tormod@gmail.com>

---

Specifically, prior to linux-3.0, there were two savage4 variants 
(S3_SAVAGE4 and S3_PROSAVAGE). Hence, S3_SAVAGE4_SERIES was defined as

   S3_SAVAGE4 or S3_PROSAVAGE

In linux-3.0, two additional savage4 variants (S3_TWISTER and 
S3_PROSAVAGEDDR) have been added. Hence S3_SAVAGE4_SERIES should be 
defined as

   S3_SAVAGE4, S3_PROSAVAGE, S3_TWISTER, or S3_PROSAVAGEDDR

However, the #define macro for S3_SAVAGE4_SERIES was incompletely 
updated: the '||' should have been changed to an '&&'.

--- linux-3.0.0/drivers/video/savage/savagefb.h.orig    2011-07-21 
22:17:23.000000000 -0400
+++ linux-3.0.0/drivers/video/savage/savagefb.h 2011-07-31 
05:27:47.314798215 -0400
@@ -55,7 +55,7 @@

  #define S3_SAVAGE3D_SERIES(chip)  ((chip>=S3_SAVAGE3D) && 
(chip<=S3_SAVAGE_MX))

-#define S3_SAVAGE4_SERIES(chip)   ((chip>=S3_SAVAGE4) || 
(chip<=S3_PROSAVAGEDDR))
+#define S3_SAVAGE4_SERIES(chip)   ((chip>=S3_SAVAGE4) && 
(chip<=S3_PROSAVAGEDDR))

  #define S3_SAVAGE_MOBILE_SERIES(chip)  ((chip=S3_SAVAGE_MX) || 
(chip=S3_SUPERSAVAGE))

