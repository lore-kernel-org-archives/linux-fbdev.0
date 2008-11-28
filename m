From: Hannes Eder <hannes@hanneseder.net>
Subject: [PATCH] viafb: fix sparse warnings
Date: Fri, 28 Nov 2008 17:18:40 +0100
Message-ID: <493050b9.0aa1660a.74cd.ffffb85a@mx.google.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755212AbYK1UMz@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Joseph Chan <JosephChan@via.com.tw>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, trivial@kernel.org

Fix this sparse warnings:

  drivers/video/via/viafbdev.c:871:3: warning: returning void-valued expression
  drivers/video/via/viafbdev.c:938:3: warning: returning void-valued expression
  drivers/video/via/viafbdev.c:995:3: warning: returning void-valued expression

Signed-off-by: Hannes Eder <hannes@hanneseder.net>
---
 drivers/video/via/viafbdev.c |   18 ++++++++++++------
 1 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/video/via/viafbdev.c b/drivers/video/via/viafbdev.c
index 73ac754..243fde6 100644
--- a/drivers/video/via/viafbdev.c
+++ b/drivers/video/via/viafbdev.c
@@ -867,8 +867,10 @@ static void viafb_fillrect(struct fb_info *info,
 	u32 col = 0, rop = 0;
 	int pitch;
 
-	if (!viafb_accel)
-		return cfb_fillrect(info, rect);
+	if (!viafb_accel) {
+		cfb_fillrect(info, rect);
+		return;
+	}
 
 	if (!rect->width || !rect->height)
 		return;
@@ -934,8 +936,10 @@ static void viafb_copyarea(struct fb_info *info,
 
 	DEBUG_MSG(KERN_INFO "viafb_copyarea!!\n");
 
-	if (!viafb_accel)
-		return cfb_copyarea(info, area);
+	if (!viafb_accel) {
+		cfb_copyarea(info, area);
+		return;
+	}
 
 	if (!area->width || !area->height)
 		return;
@@ -991,8 +995,10 @@ static void viafb_imageblit(struct fb_info *info,
 	int i;
 	int pitch;
 
-	if (!viafb_accel)
-		return cfb_imageblit(info, image);
+	if (!viafb_accel) {
+		cfb_imageblit(info, image);
+		return;
+	}
 
 	udata = (u32 *) image->data;
 
-- 
1.5.6.3
