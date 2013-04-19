From: Borislav Petkov <bp@alien8.de>
Date: Fri, 19 Apr 2013 14:05:25 +0000
Subject: [PATCH] uvesafb: Correct/simplify warning message
Message-Id: <1366380325-2038-1-git-send-email-bp@alien8.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Streamline it a bit. No functional change.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Wang YanQing <udknight@gmail.com>
Cc: Michal Januszewski <spock@gentoo.org>
Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: linux-fbdev@vger.kernel.org
---
 drivers/video/uvesafb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/uvesafb.c b/drivers/video/uvesafb.c
index d4284458377e..a309f9fabe8b 100644
--- a/drivers/video/uvesafb.c
+++ b/drivers/video/uvesafb.c
@@ -819,8 +819,8 @@ static int uvesafb_vbe_init(struct fb_info *info)
 	if (par->pmi_setpal || par->ypan) {
 		if (__supported_pte_mask & _PAGE_NX) {
 			par->pmi_setpal = par->ypan = 0;
-			printk(KERN_WARNING "uvesafb: NX protection is actively."
-				"We have better not to use the PMI.\n");
+			printk(KERN_WARNING "uvesafb: NX protection is active, "
+					    "better not use the PMI.\n");
 		} else {
 			uvesafb_vbe_getpmi(task, par);
 		}
-- 
1.8.2.135.g7b592fa

