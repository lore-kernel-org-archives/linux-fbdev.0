From: Mikulas Patocka <mpatocka@redhat.com>
Date: Fri, 30 Jun 2017 02:16:59 +0000
Subject: [PATCH] uvesafb: use pr_cont when printing multiple parameters on the same line
Message-Id: <alpine.LRH.2.02.1706292214580.21823@file01.intranet.prod.int.rdu2.redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michal Januszewski <spock@gentoo.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

The kernel automatically inserts newlines between printk calls unless
pr_cont is used. This patch changes the uvesafb log message from:

[    5.263290] uvesafb:
[    5.263292] SeaBIOS Developers,
[    5.263293] SeaBIOS VBE Adapter,
[    5.263294] Rev. 1,
[    5.263294] OEM: SeaBIOS VBE(C) 2011,
[    5.263295] VBE v3.0
to
[    4.711147] uvesafb: SeaBIOS Developers, SeaBIOS VBE Adapter, Rev. 1, OEM: SeaBIOS VBE(C) 2011, VBE v3.0

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>

---
 drivers/video/fbdev/uvesafb.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

Index: linux-2.6/drivers/video/fbdev/uvesafb.c
=================================--- linux-2.6.orig/drivers/video/fbdev/uvesafb.c
+++ linux-2.6/drivers/video/fbdev/uvesafb.c
@@ -452,22 +452,22 @@ static int uvesafb_vbe_getinfo(struct uv
 	 * video adapter and its vendor.
 	 */
 	if (par->vbe_ib.oem_vendor_name_ptr)
-		printk("%s, ",
+		pr_cont("%s, ",
 			((char *)task->buf) + par->vbe_ib.oem_vendor_name_ptr);
 
 	if (par->vbe_ib.oem_product_name_ptr)
-		printk("%s, ",
+		pr_cont("%s, ",
 			((char *)task->buf) + par->vbe_ib.oem_product_name_ptr);
 
 	if (par->vbe_ib.oem_product_rev_ptr)
-		printk("%s, ",
+		pr_cont("%s, ",
 			((char *)task->buf) + par->vbe_ib.oem_product_rev_ptr);
 
 	if (par->vbe_ib.oem_string_ptr)
-		printk("OEM: %s, ",
+		pr_cont("OEM: %s, ",
 			((char *)task->buf) + par->vbe_ib.oem_string_ptr);
 
-	printk("VBE v%d.%d\n", ((par->vbe_ib.vbe_version & 0xff00) >> 8),
+	pr_cont("VBE v%d.%d\n", ((par->vbe_ib.vbe_version & 0xff00) >> 8),
 			par->vbe_ib.vbe_version & 0xff);
 
 	return 0;
@@ -580,8 +580,8 @@ static int uvesafb_vbe_getpmi(struct uve
 			printk(KERN_INFO "uvesafb: pmi: ports = ");
 			for (i = par->pmi_base[3]/2;
 					par->pmi_base[i] != 0xffff; i++)
-				printk("%x ", par->pmi_base[i]);
-			printk("\n");
+				pr_cont("%x ", par->pmi_base[i]);
+			pr_cont("\n");
 
 			if (par->pmi_base[i] != 0xffff) {
 				printk(KERN_INFO "uvesafb: can't handle memory"
