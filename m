From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: [PATCH 7/11] radeonfb: Fix init/exit section usage
Date: Thu, 13 Jan 2005 21:01:43 +0800
Message-ID: <20050113214644.2FC861A018F@smtp-1.hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CpCo1-00015f-3h
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 13 Jan 2005 13:47:01 -0800
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CpCo0-0000Ff-Kx
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 13 Jan 2005 13:47:01 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id ECAFBCC4C97
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 13 Jan 2005 21:46:47 +0000 (UTC)
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, "Randy.Dunlap" <rddunlap@osdl.org>

  Fix 3 instances of calling exit section function from text or init:
  Error: ./drivers/video/aty/radeon_base.o .text refers to 000029e5
  R_386_PC32        .exit.text
  Error: ./drivers/video/aty/radeon_base.o .text refers to 00002a60
  R_386_PC32        .exit.text
  Error: ./drivers/video/aty/radeon_base.o .init.text refers to 00000192
  R_386_PC32        .exit.text

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>
Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 radeon_base.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -Nru a/drivers/video/aty/radeon_base.c b/drivers/video/aty/radeon_base.c
--- a/drivers/video/aty/radeon_base.c	2005-01-12 06:10:17 +08:00
+++ b/drivers/video/aty/radeon_base.c	2005-01-08 02:30:17 +08:00
@@ -261,7 +261,7 @@
 
 #endif /* CONFIG_PPC_OF */
 
-static void __devexit radeon_unmap_ROM(struct radeonfb_info *rinfo, struct pci_dev *dev)
+static void radeon_unmap_ROM(struct radeonfb_info *rinfo, struct pci_dev *dev)
 {
 	if (!rinfo->bios_seg)
 		return;




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
