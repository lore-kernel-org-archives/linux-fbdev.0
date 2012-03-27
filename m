From: Wang YanQing <udknight@gmail.com>
Date: Tue, 27 Mar 2012 10:01:36 +0000
Subject: [PATCH] video:uvesafb: Fix oops that uvesafb try to execute NX-protected page
Message-Id: <20120327100136.GA3829@udknight>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20120302004850.GA4139@udknight>
In-Reply-To: <20120302004850.GA4139@udknight>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: FlorianSchandinat@gmx.de
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, spock@gentoo.org


Ok! I try to check pcibios_enabled first, but get some opposition by Alan Cox,
but I want to make thing work and fix the oops, so I choice the simple way to
check the (__supported_pte_mask & _PAGE_NX) instead of to check this variable plus
pci kernel boot parameter, pci mmconfig works or not, and more, and more. It is not
the best method, but it works and maybe all will feel happy.

Signed-off-by: Wang YanQing <udknight@gmail.com>
---
 drivers/video/uvesafb.c |   11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/video/uvesafb.c b/drivers/video/uvesafb.c
index 260cca7..26e83d7 100644
--- a/drivers/video/uvesafb.c
+++ b/drivers/video/uvesafb.c
@@ -815,8 +815,15 @@ static int __devinit uvesafb_vbe_init(struct fb_info *info)
 	par->pmi_setpal = pmi_setpal;
 	par->ypan = ypan;
 
-	if (par->pmi_setpal || par->ypan)
-		uvesafb_vbe_getpmi(task, par);
+	if (par->pmi_setpal || par->ypan) {
+		if (__supported_pte_mask & _PAGE_NX) {
+			par->pmi_setpal = par->ypan = 0;
+			printk(KERN_WARNING "uvesafb: NX protection is actively."
+				"We have better not to use the PMI.\n");
+		} else {
+			uvesafb_vbe_getpmi(task, par);
+		}
+	}
 #else
 	/* The protected mode interface is not available on non-x86. */
 	par->pmi_setpal = par->ypan = 0;
-- 
1.7.9.2.315.g25a78
