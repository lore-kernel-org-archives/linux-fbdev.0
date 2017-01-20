From: Geliang Tang <geliangtang@gmail.com>
Date: Fri, 20 Jan 2017 14:27:05 +0000
Subject: [PATCH] video/mbx: use simple_open()
Message-Id: <70f5253031d545642db17d64535f228752c12e6e.1484903730.git.geliangtang@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <697f2692562e48afa03304a7e605e8adbee8437e.1484829069.git.geliangtang@gmail.com>
In-Reply-To: <697f2692562e48afa03304a7e605e8adbee8437e.1484829069.git.geliangtang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Geliang Tang <geliangtang@gmail.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

Drop open_file_generic(), use simple_open() instead of it.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 drivers/video/fbdev/mbx/mbxdebugfs.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/video/fbdev/mbx/mbxdebugfs.c b/drivers/video/fbdev/mbx/mbxdebugfs.c
index e3bc00a..2528d3e 100644
--- a/drivers/video/fbdev/mbx/mbxdebugfs.c
+++ b/drivers/video/fbdev/mbx/mbxdebugfs.c
@@ -15,12 +15,6 @@ struct mbxfb_debugfs_data {
 	struct dentry *misc;
 };
 
-static int open_file_generic(struct inode *inode, struct file *file)
-{
-	file->private_data = inode->i_private;
-	return 0;
-}
-
 static ssize_t write_file_dummy(struct file *file, const char __user *buf,
 				size_t count, loff_t *ppos)
 {
@@ -174,42 +168,42 @@ static ssize_t misc_read_file(struct file *file, char __user *userbuf,
 static const struct file_operations sysconf_fops = {
 	.read = sysconf_read_file,
 	.write = write_file_dummy,
-	.open = open_file_generic,
+	.open = simple_open,
 	.llseek = default_llseek,
 };
 
 static const struct file_operations clock_fops = {
 	.read = clock_read_file,
 	.write = write_file_dummy,
-	.open = open_file_generic,
+	.open = simple_open,
 	.llseek = default_llseek,
 };
 
 static const struct file_operations display_fops = {
 	.read = display_read_file,
 	.write = write_file_dummy,
-	.open = open_file_generic,
+	.open = simple_open,
 	.llseek = default_llseek,
 };
 
 static const struct file_operations gsctl_fops = {
 	.read = gsctl_read_file,
 	.write = write_file_dummy,
-	.open = open_file_generic,
+	.open = simple_open,
 	.llseek = default_llseek,
 };
 
 static const struct file_operations sdram_fops = {
 	.read = sdram_read_file,
 	.write = write_file_dummy,
-	.open = open_file_generic,
+	.open = simple_open,
 	.llseek = default_llseek,
 };
 
 static const struct file_operations misc_fops = {
 	.read = misc_read_file,
 	.write = write_file_dummy,
-	.open = open_file_generic,
+	.open = simple_open,
 	.llseek = default_llseek,
 };
 
-- 
2.9.3

