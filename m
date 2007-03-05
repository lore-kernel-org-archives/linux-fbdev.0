From: Paul Mundt <lethal@linux-sh.org>
Subject: [PATCH] fb: fsync() method for deferred I/O
	flush.
Date: Mon, 5 Mar 2007 19:39:05 +0900
Message-ID: <20070305103905.GA12601@linux-sh.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HOAdW-0005vr-5u for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 05 Mar 2007 02:41:46 -0800
Received: from smtp.ocgnet.org ([64.20.243.3])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HOAdV-00014q-Nf
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 05 Mar 2007 02:41:46 -0800
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@linux-foundation.org>
Cc: jayakumar.lkml@gmail.com, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

There are cases when we do not want to wait on the delay for
automatically updating the "real" framebuffer, this implements a
simple ->fsync() hook for explicitly flushing the deferred I/O
work. The ->page_mkwrite() handler will rearm the work queue
normally.

Signed-off-by: Paul Mundt <lethal@linux-sh.org>

--

 drivers/video/fb_defio.c |   12 ++++++++++++
 drivers/video/fbmem.c    |    3 +++
 include/linux/fb.h       |    2 ++
 3 files changed, 17 insertions(+)

diff --git a/drivers/video/fb_defio.c b/drivers/video/fb_defio.c
index c3e57cc..8a66dc8 100644
--- a/drivers/video/fb_defio.c
+++ b/drivers/video/fb_defio.c
@@ -52,6 +52,18 @@ static void fb_deferred_io_work(struct work_struct *work)
 	mutex_unlock(&fbdefio->lock);
 }
 
+int fb_deferred_io_fsync(struct file *file, struct dentry *dentry, int datasync)
+{
+	struct fb_info *info = file->private_data;
+
+	/* Kill off the delayed work */
+	cancel_rearming_delayed_work(&info->deferred_work);
+
+	/* Run it immediately */
+	return schedule_delayed_work(&info->deferred_work, 0);
+}
+EXPORT_SYMBOL_GPL(fb_deferred_io_fsync);
+
 /* vm_ops->page_mkwrite handler */
 int fb_deferred_io_mkwrite(struct vm_area_struct *vma, 
 					struct page *page)
diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
index 863126a..69bbbe2 100644
--- a/drivers/video/fbmem.c
+++ b/drivers/video/fbmem.c
@@ -1266,6 +1266,9 @@ static const struct file_operations fb_fops = {
 #ifdef HAVE_ARCH_FB_UNMAPPED_AREA
 	.get_unmapped_area = get_fb_unmapped_area,
 #endif
+#ifdef CONFIG_FB_DEFERRED_IO
+	.fsync =	fb_deferred_io_fsync,
+#endif
 };
 
 struct class *fb_class;
diff --git a/include/linux/fb.h b/include/linux/fb.h
index af217dd..3f62652 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -933,6 +933,8 @@ extern void fb_deferred_io_init(struct fb_info *info);
 extern void fb_deferred_io_cleanup(struct fb_info *info);
 extern int fb_deferred_io_mkwrite(struct vm_area_struct *vma, 
 					struct page *page);
+extern int fb_deferred_io_fsync(struct file *file, struct dentry *dentry,
+				int datasync);
 #else
 #define fb_deferred_io_init(fb_info)	do { } while (0)
 #define fb_deferred_io_cleanup(fb_info)	do { } while (0)

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
