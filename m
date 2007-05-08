From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH] arkfb: Fix compile error if
	CONFIG_MTRR=n
Date: Tue, 08 May 2007 20:26:49 +0800
Message-ID: <46406C89.50702@gmail.com>
References: <463C9A29.4010505@gmail.com>
	<20070507233102.3ed6c42d.akpm@linux-foundation.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HlOoI-0002yg-Ol for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 08 May 2007 05:28:58 -0700
Received: from wx-out-0506.google.com ([66.249.82.225])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HlOoI-0008Db-Db
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 08 May 2007 05:28:54 -0700
Received: by wx-out-0506.google.com with SMTP id i30so3055739wxd
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Tue, 08 May 2007 05:28:54 -0700 (PDT)
In-Reply-To: <20070507233102.3ed6c42d.akpm@linux-foundation.org>
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
> On Sat, 05 May 2007 22:52:25 +0800 "Antonino A. Daplas" <adaplas@gmail.com> wrote:
> 
>> This patch adds fbdev driver for graphics cards with
>> ARK Logic 2000PV graphics chip with ICS 5342 ramdac.
> 
> also breaks with CONFIG_MTRR=n

 drivers/video/arkfb.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/drivers/video/arkfb.c b/drivers/video/arkfb.c
index 7155508..a0c4d22 100644
--- a/drivers/video/arkfb.c
+++ b/drivers/video/arkfb.c
@@ -1055,12 +1055,10 @@ err_enable_device:
 static void __devexit ark_pci_remove(struct pci_dev *dev)
 {
 	struct fb_info *info = pci_get_drvdata(dev);
+	struct arkfb_info *par = info->par;
 
 	if (info) {
-
 #ifdef CONFIG_MTRR
-		struct arkfb_info *par = info->par;
-
 		if (par->mtrr_reg >= 0) {
 			mtrr_del(par->mtrr_reg, 0, 0);
 			par->mtrr_reg = -1;


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
