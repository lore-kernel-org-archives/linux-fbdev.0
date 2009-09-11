From: Pawel Osciak <p.osciak@samsung.com>
Subject: [PATCH 6/7] [ARM] s3c-fb: Added debugfs
	interface.
Date: Fri, 11 Sep 2009 20:05:02 +0200
Message-ID: <E4D3F24EA6C9E54F817833EAE0D912AC0771185D5D@bssrvexch01.BS.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <p.osciak@samsung.com>) id 1MmAW6-00028O-SX
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 11 Sep 2009 18:06:38 +0000
Received: from mailout1.w1.samsung.com ([210.118.77.11])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MmAVo-0006mf-Ns for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 11 Sep 2009 18:06:25 +0000
Received: from eu_spt1 (mailout1.w1.samsung.com [210.118.77.11])
	by mailout1.w1.samsung.com
	(iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
	with ESMTP id <0KPT00NXXJM358@mailout1.w1.samsung.com> for
	linux-fbdev-devel@lists.sourceforge.net;
	Fri, 11 Sep 2009 19:06:03 +0100 (BST)
Received: from linux.samsung.com ([106.116.38.10])
	by spt1.w1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul
	14 2004)) with ESMTPA id <0KPT005RSJM35M@spt1.w1.samsung.com> for
	linux-fbdev-devel@lists.sourceforge.net;
	Fri, 11 Sep 2009 19:06:03 +0100 (BST)
Content-language: en-US
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-fbdev-devel@lists.sourceforge.net" <linux-fbdev-devel@lists.sourceforge.net>
Cc: Pawel Osciak <p.osciak@samsung.com>, =?utf-8?B?67CV6rK966+8?= <kyungmin.park@samsung.com>, "ben-linux@fluff.org" <ben-linux@fluff.org>, "adaplas@gmail.com" <adaplas@gmail.com>, Marek Szyprowski <m.szyprowski@samsung.com>

This patch adds debugfs information in s3c-fb directory in
debugfs root.

Reviewed-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Kyungmin Park <kyungmin.park@samsung.com>
Signed-off-by: Pawel Osciak <p.osciak@samsung.com>

---
 drivers/video/Kconfig  |   16 +++-
 drivers/video/s3c-fb.c |  237 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 249 insertions(+), 4 deletions(-)

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 3b54b39..922a1cb 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -1917,10 +1917,18 @@ config FB_S3C
 	  Currently the support is only for the S3C6400 and S3C6410 SoCs.
 
 config FB_S3C_DEBUG_REGWRITE
-       bool "Debug register writes"
-       depends on FB_S3C
-       ---help---
-         Show all register writes via printk(KERN_DEBUG)
+	bool "Debug register writes"
+	depends on FB_S3C
+	---help---
+	  Show all register writes via printk(KERN_DEBUG)
+
+config FB_S3C_DEBUG_FS
+	bool "Enable debug information in DebugFS"
+	depends on FB_S3C && DEBUG_FS
+	default n
+	---help---
+	  Enable this if you want debugging information in debugfs.
+	  If unsure, say N.
 
 config FB_S3C2410
 	tristate "S3C2410 LCD framebuffer support"
diff --git a/drivers/video/s3c-fb.c b/drivers/video/s3c-fb.c
index 226d225..6721f20 100644
--- a/drivers/video/s3c-fb.c
+++ b/drivers/video/s3c-fb.c
@@ -26,6 +26,12 @@
 
 #include <plat/s3c-fb.h>
 
+#ifdef CONFIG_FB_S3C_DEBUG_FS
+#include <linux/debugfs.h>
+#include <linux/seq_file.h>
+#endif
+
+
 #include <mach/map.h>
 #include <mach/regs-fb.h>
 #include <plat/fb.h>
@@ -62,6 +68,11 @@
 
 struct s3c_fb;
 
+#ifdef CONFIG_FB_S3C_DEBUG_FS
+static void __devinit s3c_fb_debugfs_init(struct s3c_fb *sfb);
+static void __devinit s3c_fb_debugfs_remove(void);
+#endif
+
 /**
  * struct s3c_fb_win - per window private data for each framebuffer.
  * @windata: The platform data supplied for the window configuration.
@@ -1441,6 +1452,10 @@ static int __devinit s3c_fb_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, sfb);
 
+#ifdef CONFIG_FB_S3C_DEBUG_FS
+	s3c_fb_debugfs_init(sfb);
+#endif
+
 	return 0;
 
 err_irq:
@@ -1474,6 +1489,10 @@ static int __devexit s3c_fb_remove(struct platform_device *pdev)
 	struct s3c_fb *sfb = platform_get_drvdata(pdev);
 	int win;
 
+#ifdef CONFIG_FB_S3C_DEBUG_FS
+	s3c_fb_debugfs_remove();
+#endif
+
 	for (win = 0; win < S3C_FB_MAX_WIN; win++)
 		if (sfb->windows[win])
 			s3c_fb_release_win(sfb, sfb->windows[win]);
@@ -1567,6 +1586,224 @@ static void __exit s3c_fb_cleanup(void)
 	platform_driver_unregister(&s3c_fb_driver);
 }
 
+/* DEBUGFS */
+
+#ifdef CONFIG_FB_S3C_DEBUG_FS
+static struct dentry *debugfs_dir;
+
+static void *dbg_seq_next(struct seq_file *s, void *v, loff_t *pos)
+{
+	int *win_no;
+
+	if (v == SEQ_START_TOKEN)
+		return pos;
+
+	win_no = (int *)pos;
+	*win_no += 1;
+	if (*win_no >= S3C_FB_MAX_WIN)
+		return NULL;
+
+	return pos;
+}
+
+static int dbg_blend_seq_show(struct seq_file *s, void *v)
+{
+	struct s3c_fb *sfb = s->private;
+	int *win_no = v;
+	u32 vidosdc, wincon;
+
+	if (v == SEQ_START_TOKEN) {
+		seq_printf(s, "win|       mode       AEN0 AEN1\n");
+		return 0;
+	}
+
+	if (!s3c_fb_has_alpha(*win_no))
+		return SEQ_SKIP;
+
+	seq_printf(s, "%2d | ", *win_no);
+
+	vidosdc = readl(sfb->regs + VIDOSD_C(*win_no));
+	wincon = readl(sfb->regs + WINCONx(*win_no));
+	if (wincon & WINCONx_BLD_PIX) {
+		seq_printf(s, " per pixel ");
+		if (wincon & WINCONx_ALPHA_SEL)
+			seq_printf(s, "value ");
+		else
+			seq_printf(s, "global ");
+	} else {
+		seq_printf(s, "  global ");
+		if (wincon & WINCONx_ALPHA_SEL)
+			seq_printf(s, "val 1   ");
+		else
+			seq_printf(s, "val 0   ");
+	}
+	seq_printf(s, "%04x %04x\n",
+		   (vidosdc & VIDOSD14C_ALPHA0_MASK)
+			>> VIDOSD14C_ALPHA0_B_SHIFT,
+		   vidosdc & VIDOSD14C_ALPHA1_MASK);
+
+	return 0;
+}
+
+static int dbg_ckey_seq_show(struct seq_file *s, void *v)
+{
+	struct s3c_fb *sfb = s->private;
+	int *win_no = v;
+	u32 keycon0, keycon1;
+
+	if (v == SEQ_START_TOKEN) {
+		seq_printf(s, "win| enabled direction  value  mask\n");
+		return 0;
+	}
+
+	if (!has_colorkey(*win_no))
+		return SEQ_SKIP;
+
+	seq_printf(s, "%2d | ", *win_no);
+
+	keycon0 = readl(sfb->regs + WxKEYCON0(*win_no));
+	keycon1 = readl(sfb->regs + WxKEYCON1(*win_no));
+
+	seq_printf(s, "   %d    ", keycon0 & WxKEYCON0_KEYEN_F);
+	if (keycon0 & WxKEYCON0_DIRCON)
+		seq_printf(s, "   FG   ");
+	else
+		seq_printf(s, "   BG   ");
+
+	seq_printf(s, "  %06x ", keycon1 & WxKEYCON1_COLVAL_MASK);
+	seq_printf(s, "%06x ", keycon0 & WxKEYCON0_COMPKEY_MASK);
+	seq_printf(s, "\n");
+
+	return 0;
+}
+
+static inline void *single_start(struct seq_file *p, loff_t *pos)
+{
+	if (*pos == 0)
+		return SEQ_START_TOKEN;
+
+	return NULL + (*pos == 0);
+}
+
+static inline void single_stop(struct seq_file *p, void *v)
+{
+}
+
+static const struct seq_operations dbg_blend_seq_ops = {
+	.start		= single_start,
+	.next		= dbg_seq_next,
+	.stop		= single_stop,
+	.show		= dbg_blend_seq_show,
+};
+
+static const struct seq_operations dbg_ckey_seq_ops = {
+	.start		= single_start,
+	.next		= dbg_seq_next,
+	.stop		= single_stop,
+	.show		= dbg_ckey_seq_show,
+};
+
+static int dbg_blend_open(struct inode *inode, struct file *file)
+{
+	struct seq_file *seq;
+	int ret;
+
+	ret = seq_open(file, &dbg_blend_seq_ops);
+	if (ret)
+		return ret;
+
+	seq = file->private_data;
+	seq->private = inode->i_private;
+
+	return 0;
+}
+
+static const struct file_operations dbg_blend_fops = {
+	.owner		= THIS_MODULE,
+	.open		= dbg_blend_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= seq_release,
+};
+
+static int dbg_ckey_open(struct inode *inode, struct file *file)
+{
+	struct seq_file *seq;
+	int ret;
+
+	ret = seq_open(file, &dbg_ckey_seq_ops);
+	if (ret)
+		return ret;
+
+	seq = file->private_data;
+	seq->private = inode->i_private;
+
+	return 0;
+}
+
+static const struct file_operations dbg_ckey_fops = {
+	.owner		= THIS_MODULE,
+	.open		= dbg_ckey_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= seq_release,
+};
+
+static int dbg_winen_show(struct seq_file *s, void *v)
+{
+	struct s3c_fb *sfb = s->private;
+	int win_no;
+
+	for (win_no = 0; win_no < S3C_FB_MAX_WIN; ++win_no) {
+		if (sfb->enabled & (1 << win_no))
+			seq_printf(s, "Win%d: enabled\n", win_no);
+		else
+			seq_printf(s, "Win%d: disabled\n", win_no);
+	}
+
+	return 0;
+}
+
+static int dbg_winen_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, dbg_winen_show, inode->i_private);
+}
+
+static const struct file_operations dbg_winen_fops = {
+	.owner		= THIS_MODULE,
+	.open		= dbg_winen_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
+static void __devinit s3c_fb_debugfs_init(struct s3c_fb *sfb)
+{
+	debugfs_dir = debugfs_create_dir("s3c-fb", NULL);
+	if (! debugfs_dir || IS_ERR(debugfs_dir)) {
+		dev_warn(sfb->dev, "Could not create debugfs directory\n");
+		return;
+	}
+
+	debugfs_create_file("windows_enabled", S_IRUGO, debugfs_dir, sfb,
+			    &dbg_winen_fops);
+
+	debugfs_create_file("blending", S_IRUGO, debugfs_dir, sfb,
+			    &dbg_blend_fops);
+
+	debugfs_create_file("color_key", S_IRUGO, debugfs_dir, sfb,
+			    &dbg_ckey_fops);
+}
+
+static void __devinit s3c_fb_debugfs_remove(void)
+{
+	if (debugfs_dir)
+		debugfs_remove_recursive(debugfs_dir);
+}
+#endif /* CONFIG_DEBUG_FS */
+
+/* DEBUGFS END */
+
 module_init(s3c_fb_init);
 module_exit(s3c_fb_cleanup);
 
-- 
1.6.4.2.253.g0b1fac


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
