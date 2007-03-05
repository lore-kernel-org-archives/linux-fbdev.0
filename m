From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 3/4] atyfb: Fix kconfig error part 2
Date: Mon, 05 Mar 2007 17:52:36 +0800
Message-ID: <45EBE864.5000707@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HO9rx-0000ax-6c for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 05 Mar 2007 01:52:37 -0800
Received: from nz-out-0506.google.com ([64.233.162.239])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HO9rw-0003eB-SB
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 05 Mar 2007 01:52:37 -0800
Received: by nz-out-0506.google.com with SMTP id i11so2494886nzi
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 05 Mar 2007 01:52:36 -0800 (PST)
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@osdl.org>
Cc: Randy Dunlap <randy.dunlap@oracle.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

From: Randy Dunlap <randy.dunlap@oracle.com>

Fix implicit declarations and missing code in atyfb.

drivers/video/aty/atyfb_base.c:2137: warning: implicit declaration of function 'a
ty_ld_lcd'
drivers/video/aty/atyfb_base.c:2154: warning: implicit declaration of function 'a
ty_st_lcd'
atyfb_base.c:(.text+0x33e5c): undefined reference to `aty_ld_lcd'
atyfb_base.c:(.text+0x33eb2): undefined reference to `aty_st_lcd'

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/aty/atyfb.h |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/video/aty/atyfb.h b/drivers/video/aty/atyfb.h
index f72faff..dc62f8e 100644
--- a/drivers/video/aty/atyfb.h
+++ b/drivers/video/aty/atyfb.h
@@ -284,7 +284,8 @@ #else
 #endif
 }
 
-#if defined(CONFIG_PM) || defined(CONFIG_PMAC_BACKLIGHT) || defined (CONFIG_FB_ATY_GENERIC_LCD)
+#if defined(CONFIG_PM) || defined(CONFIG_PMAC_BACKLIGHT) || \
+defined (CONFIG_FB_ATY_GENERIC_LCD) || defined (CONFIG_FB_ATY_BACKLIGHT)
 extern void aty_st_lcd(int index, u32 val, const struct atyfb_par *par);
 extern u32 aty_ld_lcd(int index, const struct atyfb_par *par);
 #endif


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
