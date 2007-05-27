From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 2/9] vt8623fb: arkfb: null pointer
	dereference fix
Date: Sun, 27 May 2007 08:46:52 +0800
Message-ID: <4658D4FC.3010305@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HsFPR-0001vM-PK for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 27 May 2007 02:51:34 -0700
Received: from py-out-1112.google.com ([64.233.166.177])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HsFPQ-0003fW-Vj
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 27 May 2007 02:51:33 -0700
Received: by py-out-1112.google.com with SMTP id u77so2302792pyb
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 27 May 2007 02:51:32 -0700 (PDT)
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

From: Ondrej Zajicek <santiago@crfreenet.org>

This patch prevents null pointer dereference in arkfb and vt8623fb.

Signed-off-by: Ondrej Zajicek <santiago@crfreenet.org>
Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/arkfb.c    |    3 ++-
 drivers/video/vt8623fb.c |    3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/video/arkfb.c b/drivers/video/arkfb.c
index ba6fede..8a1b07c 100644
--- a/drivers/video/arkfb.c
+++ b/drivers/video/arkfb.c
@@ -1055,9 +1055,10 @@ err_enable_device:
 static void __devexit ark_pci_remove(struct pci_dev *dev)
 {
 	struct fb_info *info = pci_get_drvdata(dev);
-	struct arkfb_info *par = info->par;
 
 	if (info) {
+		struct arkfb_info *par = info->par;
+
 #ifdef CONFIG_MTRR
 		if (par->mtrr_reg >= 0) {
 			mtrr_del(par->mtrr_reg, 0, 0);
diff --git a/drivers/video/vt8623fb.c b/drivers/video/vt8623fb.c
index 5e9755e..30c0b94 100644
--- a/drivers/video/vt8623fb.c
+++ b/drivers/video/vt8623fb.c
@@ -778,9 +778,10 @@ err_enable_device:
 static void __devexit vt8623_pci_remove(struct pci_dev *dev)
 {
 	struct fb_info *info = pci_get_drvdata(dev);
-	struct vt8623fb_info *par = info->par;
 
 	if (info) {
+		struct vt8623fb_info *par = info->par;
+
 #ifdef CONFIG_MTRR
 		if (par->mtrr_reg >= 0) {
 			mtrr_del(par->mtrr_reg, 0, 0);


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
