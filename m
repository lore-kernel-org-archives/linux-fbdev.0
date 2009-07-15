From: Daniel Drake <dsd@laptop.org>
Subject: [PATCH] viafb: Don't accelerate blit of color images
Date: Wed, 15 Jul 2009 12:11:27 +0100 (BST)
Message-ID: <20090715111127.132C49D405C@zog.reactivated.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@lists.laptop.org>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <http://lists.laptop.org/listinfo/devel>,
	<mailto:devel-request@lists.laptop.org?subject=unsubscribe>
List-Archive: <http://lists.laptop.org/pipermail/devel>
List-Post: <mailto:devel@lists.laptop.org>
List-Help: <mailto:devel-request@lists.laptop.org?subject=help>
List-Subscribe: <http://lists.laptop.org/listinfo/devel>,
	<mailto:devel-request@lists.laptop.org?subject=subscribe>
Sender: devel-bounces@lists.laptop.org
Errors-To: devel-bounces@lists.laptop.org
To: HaraldWelte@viatech.com
Cc: JosephChan@via.com.tw, devel@lists.laptop.org, linux-fbdev-devel@lists.sourceforge.net

When the Tux boot logo is enabled, the boot penguin does not get rendered
correctly and under certain circumstances the system will hang.

This appears to be because the accelerated blitting code only supports
mono images at the moment, as suggested by a high bit 8 of the GECMD in
viafb_imageblit().

Fixes http://dev.laptop.org/ticket/9404 and
http://dev.laptop.org/ticket/9322
---
 drivers/video/via/viafbdev.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/via/viafbdev.c b/drivers/video/via/viafbdev.c
index 1374312..e91b1be 100644
--- a/drivers/video/via/viafbdev.c
+++ b/drivers/video/via/viafbdev.c
@@ -956,7 +956,7 @@ static void viafb_imageblit(struct fb_info *info,
 	u32 size, bg_col = 0, fg_col = 0, *udata;
 	int i;
 
-	if (!viafb_accel) {
+	if (!viafb_accel || image->depth != 1) {
 		cfb_imageblit(info, image);
 		return;
 	}
-- 
1.6.2.5
