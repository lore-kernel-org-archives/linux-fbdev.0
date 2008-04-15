From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] fb: convert /proc/fb to seq_file
	interface
Date: Mon, 14 Apr 2008 23:31:54 -0700
Message-ID: <20080414233154.aef6006e.akpm@linux-foundation.org>
References: <20080412210317.GC9151@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Jleia-00028F-9u for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 14 Apr 2008 23:32:36 -0700
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JleiY-0006Os-U9
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 14 Apr 2008 23:32:36 -0700
In-Reply-To: <20080412210317.GC9151@martell.zuzino.mipt.ru>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, adaplas@gmail.com

On Sun, 13 Apr 2008 01:03:17 +0400 Alexey Dobriyan <adobriyan@gmail.com> wrote:

> Note: looks like accesses to "registered_fb" are done without any exclusion
> so there're none in new proc code, too. This should be fixed in separate
> patch.
> 
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>

Tony has been offline for a while and we need all the help we can get.  So
let's cc linux-fbdev-devel.



 drivers/video/fbmem.c |   61 ++++++++++++++++++++++++++++------------
 1 file changed, 43 insertions(+), 18 deletions(-)

diff -puN drivers/video/fbmem.c~fb-convert-proc-fb-to-seq_file-interface drivers/video/fbmem.c
--- a/drivers/video/fbmem.c~fb-convert-proc-fb-to-seq_file-interface
+++ a/drivers/video/fbmem.c
@@ -26,6 +26,7 @@
 #include <linux/init.h>
 #include <linux/linux_logo.h>
 #include <linux/proc_fs.h>
+#include <linux/seq_file.h>
 #include <linux/console.h>
 #ifdef CONFIG_KMOD
 #include <linux/kmod.h>
@@ -632,27 +633,51 @@ int fb_prepare_logo(struct fb_info *info
 int fb_show_logo(struct fb_info *info, int rotate) { return 0; }
 #endif /* CONFIG_LOGO */
 
-static int fbmem_read_proc(char *buf, char **start, off_t offset,
-			   int len, int *eof, void *private)
+static void * fb_seq_start(struct seq_file *m, loff_t *pos)
 {
-	struct fb_info **fi;
-	int clen;
+	return (*pos < FB_MAX) ? pos : NULL;
+}
 
-	clen = 0;
-	for (fi = registered_fb; fi < &registered_fb[FB_MAX] && clen < 4000;
-	     fi++)
-		if (*fi)
-			clen += sprintf(buf + clen, "%d %s\n",
-				        (*fi)->node,
-				        (*fi)->fix.id);
-	*start = buf + offset;
-	if (clen > offset)
-		clen -= offset;
-	else
-		clen = 0;
-	return clen < len ? clen : len;
+static void * fb_seq_next(struct seq_file *m, void *v, loff_t *pos)
+{
+	(*pos)++;
+	return (*pos < FB_MAX) ? pos : NULL;
+}
+
+static void fb_seq_stop(struct seq_file *m, void *v)
+{
+}
+
+static int fb_seq_show(struct seq_file *m, void *v)
+{
+	int i = *(loff_t *)v;
+	struct fb_info *fi = registered_fb[i];
+
+	if (fi)
+		seq_printf(m, "%d %s\n", fi->node, fi->fix.id);
+	return 0;
 }
 
+static const struct seq_operations proc_fb_seq_ops = {
+	.start	= fb_seq_start,
+	.next	= fb_seq_next,
+	.stop	= fb_seq_stop,
+	.show	= fb_seq_show,
+};
+
+static int proc_fb_open(struct inode *inode, struct file *file)
+{
+	return seq_open(file, &proc_fb_seq_ops);
+}
+
+static const struct file_operations fb_proc_fops = {
+	.owner		= THIS_MODULE,
+	.open		= proc_fb_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= seq_release,
+};
+
 static ssize_t
 fb_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 {
@@ -1533,7 +1558,7 @@ void fb_set_suspend(struct fb_info *info
 static int __init
 fbmem_init(void)
 {
-	create_proc_read_entry("fb", 0, NULL, fbmem_read_proc, NULL);
+	proc_create("fb", 0, NULL, &fb_proc_fops);
 
 	if (register_chrdev(FB_MAJOR,"fb",&fb_fops))
 		printk("unable to get major %d for fb devs\n", FB_MAJOR);
_


-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
