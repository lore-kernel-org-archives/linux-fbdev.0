From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] Cleanup pixmap locking
Date: Sun, 11 Jan 2004 18:33:11 +1100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1073806391.765.99.camel@gaston>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AfaAU-0001QH-F1
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 10 Jan 2004 23:37:54 -0800
Received: from pentafluge.infradead.org ([213.86.99.235])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30)
	id 1AfaAT-0006an-MY
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 10 Jan 2004 23:37:54 -0800
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, James Simmons <jsimmons@infradead.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>

Hi James !

As we discussed, the current pixmap locking scheme doesn't work and
is actually rendered useless by the fact that we are going to be
entirely protected by the console semaphore, at least in 2.6.

This patch removes it, and re-implements fb_get_buffer_offset()
based on these assumption:

 - a FB_PIXMAP_IO buffer is considered as residing in VRAM, we
sync before letting the common code access it, we do no sharing

 - a buffer in memory is allowed to be shared. We do not race on
buffer usage, but we can have a pending DMA from the buffer to the
card, which is what I call sharing. If we run out of buffer space,
and the pixmap has FB_PIXMAP_SYNC set, we assume the pixmap can be
the source of a DMA, thus we sync before resetting the offset.

A card that does DMA, but synchronously, doesn't need to set FB_PIXMAP_SYNC.
Note that in most cases (non-DMA or synchronous DMA), the actual offset thing
is useless, we could just use the beginning of the pixmap each time. I find
the current FB_PIXMAP_* semantics confusing anyway, so you are welcome to do
even more cleanup in there, I just
did the minimum I feel is necessary.

I added the console semaphore around the whole fb_ioctl as well and
around the fbcon cursor operations.

The patch is against your fbdev-2.5 tree and is untested at this
point (no test config at hand until tomorrow). Please consider applying
if it works for you though.

Once that's in, I'll send you my fixes to the fbcon resize stuf, though
those require the FB_ACTIVATE_FIND to work really properly, at least
without that, it's still better than what we have now. I'm still chasing
a crasher in the stty code path though.

Ben.


===== drivers/video/fbmem.c 1.102 vs edited =====
--- 1.102/drivers/video/fbmem.c	Sat Nov  1 08:10:46 2003
+++ edited/drivers/video/fbmem.c	Sun Jan 11 18:16:51 2004
@@ -466,22 +466,30 @@
 	u32 offset, count = 1000;
 	char *addr = buf->addr;
 
-	spin_lock(&buf->lock);
-	if (!(buf->flags & FB_PIXMAP_IO)) { 
-		offset = buf->offset + align;
-		offset &= ~align;
-		if (offset + size > buf->size) {
-			while (atomic_read(&buf->count) && count--);
-			if (info->fbops->fb_sync && (buf->flags & FB_PIXMAP_SYNC))
-				info->fbops->fb_sync(info);
-			offset = 0;
-		}
-		buf->offset = offset + size;
-		addr += offset;	
+	/* If IO mapped, we need to sync before access, no sharing of
+	 * the pixmap is done
+	 */
+	if (buf->flags & FB_PIXMAP_IO) {
+		if (info->fbops->fb_sync && (buf->flags & FB_PIXMAP_SYNC))
+			info->fbops->fb_sync(info);
+		return addr;
 	}
-	atomic_inc(&buf->count);
-	smp_mb__after_atomic_inc();
-	spin_unlock(&buf->lock);
+
+	/* See if we fit in the remaining pixmap space */
+	offset = buf->offset + align;
+	offset &= ~align;
+	if (offset + size > buf->size) {
+		/* We do not fit. In order to be able to re-use the buffer,
+		 * we must ensure no asynchronous DMA'ing or whatever operation
+		 * is in progress, we sync for that.
+		 */
+		if (info->fbops->fb_sync && (buf->flags & FB_PIXMAP_SYNC))
+			info->fbops->fb_sync(info);
+		offset = 0;
+	}
+	buf->offset = offset + size;
+	addr += offset;	
+
 	return addr;
 }
 
===== drivers/video/console/fbcon.c 1.124 vs edited =====
--- 1.124/drivers/video/console/fbcon.c	Wed Jan  7 13:42:58 2004
+++ edited/drivers/video/console/fbcon.c	Sun Jan 11 18:18:34 2004
@@ -197,8 +197,10 @@
 
 	if (!info)
 		return;
-	info->cursor.enable ^= 1;
+	acquire_console_sem();
+	info->cursor.enable ^= 1;	
 	info->fbops->fb_cursor(info, &info->cursor);
+	release_console_sem();
 }
 
 #if (defined(__arm__) && defined(IRQ_VSYNCPULSE)) || defined(CONFIG_ATARI) || defined(CONFIG_MAC)
@@ -398,8 +400,6 @@
 		info->fbops->fb_imageblit(info, &image);
 		image.dx += cnt * vc->vc_font.width;
 		count -= cnt;
-		atomic_dec(&info->pixmap.count);
-		smp_mb__after_atomic_dec();
 	}
 }
 
@@ -913,8 +913,6 @@
 	move_buf_aligned(info, &info->pixmap, dst, pitch, src, width, image.height);
 
 	info->fbops->fb_imageblit(info, &image);
-	atomic_dec(&info->pixmap.count);
-	smp_mb__after_atomic_dec();
 }
 
 static void fbcon_putcs(struct vc_data *vc, const unsigned short *s,
@@ -1064,8 +1062,6 @@
 		}
 		info->fbops->fb_cursor(info, &cursor);
 		info->cursor.enable = 1;
-		atomic_dec(&info->sprite.count);
-		smp_mb__after_atomic_dec();
 		mod_timer(&cursor_timer, jiffies + HZ/5);
 		vbl_cursor_cnt = CURSOR_DRAW_DELAY;
 	}
===== include/linux/fb.h 1.62 vs edited =====
--- 1.62/include/linux/fb.h	Thu Oct 30 17:20:52 2003
+++ edited/include/linux/fb.h	Sun Jan 11 18:15:50 2004
@@ -375,8 +375,6 @@
 	u32 scan_align;		/* alignment per scanline 		*/
 	u32 access_align;	/* alignment per read/write		*/
 	u32 flags;		/* see FB_PIXMAP_* 			*/
-	spinlock_t lock;	/* spinlock 				*/
-	atomic_t count;
 	/* access methods */
 	void (*outbuf)(struct fb_info *info, u8 *addr, u8 *src, unsigned int size); 
 	u8   (*inbuf) (u8 *addr);




-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
