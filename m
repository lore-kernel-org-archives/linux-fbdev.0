From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: [PATCH 6/11] atyfb: Fix module parameter descriptions
Date: Thu, 13 Jan 2005 21:01:39 +0800
Message-ID: <20050113214636.7E7B51A0165@smtp-1.hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CpCo2-00015n-QH
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 13 Jan 2005 13:47:02 -0800
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CpCny-00006X-AF
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 13 Jan 2005 13:47:01 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 41480CD1CA6
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 13 Jan 2005 21:46:45 +0000 (UTC)
Content-Disposition: inline
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
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Magnus Damm <magnus.damm@gmail.com>

  This patch syncs up the module parameter descriptions in aty128fb for module
  parameters "mode_option" and "nomtrr". Without the patch bad parameter names
  are used with MODULE_PARM_DESC().

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 aty128fb.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -Nru a/drivers/video/aty/aty128fb.c b/drivers/video/aty/aty128fb.c
--- a/drivers/video/aty/aty128fb.c	2005-01-12 06:10:17 +08:00
+++ b/drivers/video/aty/aty128fb.c	2005-01-09 01:11:50 +08:00
@@ -2430,10 +2430,10 @@
 MODULE_DESCRIPTION("FBDev driver for ATI Rage128 / Pro cards");
 MODULE_LICENSE("GPL");
 module_param(mode_option, charp, 0);
-MODULE_PARM_DESC(mode, "Specify resolution as \"<xres>x<yres>[-<bpp>][@<refresh>]\" ");
+MODULE_PARM_DESC(mode_option, "Specify resolution as \"<xres>x<yres>[-<bpp>][@<refresh>]\" ");
 #ifdef CONFIG_MTRR
 module_param_named(nomtrr, mtrr, invbool, 0);
-MODULE_PARM_DESC(mtrr, "bool: Disable MTRR support (0 or 1=disabled) (default=0)");
+MODULE_PARM_DESC(nomtrr, "bool: Disable MTRR support (0 or 1=disabled) (default=0)");
 #endif
 #endif
 




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
