From: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: [PATCH] au1100fb: use preprocessor instruction for error
Date: Sun, 2 Oct 2005 17:15:37 -0700
Message-ID: <20051002171537.4324e9e4.rdunlap@xenotime.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EMDzd-0000CM-9q
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 02 Oct 2005 17:15:45 -0700
Received: from xenotime.net ([66.160.160.81])
	by mail.sourceforge.net with smtp (Exim 4.44)
	id 1EMDzc-0004b7-WB
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 02 Oct 2005 17:15:45 -0700
Received: from midway ([71.111.157.99]) by xenotime.net for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 2 Oct 2005 17:15:39 -0700
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
To: adaplas@pol.net, akpm <akpm@osdl.org>
Cc: linux-fbdev-devel@lists.sourceforge.net

From: Randy Dunlap <rdunlap@xenotime.net>

Use #preprocessor to generate an error instead of a warning
that may be missed.
(or was this done intentionally?)

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---

 drivers/video/au1100fb.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -Naurp linux-2614-rc2-git6/drivers/video/au1100fb.c~au11fb_unknown linux-2614-rc2-git6/drivers/video/au1100fb.c
--- linux-2614-rc2-git6/drivers/video/au1100fb.c~au11fb_unknown	2005-08-28 16:41:01.000000000 -0700
+++ linux-2614-rc2-git6/drivers/video/au1100fb.c	2005-10-02 16:28:27.000000000 -0700
@@ -63,7 +63,7 @@
  */
 #if defined(CONFIG_MIPS_PB1100) || defined(CONFIG_MIPS_DB1100) || defined(CONFIG_MIPS_HYDROGEN3)
 #else
-error Unknown Au1100 board
+#error Unknown Au1100 board
 #endif
 
 #define CMAPSIZE 16


---


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
