From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH TRIVIAL] pm3fb: Fix compile error if
	module
Date: Sat, 12 May 2007 22:03:48 +0800
Message-ID: <4645C944.1040301@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HmsCT-0005HG-Ce for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 12 May 2007 07:03:57 -0700
Received: from py-out-1112.google.com ([64.233.166.178])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HmsCQ-0007xe-U2
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 12 May 2007 07:03:57 -0700
Received: by py-out-1112.google.com with SMTP id a29so1079522pyi
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sat, 12 May 2007 07:03:54 -0700 (PDT)
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
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

pm3fb_setup() should only compiled if pm3fb is built statically in the kernel.

Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/pm3fb.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/pm3fb.c b/drivers/video/pm3fb.c
index 6c4dfcb..c77a1a1 100644
--- a/drivers/video/pm3fb.c
+++ b/drivers/video/pm3fb.c
@@ -985,7 +985,7 @@ static void __exit pm3fb_exit(void)
 	pci_unregister_driver(&pm3fb_driver);
 }
 
-#ifdef MODULE
+#ifndef MODULE
 	/*
 	 *  Setup
 	 */

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
