From: Peter Huewe <peterhuewe@gmx.de>
Date: Sat, 14 Apr 2012 23:24:46 +0000
Subject: [PATCH] video/via: Convert to kstrtou8_from_user
Message-Id: <1334445886-32448-1-git-send-email-peterhuewe@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>

This patch replaces the code for getting an number from a
userspace buffer by a simple call to kstrou8_from_user.
This makes it easier to read and less error prone.

Signed-off-by: Peter Huewe <peterhuewe@gmx.de>
---
 drivers/video/via/viafbdev.c |   26 ++++++++++----------------
 1 files changed, 10 insertions(+), 16 deletions(-)

diff --git a/drivers/video/via/viafbdev.c b/drivers/video/via/viafbdev.c
index 0c88375..5b0d524 100644
--- a/drivers/video/via/viafbdev.c
+++ b/drivers/video/via/viafbdev.c
@@ -1276,17 +1276,14 @@ static int viafb_dfph_proc_open(struct inode *inode, struct file *file)
 static ssize_t viafb_dfph_proc_write(struct file *file,
 	const char __user *buffer, size_t count, loff_t *pos)
 {
-	char buf[20];
+	int err;
 	u8 reg_val = 0;
-	unsigned long length;
 	if (count < 1)
 		return -EINVAL;
-	length = count > 20 ? 20 : count;
-	if (copy_from_user(&buf[0], buffer, length))
-		return -EFAULT;
-	buf[length - 1] = '\0';	/*Ensure end string */
-	if (kstrtou8(buf, 0, &reg_val) < 0)
-		return -EINVAL;
+	err = kstrtou8_from_user(buffer, count, 0, &reg_val);
+	if (err)
+		return err;
+
 	viafb_write_reg_mask(CR97, VIACR, reg_val, 0x0f);
 	return count;
 }
@@ -1316,17 +1313,14 @@ static int viafb_dfpl_proc_open(struct inode *inode, struct file *file)
 static ssize_t viafb_dfpl_proc_write(struct file *file,
 	const char __user *buffer, size_t count, loff_t *pos)
 {
-	char buf[20];
+	int err;
 	u8 reg_val = 0;
-	unsigned long length;
 	if (count < 1)
 		return -EINVAL;
-	length = count > 20 ? 20 : count;
-	if (copy_from_user(&buf[0], buffer, length))
-		return -EFAULT;
-	buf[length - 1] = '\0';	/*Ensure end string */
-	if (kstrtou8(buf, 0, &reg_val) < 0)
-		return -EINVAL;
+	err = kstrtou8_from_user(buffer, count, 0, &reg_val);
+	if (err)
+		return err;
+
 	viafb_write_reg_mask(CR99, VIACR, reg_val, 0x0f);
 	return count;
 }
-- 
1.7.3.4

