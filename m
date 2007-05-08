From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH] vt8623fb: Fix compile error if
	CONFIG_MTRR=n
Date: Tue, 08 May 2007 20:28:21 +0800
Message-ID: <46406CE5.6040309@gmail.com>
References: <463C996A.9050005@gmail.com>
	<20070507232837.d3dfcfb4.akpm@linux-foundation.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HlOoq-00035u-EY for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 08 May 2007 05:29:28 -0700
Received: from wx-out-0506.google.com ([66.249.82.230])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HlOop-00082A-1r
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 08 May 2007 05:29:28 -0700
Received: by wx-out-0506.google.com with SMTP id i30so3056304wxd
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Tue, 08 May 2007 05:29:26 -0700 (PDT)
In-Reply-To: <20070507232837.d3dfcfb4.akpm@linux-foundation.org>
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Fix compile error if CONFIG_MTRR=n

Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---
Andrew Morton wrote:
> On Sat, 05 May 2007 22:49:14 +0800 "Antonino A. Daplas" <adaplas@gmail.com> wrote:
> 
>> This patch adds fbdev driver for graphics core in VIA VT8623
> 
> Is bust with CONFIG_MTRR=n
> 
> drivers/video/vt8623fb.c: In function `vt8623_pci_remove':
> drivers/video/vt8623fb.c:797: error: `par' undeclared (first use in this function)
> drivers/video/vt8623fb.c:797: error: (Each undeclared identifier is reported only once
> drivers/video/vt8623fb.c:797: error: for each function it appears in.)
> 
> (that's ia64)

 drivers/video/vt8623fb.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/drivers/video/vt8623fb.c b/drivers/video/vt8623fb.c
index 414e76b..5e9755e 100644
--- a/drivers/video/vt8623fb.c
+++ b/drivers/video/vt8623fb.c
@@ -778,12 +778,10 @@ err_enable_device:
 static void __devexit vt8623_pci_remove(struct pci_dev *dev)
 {
 	struct fb_info *info = pci_get_drvdata(dev);
+	struct vt8623fb_info *par = info->par;
 
 	if (info) {
-
 #ifdef CONFIG_MTRR
-		struct vt8623fb_info *par = info->par;
-
 		if (par->mtrr_reg >= 0) {
 			mtrr_del(par->mtrr_reg, 0, 0);
 			par->mtrr_reg = -1;


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
