From: Peter Huewe <peterhuewe@gmx.de>
Date: Fri, 04 May 2012 00:23:17 +0000
Subject: [PATCH v2] video/via: Convert to kstrtou8_from_user
Message-Id: <1336090997-23727-1-git-send-email-peterhuewe@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CACVxJT96rXRqMoeabdDyNEjXCubuAnQ_fonisbopQvYL=Qhp2w@mail.gmail.com>
In-Reply-To: <CACVxJT96rXRqMoeabdDyNEjXCubuAnQ_fonisbopQvYL=Qhp2w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: Alexey Dobriyan <adobriyan@gmail.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>

This patch replaces the code for getting an number from a
userspace buffer by a simple call to kstrou8_from_user.
This makes it easier to read and less error prone.

v2:
removed initialization of reg_val and dropped check if count < 1

Signed-off-by: Peter Huewe <peterhuewe@gmx.de>
---
@Alexey: Thanks for the review/feedback!
 drivers/video/via/viafbdev.c |   34 ++++++++++++----------------------
 1 files changed, 12 insertions(+), 22 deletions(-)

diff --git a/drivers/video/via/viafbdev.c b/drivers/video/via/viafbdev.c
index a13c258..88bf5ba 100644
--- a/drivers/video/via/viafbdev.c
+++ b/drivers/video/via/viafbdev.c
@@ -1279,17 +1279,12 @@ static int viafb_dfph_proc_open(struct inode *inode, struct file *file)
 static ssize_t viafb_dfph_proc_write(struct file *file,
 	const char __user *buffer, size_t count, loff_t *pos)
 {
-	char buf[20];
-	u8 reg_val = 0;
-	unsigned long length;
-	if (count < 1)
-		return -EINVAL;
-	length = count > 20 ? 20 : count;
-	if (copy_from_user(&buf[0], buffer, length))
-		return -EFAULT;
-	buf[length - 1] = '\0';	/*Ensure end string */
-	if (kstrtou8(buf, 0, &reg_val) < 0)
-		return -EINVAL;
+	int err;
+	u8 reg_val;
+	err = kstrtou8_from_user(buffer, count, 0, &reg_val);
+	if (err)
+		return err;
+
 	viafb_write_reg_mask(CR97, VIACR, reg_val, 0x0f);
 	return count;
 }
@@ -1319,17 +1314,12 @@ static int viafb_dfpl_proc_open(struct inode *inode, struct file *file)
 static ssize_t viafb_dfpl_proc_write(struct file *file,
 	const char __user *buffer, size_t count, loff_t *pos)
 {
-	char buf[20];
-	u8 reg_val = 0;
-	unsigned long length;
-	if (count < 1)
-		return -EINVAL;
-	length = count > 20 ? 20 : count;
-	if (copy_from_user(&buf[0], buffer, length))
-		return -EFAULT;
-	buf[length - 1] = '\0';	/*Ensure end string */
-	if (kstrtou8(buf, 0, &reg_val) < 0)
-		return -EINVAL;
+	int err;
+	u8 reg_val;
+	err = kstrtou8_from_user(buffer, count, 0, &reg_val);
+	if (err)
+		return err;
+
 	viafb_write_reg_mask(CR99, VIACR, reg_val, 0x0f);
 	return count;
 }
-- 
1.7.3.4

