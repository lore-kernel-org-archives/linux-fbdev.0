From: Ondrej Zary <linux@rainbow-software.org>
Date: Sun, 26 Jul 2015 21:26:20 +0000
Subject: [PATCH 3/5] gxt4500: fix color order
Message-Id: <1437945982-3021-4-git-send-email-linux@rainbow-software.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1437945982-3021-1-git-send-email-linux@rainbow-software.org>
In-Reply-To: <1437945982-3021-1-git-send-email-linux@rainbow-software.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Mackerras <paulus@samba.org>
Cc: linux-fbdev@vger.kernel.org, Kernel development list <linux-kernel@vger.kernel.org>

The color order in truecolor modes is wrong. This does not affect console but
is visible e.g. in X11 which has wrong colors.

Swap blue and red colors to fix the problem.
Fixes https://forums.gentoo.org/viewtopic-t-692740-start-0.html

Signed-off-by: Ondrej Zary <linux@rainbow-software.org>
---
 drivers/video/fbdev/gxt4500.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/gxt4500.c b/drivers/video/fbdev/gxt4500.c
index 1f2fd5b..442b07c 100644
--- a/drivers/video/fbdev/gxt4500.c
+++ b/drivers/video/fbdev/gxt4500.c
@@ -347,11 +347,12 @@ static void gxt4500_unpack_pixfmt(struct fb_var_screeninfo *var,
 		break;
 	}
 	if (pixfmt != DFA_PIX_8BIT) {
-		var->green.offset = var->red.length;
-		var->blue.offset = var->green.offset + var->green.length;
+		var->blue.offset = 0;
+		var->green.offset = var->blue.length;
+		var->red.offset = var->green.offset + var->green.length;
 		if (var->transp.length)
 			var->transp.offset -				var->blue.offset + var->blue.length;
+				var->red.offset + var->red.length;
 	}
 }
 
-- 
Ondrej Zary

