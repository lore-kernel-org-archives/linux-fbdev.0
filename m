From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 7/13] vfb: Document option to enable the
	driver
Date: Tue, 01 Aug 2006 07:33:45 +0800
Message-ID: <44CE9359.1090803@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1G7hOY-00038z-3k for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 31 Jul 2006 16:41:58 -0700
Received: from py-out-1112.google.com ([64.233.166.178])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1G7hOX-0004Mn-SA
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 31 Jul 2006 16:41:58 -0700
Received: by py-out-1112.google.com with SMTP id d42so802545pyd
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 31 Jul 2006 16:41:57 -0700 (PDT)
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

From: Mike Frysinger <vapier@gentoo.org>

the Kconfig help text doesnt mention that in order to load the vfb module, you
have to pass in the parameter vfb_enable=1

Document required module options in Kconfig for loading the vfb module.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/Kconfig |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 29aea96..4dc10b7 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -1617,7 +1617,8 @@ config FB_VIRTUAL
 	  kernel option `video=vfb:'.
 
 	  To compile this driver as a module, choose M here: the
-	  module will be called vfb.
+	  module will be called vfb. In order to load it, you must use
+	  the vfb_enable=1 option.
 
 	  If unsure, say N.
 if VT


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
