From: "Randy.Dunlap" <rddunlap@osdl.org>
Subject: [PATCH] radeonfb: fix init/exit section usage
Date: Fri, 07 Jan 2005 11:28:07 -0800
Message-ID: <41DEE2C7.4030200@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020701060509080704000401"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Cn0Sm-0005mW-9L
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 07 Jan 2005 12:12:00 -0800
Received: from fire.osdl.org ([65.172.181.4] helo=fire-1.osdl.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1Cn0Sj-0006OU-VY
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 07 Jan 2005 12:11:59 -0800
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
To: ajoshi@shell.unixbox.com, linux-fbdev-devel@lists.sourceforge.net, adaplas@pol.net

This is a multi-part message in MIME format.
--------------020701060509080704000401
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


Fix 3 instances of calling exit section function from text or init:
Error: ./drivers/video/aty/radeon_base.o .text refers to 000029e5 
R_386_PC32        .exit.text
Error: ./drivers/video/aty/radeon_base.o .text refers to 00002a60 
R_386_PC32        .exit.text
Error: ./drivers/video/aty/radeon_base.o .init.text refers to 00000192 
R_386_PC32        .exit.text

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>

diffstat:=
  drivers/video/aty/radeon_base.c |    2 +-
  1 files changed, 1 insertion(+), 1 deletion(-)

---

--------------020701060509080704000401
Content-Type: text/x-patch;
 name="radeonfb_init_exit.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="radeonfb_init_exit.patch"


diff -Naurp ./drivers/video/aty/radeon_base.c~radeonfb_initexit ./drivers/video/aty/radeon_base.c
--- ./drivers/video/aty/radeon_base.c~radeonfb_initexit	2005-01-06 21:18:20.920585008 -0800
+++ ./drivers/video/aty/radeon_base.c	2005-01-07 10:30:16.661094480 -0800
@@ -261,7 +261,7 @@ static struct backlight_controller radeo
 
 #endif /* CONFIG_PPC_OF */
 
-static void __devexit radeon_unmap_ROM(struct radeonfb_info *rinfo, struct pci_dev *dev)
+static void radeon_unmap_ROM(struct radeonfb_info *rinfo, struct pci_dev *dev)
 {
 	if (!rinfo->bios_seg)
 		return;

--------------020701060509080704000401--


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
