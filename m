From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: [PATCH] fbdev: trivial fb_get_options fix for cyber2000fb and bw2fb
Date: Tue, 12 Oct 2004 09:04:33 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200410120904.35862.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CHB5u-0002eh-89
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 11 Oct 2004 18:04:50 -0700
Received: from smtp-out.hotpop.com ([38.113.3.51])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CHB5q-0000Ar-NQ
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 11 Oct 2004 18:04:50 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 7BFF175690
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 12 Oct 2004 01:04:38 +0000 (UTC)
Content-Disposition: inline
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
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Trivial fb_get_options fix for 
- cyber200fb
- bw2fb

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 bw2.c         |    2 +-
 cyber2000fb.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff -uprN linux-2.6.9-rc3-mm3-orig/drivers/video/bw2.c linux-2.6.9-rc3-mm3/drivers/video/bw2.c
--- linux-2.6.9-rc3-mm3-orig/drivers/video/bw2.c	2004-10-12 08:57:28.613795144 +0800
+++ linux-2.6.9-rc3-mm3/drivers/video/bw2.c	2004-10-12 08:56:51.244476144 +0800
@@ -386,7 +386,7 @@ int __init bw2_init(void)
 	struct sbus_bus *sbus;
 	struct sbus_dev *sdev;
 
-	if (fb_get_options("bw2fb", &option))
+	if (fb_get_options("bw2fb", NULL))
 		return -ENODEV;
 
 #ifdef CONFIG_SUN4
diff -uprN linux-2.6.9-rc3-mm3-orig/drivers/video/cyber2000fb.c linux-2.6.9-rc3-mm3/drivers/video/cyber2000fb.c
--- linux-2.6.9-rc3-mm3-orig/drivers/video/cyber2000fb.c	2004-10-12 08:57:33.672026176 +0800
+++ linux-2.6.9-rc3-mm3/drivers/video/cyber2000fb.c	2004-10-12 08:56:59.958151464 +0800
@@ -1724,7 +1724,7 @@ int __init cyber2000fb_init(void)
 #ifndef MODULE
 	char *option = NULL;
 
-	if (fb_get_options("cyber2000fb", NULL))
+	if (fb_get_options("cyber2000fb", &option))
 		return -ENODEV;
 	cyber2000fb_setup(option);
 #endif




-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
