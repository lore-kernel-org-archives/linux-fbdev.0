From: Jim Hague <jim.hague@acm.org>
Subject: [PATCH 3/4] pm2fb: use modedb in modules
Date: Tue, 7 Dec 2004 11:49:56 +0000
Message-ID: <20041207114956.79f8baca@hagrid.bear-cave.org.uk>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Cbdr7-00030q-IZ
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 07 Dec 2004 03:50:09 -0800
Received: from cpc1-oxfd2-6-0-cust43.oxfd.cable.ntl.com ([81.103.191.43] helo=fluffy.bear-cave.org.uk)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1Cbdr2-0002Vu-8H
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 07 Dec 2004 03:50:09 -0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: linux-fbdev-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>, Antonino Daplas <adaplas@pol.net>


- modedb is now available in modules.

Signed-off-by: Jim Hague <jim.hague@acm.org>

=== a/drivers/video/pm2fb.c
==================================================================
--- a/drivers/video/pm2fb.c  (revision 106)
+++ b/drivers/video/pm2fb.c  (revision 107)
@@ -112,8 +112,7 @@
 };
 
 /*
- * Default video mode. In case the modedb doesn't work, or we're
- * a module (in which case modedb doesn't really work).
+ * Default video mode. In case the modedb doesn't work.
  */
 static struct fb_var_screeninfo pm2fb_var __initdata = {
 	/* "640x480, 8 bpp @ 60 Hz */
@@ -1153,13 +1152,11 @@
 	info->flags		= FBINFO_DEFAULT |
                                   FBINFO_HWACCEL_YPAN;
 
-#ifndef MODULE
 	if (!mode)
 		mode = "640x480@60";
 	 
 	err = fb_find_mode(&info->var, info, mode, NULL, 0, NULL, 8); 
 	if (!err || err == 4)
-#endif
 		info->var = pm2fb_var;
 
 	if (fb_alloc_cmap(&info->cmap, 256, 0) < 0)


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
