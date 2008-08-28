From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH 3/4] cirrusfb: remove 24 bpp mode
Date: Thu, 28 Aug 2008 22:13:35 +0200
Message-ID: <20080828221335.4f5fabe9.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KYnlo-0005bT-Jo for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 28 Aug 2008 13:07:04 -0700
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KYnlo-0006qT-8K
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 28 Aug 2008 13:07:04 -0700
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>
Cc: Andrew Morton <akpm@linux-foundation.org>

From: Krzysztof Helt <krzysztof.h1@wp.pl>

The 24 bpp mode is not implemented.
Disallow it in the cirrusfb_check_var()
and remove it from checks.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---
 drivers/video/cirrusfb.c |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/video/cirrusfb.c b/drivers/video/cirrusfb.c
index dfd12a2..4888ff6 100644
--- a/drivers/video/cirrusfb.c
+++ b/drivers/video/cirrusfb.c
@@ -638,7 +638,6 @@ static int cirrusfb_check_var(struct fb_var_screeninfo *var,
 		break;		/* 8 pixel per byte, only 1/4th of mem usable */
 	case 8:
 	case 16:
-	case 24:
 	case 32:
 		break;		/* 1 pixel == 1 byte */
 	default:
@@ -713,7 +712,6 @@ static int cirrusfb_check_var(struct fb_var_screeninfo *var,
 		var->blue.length = 5;
 		break;
 
-	case 24:
 	case 32:
 		if (isPReP) {
 			var->red.offset = 8;
@@ -782,7 +780,6 @@ static int cirrusfb_decode_var(const struct fb_var_screeninfo *var,
 		break;
 
 	case 16:
-	case 24:
 	case 32:
 		info->fix.line_length = var->xres_virtual * maxclockidx;
 		info->fix.visual = FB_VISUAL_DIRECTCOLOR;
@@ -1360,7 +1357,7 @@ static int cirrusfb_set_par_foo(struct fb_info *info)
 	 */
 
 	else if (var->bits_per_pixel == 32) {
-		DPRINTK("cirrusfb: preparing for 24/32 bit deep display\n");
+		DPRINTK("cirrusfb: preparing for 32 bit deep display\n");
 		switch (cinfo->btype) {
 		case BT_SD64:
 			/* Extended Sequencer Mode: 256c col. mode */
@@ -2233,7 +2230,7 @@ static int cirrusfb_set_fbinfo(struct fb_info *info)
 	if (cinfo->btype == BT_GD5480) {
 		if (var->bits_per_pixel == 16)
 			info->screen_base += 1 * MB_;
-		if (var->bits_per_pixel == 24 || var->bits_per_pixel == 32)
+		if (var->bits_per_pixel == 32)
 			info->screen_base += 2 * MB_;
 	}
 
-- 
1.5.2.2



----------------------------------------------------------------------
>> Sprawdz, czy do siebie pasujecie!
>> http://link.interia.pl/f1eea


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
