From: Randy Dunlap <rdunlap@infradead.org>
Date: Sat, 07 Jul 2018 15:29:36 +0000
Subject: [PATCH] fbdev/via: fix defined but not used warning
Message-Id: <16ceee68-cead-0bfa-755c-d3e78ba0cfe3@infradead.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

From: Randy Dunlap <rdunlap@infradead.org>

Fix a build warning in viafbdev.c when CONFIG_PROC_FS is not enabled
by marking the unused function as __maybe_unused.

../drivers/video/fbdev/via/viafbdev.c:1471:12: warning: 'viafb_sup_odev_proc_show' defined but not used [-Wunused-function]

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: linux-fbdev@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: dri-devel@lists.freedesktop.org
---
 drivers/video/fbdev/via/viafbdev.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- linux-next-20180706.orig/drivers/video/fbdev/via/viafbdev.c
+++ linux-next-20180706/drivers/video/fbdev/via/viafbdev.c
@@ -19,6 +19,7 @@
  * 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
  */
 
+#include <linux/compiler.h>
 #include <linux/module.h>
 #include <linux/seq_file.h>
 #include <linux/slab.h>
@@ -1468,7 +1469,7 @@ static const struct file_operations viaf
 
 #endif /* CONFIG_FB_VIA_DIRECT_PROCFS */
 
-static int viafb_sup_odev_proc_show(struct seq_file *m, void *v)
+static int __maybe_unused viafb_sup_odev_proc_show(struct seq_file *m, void *v)
 {
 	via_odev_to_seq(m, supported_odev_map[
 		viaparinfo->shared->chip_info.gfx_chip_name]);


