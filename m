From: Ben Hutchings <ben@decadent.org.uk>
Date: Sun, 14 Feb 2010 14:20:13 +0000
Subject: [PATCH 4/5] video: Fix first line of kernel-doc for a few functions
Message-Id: <1266157213.10567.16.camel@localhost>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1266157055.10567.13.camel@localhost>
In-Reply-To: <1266157055.10567.13.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>

The function name must be followed by a space, hypen, space, and a
short description.

Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/video/modedb.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/video/modedb.c b/drivers/video/modedb.c
index 0129f1b..b895aae 100644
--- a/drivers/video/modedb.c
+++ b/drivers/video/modedb.c
@@ -893,7 +893,7 @@ const struct fb_videomode *fb_match_mode(const struct fb_var_screeninfo *var,
 }
 
 /**
- * fb_add_videomode: adds videomode entry to modelist
+ * fb_add_videomode - adds videomode entry to modelist
  * @mode: videomode to add
  * @head: struct list_head of modelist
  *
@@ -928,7 +928,7 @@ int fb_add_videomode(const struct fb_videomode *mode, struct list_head *head)
 }
 
 /**
- * fb_delete_videomode: removed videomode entry from modelist
+ * fb_delete_videomode - removed videomode entry from modelist
  * @mode: videomode to remove
  * @head: struct list_head of modelist
  *
@@ -953,7 +953,7 @@ void fb_delete_videomode(const struct fb_videomode *mode,
 }
 
 /**
- * fb_destroy_modelist: destroy modelist
+ * fb_destroy_modelist - destroy modelist
  * @head: struct list_head of modelist
  */
 void fb_destroy_modelist(struct list_head *head)
@@ -968,7 +968,7 @@ void fb_destroy_modelist(struct list_head *head)
 EXPORT_SYMBOL_GPL(fb_destroy_modelist);
 
 /**
- * fb_videomode_to_modelist: convert mode array to mode list
+ * fb_videomode_to_modelist - convert mode array to mode list
  * @modedb: array of struct fb_videomode
  * @num: number of entries in array
  * @head: struct list_head of modelist
-- 
1.6.6.2



