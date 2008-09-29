From: Kristoffer Ericson <kristoffer.ericson@gmail.com>
Subject: Allow more revisions in epson s1d13... driver
Date: Mon, 29 Sep 2008 15:47:35 +0200
Message-ID: <20080929154735.a7cc4a29.kristoffer.ericson@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <kristoffer.ericson@gmail.com>) id 1KkJ6q-0001kY-6g
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 29 Sep 2008 13:48:20 +0000
Received: from ey-out-1920.google.com ([74.125.78.147])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1KkJ6l-0005Tb-0I for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 29 Sep 2008 13:48:20 +0000
Received: by ey-out-1920.google.com with SMTP id 4so506233eyk.4
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 29 Sep 2008 06:48:12 -0700 (PDT)
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: akpm@linux-foundation.org
Cc: "linux-fbdev-devel@lists.sourceforge.net" <linux-fbdev-devel@lists.sourceforge.net>, varenet@parisc-linux.org

Andrew,

I've been trying to get someones attention to this patch. Currently the
file in question is without maintainer. 
Ive however talked to Author Thiabaut Varene and adapted according
to his suggestions (he's cc'ed in this mail).

Is there anyone special that I should email?

/Kristoffer

Patch included below.

-----------------

The Epson s1d13xxx hardware is common in many handhelds, but our
driver is currently locked to a single chip revision. This patch
adds an array of known to work revisions (which can be extended).

Signed-off-by: Kristoffer Ericson <Kristoffer.Ericson@gmail.com>

diff --git a/drivers/video/s1d13xxxfb.c b/drivers/video/s1d13xxxfb.c
index b829dc7..c674949 100644
--- a/drivers/video/s1d13xxxfb.c
+++ b/drivers/video/s1d13xxxfb.c
@@ -50,6 +50,11 @@
 #define dbg(fmt, args...) do { } while (0)
 #endif
 
+static const int s1d13xxxfb_revisions[] = {
+	S1D13506_CHIP_REV,/* Rev.4 on HP Jornada 7xx S1D13506 */
+	S1D13806_CHIP_REV /* Rev.7 on .. */
+};
+
 /*
  * Here we define the default struct fb_fix_screeninfo
  */
@@ -538,6 +543,7 @@ s1d13xxxfb_probe(struct platform_device *pdev)
 	struct fb_info *info;
 	struct s1d13xxxfb_pdata *pdata = NULL;
 	int ret = 0;
+	int i;
 	u8 revision;
 
 	dbg("probe called: device is %p\n", pdev);
@@ -607,10 +613,19 @@ s1d13xxxfb_probe(struct platform_device *pdev)
 		goto bail;
 	}
 
-	revision = s1d13xxxfb_readreg(default_par, S1DREG_REV_CODE);
-	if ((revision >> 2) != S1D_CHIP_REV) {
-		printk(KERN_INFO PFX "chip not found: %i\n", (revision >> 2));
-		ret = -ENODEV;
+	revision = s1d13xxxfb_readreg(default_par, S1DREG_REV_CODE) >> 2;
+
+	ret = -ENODEV;
+
+	for (i = 0; i < ARRAY_SIZE(s1d13xxxfb_revisions); i++) {
+		if (revision == s1d13xxxfb_revisions[i])
+			ret = 0;
+	}
+
+	if (!ret)
+		printk(KERN_INFO PFX "chip revision %i\n", (revision));
+	else {
+		printk(KERN_INFO PFX "unknown chip revision %i\n", (revision));
 		goto bail;
 	}
 
diff --git a/include/video/s1d13xxxfb.h b/include/video/s1d13xxxfb.h
index c99d261..fe41b84 100644
--- a/include/video/s1d13xxxfb.h
+++ b/include/video/s1d13xxxfb.h
@@ -14,7 +14,8 @@
 #define	S1D13XXXFB_H
 
 #define S1D_PALETTE_SIZE		256
-#define S1D_CHIP_REV			7	/* expected chip revision number for s1d13806 */
+#define S1D13506_CHIP_REV		4	/* expected chip revision number for s1d13506 */
+#define S1D13806_CHIP_REV		7	/* expected chip revision number for s1d13806 */
 #define S1D_FBID			"S1D13806"
 #define S1D_DEVICENAME			"s1d13806fb"
 




-- 
Kristoffer Ericson <kristoffer.ericson@gmail.com>

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
