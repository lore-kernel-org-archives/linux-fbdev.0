From: akpm@osdl.org
Subject: [patch 068/196] coverity: fix fbsysfs null pointer check
Date: Thu, 07 Jul 2005 17:57:05 -0700
Message-ID: <200507080057.j680vfSQ004464@shell0.pdx.osdl.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DqhBc-00086k-Fz
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 07 Jul 2005 17:57:48 -0700
Received: from smtp.osdl.org ([65.172.181.4])
	by sc8-sf-mx2-new.sourceforge.net with esmtp (Exim 4.44)
	id 1DqhBc-0003vP-8G
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 07 Jul 2005 17:57:48 -0700
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@osdl.org
Cc: akpm@osdl.org, kambarov@berkeley.edu, linux-fbdev-devel@lists.sourceforge.net, zkambarov@coverity.com


From: "KAMBAROV, ZAUR" <kambarov@berkeley.edu>

Correctly test for a null pointer before going and dereferencing it.

This defect was found automatically by Coverity Prevent, a static analysis
tool.

Signed-off-by: Zaur Kambarov <zkambarov@coverity.com>
Cc: <linux-fbdev-devel@lists.sourceforge.net>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/video/fbsysfs.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/video/fbsysfs.c~coverity-fbsysfs-fix-null-pointer-check drivers/video/fbsysfs.c
--- devel/drivers/video/fbsysfs.c~coverity-fbsysfs-fix-null-pointer-check	2005-07-07 17:06:33.000000000 -0700
+++ devel-akpm/drivers/video/fbsysfs.c	2005-07-07 17:06:33.000000000 -0700
@@ -256,7 +256,7 @@ static ssize_t show_cmap(struct class_de
 	unsigned int offset = 0, i;
 
 	if (!fb_info->cmap.red || !fb_info->cmap.blue ||
-	    fb_info->cmap.green || fb_info->cmap.transp)
+	    !fb_info->cmap.green || !fb_info->cmap.transp)
 		return -EINVAL;
 
 	for (i = 0; i < fb_info->cmap.len; i++) {
_


-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP,
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
