From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [RFC 2.6.20 1/1] fbdev,
	mm: Deferred IO and hecubafb driver
Date: Fri, 23 Feb 2007 18:22:37 +0900
Message-ID: <20070223092237.GA16889@linux-sh.org>
References: <20070223063228.GA9906@localhost>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HKWfr-00046a-LG for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 23 Feb 2007 01:25:08 -0800
Received: from smtp.ocgnet.org ([64.20.243.3])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HKWfq-0004tF-3H
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 23 Feb 2007 01:25:07 -0800
Content-Disposition: inline
In-Reply-To: <20070223063228.GA9906@localhost>
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
To: Jaya Kumar <jayakumar.lkml@gmail.com>
Cc: linux-mm@kvack.org, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

On Fri, Feb 23, 2007 at 07:32:28AM +0100, Jaya Kumar wrote:
> This is a first pass at abstracting deferred IO out from hecubafb and
> into fbdev as was discussed before: 
> http://marc.theaimsgroup.com/?l=linux-fbdev-devel&m=117187443327466&w=2
> 
> Please let me know your feedback and if it looks okay so far.
> 
How about this for an fsync()? I wonder if this will be sufficient for
msync() based flushing, or whether the ->sync VMA op is needed again..

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
