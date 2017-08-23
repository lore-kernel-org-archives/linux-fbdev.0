From: David Lechner <david@lechnology.com>
Date: Wed, 23 Aug 2017 19:18:53 +0000
Subject: [PATCH] fbcon: remove restriction on margin color
Message-Id: <1503515933-8045-1-git-send-email-david@lechnology.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org
Cc: David Lechner <david@lechnology.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-kernel@vger.kernel.org

This removes the restriction on the value range of the fbcon=margin:
parameter. The color value really depends on the driver being used.

Signed-off-by: David Lechner <david@lechnology.com>
---

This is a follow up to "fbcon: add fbcon=margin:<color> command line option".

https://lkml.org/lkml/2017/8/23/479

 Documentation/fb/fbcon.txt    | 2 +-
 drivers/video/console/fbcon.c | 2 --
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/Documentation/fb/fbcon.txt b/Documentation/fb/fbcon.txt
index 1822b19..a38d3aa 100644
--- a/Documentation/fb/fbcon.txt
+++ b/Documentation/fb/fbcon.txt
@@ -153,7 +153,7 @@ C. Boot options
 	This option specifies the color of the margins. The margins are the
 	leftover area at the right and the bottom of the screen that are not
 	used by text. By default, this area will be black. The 'color' value
-	is 0 to 7 where 0 is black and 7 is white.
+	is an integer number that depends on the framebuffer driver being used.
 
 C. Attaching, Detaching and Unloading
 
diff --git a/drivers/video/console/fbcon.c b/drivers/video/console/fbcon.c
index 1bce7a7..82e5d6b 100644
--- a/drivers/video/console/fbcon.c
+++ b/drivers/video/console/fbcon.c
@@ -497,8 +497,6 @@ static int __init fb_console_setup(char *this_opt)
 			options += 7;
 			if (*options)
 				margin_color = simple_strtoul(options, &options, 0);
-			if (margin_color > 7)
-				margin_color = 0;
 			continue;
 		}
 	}
-- 
2.7.4

