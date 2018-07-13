From: YueHaibing <yuehaibing@huawei.com>
Date: Fri, 13 Jul 2018 07:56:25 +0000
Subject: [PATCH] video: fbdev: via: hide unused procfs helpers
Message-Id: <20180713075625.11252-1-yuehaibing@huawei.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: FlorianSchandinat@gmx.de, b.zolnierkie@samsung.com
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>

When CONFIG_PROC_FS isn't set, gcc warning this:

drivers/video/fbdev/via/viafbdev.c:1471:12: warning: ‘viafb_sup_odev_proc_show’ defined but not used [-Wunused-function]
 static int viafb_sup_odev_proc_show(struct seq_file *m, void *v)
            ^
fix this by adding #ifdef around it.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/video/fbdev/via/viafbdev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/video/fbdev/via/viafbdev.c b/drivers/video/fbdev/via/viafbdev.c
index d2f7850..edca3e0 100644
--- a/drivers/video/fbdev/via/viafbdev.c
+++ b/drivers/video/fbdev/via/viafbdev.c
@@ -1468,12 +1468,14 @@ static const struct file_operations viafb_vt1636_proc_fops = {
 
 #endif /* CONFIG_FB_VIA_DIRECT_PROCFS */
 
+#ifdef CONFIG_PROC_FS
 static int viafb_sup_odev_proc_show(struct seq_file *m, void *v)
 {
 	via_odev_to_seq(m, supported_odev_map[
 		viaparinfo->shared->chip_info.gfx_chip_name]);
 	return 0;
 }
+#endif
 
 static ssize_t odev_update(const char __user *buffer, size_t count, u32 *odev)
 {
-- 
2.7.0


