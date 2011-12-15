From: Rusty Russell <rusty@rustcorp.com.au>
Date: Thu, 15 Dec 2011 03:15:56 +0000
Subject: [PATCH 3/15] i810: fix module_param bool abuse.
Message-Id: <874nx2tu1v.fsf@rustcorp.com.au>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Antonino Daplas <adaplas@gmail.com>

The driver says "module_param(ddc3, bool, 0);".  But it's not a used
as a bool, it's used as a count.

Make it a bool.

Cc: Antonino Daplas <adaplas@gmail.com>
Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: linux-fbdev@vger.kernel.org
Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 drivers/video/i810/i810_main.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/i810/i810_main.c b/drivers/video/i810/i810_main.c
--- a/drivers/video/i810/i810_main.c
+++ b/drivers/video/i810/i810_main.c
@@ -147,7 +147,7 @@ static int vyres      __devinitdata;
 static int sync       __devinitdata;
 static int extvga     __devinitdata;
 static int dcolor     __devinitdata;
-static int ddc3       __devinitdata = 2;
+static bool ddc3      __devinitdata;
 
 /*------------------------------------------------------------*/
 
@@ -1776,7 +1776,7 @@ static void __devinit i810_init_defaults
 	if (sync) 
 		par->dev_flags |= ALWAYS_SYNC;
 
-	par->ddc_num = ddc3;
+	par->ddc_num = (ddc3 ? 3 : 2);
 
 	if (bpp < 8)
 		bpp = 8;
@@ -1999,7 +1999,7 @@ static int __devinit i810fb_setup(char *
 		else if (!strncmp(this_opt, "dcolor", 6))
 			dcolor = 1;
 		else if (!strncmp(this_opt, "ddc3", 4))
-			ddc3 = 3;
+			ddc3 = true;
 		else
 			mode_option = this_opt;
 	}
