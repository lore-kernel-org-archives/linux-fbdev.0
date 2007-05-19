From: Ondrej Zajicek <santiago@crfreenet.org>
Subject: Fixes for vt8623fb and arkfb drivers
Date: Sat, 19 May 2007 14:41:39 +0200
Message-ID: <20070519124139.GB19191@localhost.localdomain>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HpOFn-000633-Fq for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 19 May 2007 05:41:51 -0700
Received: from gateway.crfreenet.org
	([81.92.146.254] helo=mail.crfreenet.org ident=postfix)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HpOFl-0000NK-9Q
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 19 May 2007 05:41:46 -0700
Content-Disposition: inline
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
To: torvalds@linux-foundation.org
Cc: linux-fbdev-devel@lists.sourceforge.net, adaplas@gmail.com


This patch prevents null pointer dereference in arkfb and vt8623fb.

It is against linux-2.6.22-rc2


Signed-off-by: Ondrej Zajicek <santiago@crfreenet.org>
 
---

diff -uprN -X linux-2.6.22-rc2/Documentation/dontdiff linux-2.6.22-rc2/drivers/video/arkfb.c linux-2.6.22-rc2-fixed/drivers/video/arkfb.c
--- linux-2.6.22-rc2/drivers/video/arkfb.c	2007-05-19 14:12:23.000000000 +0200
+++ linux-2.6.22-rc2-fixed/drivers/video/arkfb.c	2007-05-19 14:05:08.000000000 +0200
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
diff -uprN -X linux-2.6.22-rc2/Documentation/dontdiff linux-2.6.22-rc2/drivers/video/vt8623fb.c linux-2.6.22-rc2-fixed/drivers/video/vt8623fb.c
--- linux-2.6.22-rc2/drivers/video/vt8623fb.c	2007-05-19 14:12:23.000000000 +0200
+++ linux-2.6.22-rc2-fixed/drivers/video/vt8623fb.c	2007-05-19 13:46:21.000000000 +0200
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


-- 
Elen sila lumenn' omentielvo

Ondrej 'SanTiago' Zajicek (email: santiago@mail.cz, jabber: santiago@njs.netlab.cz)
OpenPGP encrypted e-mails preferred (KeyID 0x11DEADC3, wwwkeys.pgp.net)
"To err is human -- to blame it on a computer is even more so."

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
