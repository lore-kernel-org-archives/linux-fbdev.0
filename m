From: objectkuan <objectkuan@gmail.com>
Date: Tue, 17 Dec 2013 16:57:40 +0000
Subject: [PATCH] A patch to viafbdev.c
Message-Id: <1387300030-7463-1-git-send-email-objectkuan@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

There is a potential integer overflow in viafb_ioctl() if 
users pass an unexpected value to viafb_second_size. An if
statement might be a simple solution to this issue.

Signed-off-by: objectkuan <objectkuan@gmail.com>
---
 drivers/video/via/viafbdev.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/video/via/viafbdev.c b/drivers/video/via/viafbdev.c
index 325c43c..382368e 100644
--- a/drivers/video/via/viafbdev.c
+++ b/drivers/video/via/viafbdev.c
@@ -463,6 +463,10 @@ static int viafb_ioctl(struct fb_info *info, u_int cmd, u_long arg)
 				u.viasamm.size_prim = viaparinfo->fbmem_free;
 				u.viasamm.size_sec = viaparinfo1->fbmem_free;
 			} else {
+				if (0 > viafb_second_size
+				|| viafb_second_size > INT_MAX / 1024 / 1024) {
+					return -EFAULT;
+				}
 				if (viafb_second_size) {
 					u.viasamm.size_prim  					    viaparinfo->fbmem_free -
@@ -1819,6 +1822,10 @@ int via_fb_pci_probe(struct viafb_dev *vdev)
 		default_var.accel_flags = 0;
 	}
 
+	if (0 > viafb_second_size
+	|| viafb_second_size > INT_MAX / 1024 / 1024) {
+		return -EFAULT;
+	}
 	if (viafb_second_size && (viafb_second_size < 8)) {
 		viafb_second_offset = viaparinfo->fbmem_free -
 			viafb_second_size * 1024 * 1024;
-- 
1.7.9.5

