From: Adrian Bunk <bunk@stusta.de>
Subject: [2.6 patch] savagefb.c: make some code static
Date: Wed, 2 Feb 2005 20:52:37 +0100
Message-ID: <20050202195237.GJ3313@stusta.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CwQZA-0002Vz-Fn
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 02 Feb 2005 11:53:32 -0800
Received: from mailout.stusta.mhn.de ([141.84.69.5])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1CwQZ8-00061E-Pv
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 02 Feb 2005 11:53:32 -0800
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
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@osdl.org>
Cc: Denis Oliver Kropp <dok@directfb.org>, Sven Neumann <neo@directfb.org>, Antonino Daplas <adaplas@pol.net>, linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net

The patch below makes some needlessly global code static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 21 Nov 2004

 drivers/video/savage/savagefb.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

--- linux-2.6.10-rc2-mm2-full/drivers/video/savage/savagefb.c.old	2004-11-21 14:57:29.000000000 +0100
+++ linux-2.6.10-rc2-mm2-full/drivers/video/savage/savagefb.c	2004-11-21 14:58:53.000000000 +0100
@@ -1458,7 +1458,7 @@
 }
 
 
-void savage_disable_mmio (struct savagefb_par *par)
+static void savage_disable_mmio (struct savagefb_par *par)
 {
 	unsigned char val;
 
@@ -2241,7 +2241,7 @@
 
 /* ************************* init in-kernel code ************************** */
 
-int __init savagefb_setup(char *options)
+static int __init savagefb_setup(char *options)
 {
 #ifndef MODULE
 	char *this_opt;
@@ -2256,7 +2256,7 @@
 	return 0;
 }
 
-int __init savagefb_init(void)
+static int __init savagefb_init(void)
 {
 	char *option;
 



-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
