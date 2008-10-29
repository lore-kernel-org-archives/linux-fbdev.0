From: roel kluin <roel.kluin@gmail.com>
Subject: [PATCH] gbefb: unsigned var->pixclock cannot be
	less than 0
Date: Wed, 29 Oct 2008 17:29:51 -0400
Message-ID: <4908D5CF.5080103@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <roel.kluin@gmail.com>) id 1KvIc4-0005Ll-5u
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 29 Oct 2008 21:30:00 +0000
Received: from ug-out-1314.google.com ([66.249.92.169])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1KvIc1-0006PM-QW for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 29 Oct 2008 21:30:00 +0000
Received: by ug-out-1314.google.com with SMTP id 36so857151uga.17
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 29 Oct 2008 14:29:55 -0700 (PDT)
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: adaplas@gmail.com, linux-fbdev-devel@lists.sourceforge.net

unsigned var->pixclock cannot be less than 0

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
diff --git a/drivers/video/gbefb.c b/drivers/video/gbefb.c
index f89c3cc..a386443 100644
--- a/drivers/video/gbefb.c
+++ b/drivers/video/gbefb.c
@@ -912,6 +912,7 @@ static int gbefb_check_var(struct fb_var_screeninfo *var, struct fb_info *info)
 {
 	unsigned int line_length;
 	struct gbe_timing_info timing;
+	int ret;
 
 	/* Limit bpp to 8, 16, and 32 */
 	if (var->bits_per_pixel <= 8)
@@ -930,8 +931,10 @@ static int gbefb_check_var(struct fb_var_screeninfo *var, struct fb_info *info)
 
 	var->grayscale = 0;	/* No grayscale for now */
 
-	if ((var->pixclock = compute_gbe_timing(var, &timing)) < 0)
+	ret = compute_gbe_timing(var, &timing);
+	if (ret < 0)
 		return(-EINVAL);
+	var->pixclock = ret;
 
 	/* Adjust virtual resolution, if necessary */
 	if (var->xres > var->xres_virtual || (!ywrap && !ypan))


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
