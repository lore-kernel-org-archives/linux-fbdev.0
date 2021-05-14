Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77D91C433ED
	for <linux-fbdev@archiver.kernel.org>; Fri, 14 May 2021 16:20:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36473613F1
	for <linux-fbdev@archiver.kernel.org>; Fri, 14 May 2021 16:20:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbhENQVf (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 14 May 2021 12:21:35 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:61785 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231326AbhENQVe (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 14 May 2021 12:21:34 -0400
Received: from fsav107.sakura.ne.jp (fsav107.sakura.ne.jp [27.133.134.234])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 14EGJn6k024946;
        Sat, 15 May 2021 01:19:49 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav107.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav107.sakura.ne.jp);
 Sat, 15 May 2021 01:19:49 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav107.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 14EGJmMu024941
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 15 May 2021 01:19:48 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: [PATCH] video: fbdev: vga16fb: fix OOB write in vga16fb_imageblit()
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
To:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Daniel Vetter <daniel@ffwll.ch>
References: <0000000000006bbd0c05c14f1b09@google.com>
 <6e21483c-06f6-404b-4018-e00ee85c456c@i-love.sakura.ne.jp>
 <87d928e4-b2b9-ad30-f3f0-1dfb8e4e03ed@i-love.sakura.ne.jp>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        syzbot <syzbot+1f29e126cf461c4de3b3@syzkaller.appspotmail.com>,
        b.zolnierkie@samsung.com, colin.king@canonical.com,
        gregkh@linuxfoundation.org, jani.nikula@intel.com,
        jirislaby@kernel.org, syzkaller-bugs@googlegroups.com,
        "Antonino A. Daplas" <adaplas@gmail.com>
Message-ID: <05acdda8-dc1c-5119-4326-96eed24bea0c@i-love.sakura.ne.jp>
Date:   Sat, 15 May 2021 01:19:48 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <87d928e4-b2b9-ad30-f3f0-1dfb8e4e03ed@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

syzbot is reporting that a local user with the framebuffer console can
crash the kernel [1], for ioctl(VT_RESIZE) allows a TTY to set arbitrary
rows/columns values regardless of amount of memory reserved for
the graphical screen.

----------
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <sys/ioctl.h>
#include <linux/kd.h>
#include <linux/vt.h>

int main(int argc, char *argv[])
{
        const int fd = open("/dev/char/4:1", O_RDWR);
        struct vt_sizes vt = { 0x4100, 2 };

        ioctl(fd, KDSETMODE, KD_GRAPHICS);
        ioctl(fd, VT_RESIZE, &vt);
        ioctl(fd, KDSETMODE, KD_TEXT);
        return 0;
}
----------

Currently it is impossible to control upper limit of rows/columns values
based on amount of memory reserved for the graphical screen, for
resize_screen() calls vc->vc_sw->con_resize() only if vc->vc_mode is not
already KD_GRAPHICS. I don't know the reason, and this condition predates
the git history. Even if it turns out to be safe to always call this
callback, we will need to involve another callback via "struct fb_ops" for
checking the upper limits from fbcon_resize(). As a result, we will need
to modify

 drivers/tty/vt/vt.c
 drivers/video/fbdev/core/fbcon.c
 drivers/video/fbdev/vga16fb.c
 include/linux/fb.h

files only for checking rows/columns values passed to ioctl(VT_RESIZE)
request.

Therefore, instead of introducing such a complicated callback chain, avoid
this problem by simply checking whether the address to read or write is in
[VGA_FB_PHYS, VGA_FB_PHYS + VGA_FB_PHYS_LEN) range.

[1] https://syzkaller.appspot.com/bug?extid=1f29e126cf461c4de3b3

Reported-by: syzbot <syzbot+1f29e126cf461c4de3b3@syzkaller.appspotmail.com>
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Tested-by: syzbot <syzbot+1f29e126cf461c4de3b3@syzkaller.appspotmail.com>
---
 drivers/video/fbdev/vga16fb.c | 54 +++++++++++++++++++++++------------
 1 file changed, 36 insertions(+), 18 deletions(-)

diff --git a/drivers/video/fbdev/vga16fb.c b/drivers/video/fbdev/vga16fb.c
index e2757ff1c23d..13732a3b1d69 100644
--- a/drivers/video/fbdev/vga16fb.c
+++ b/drivers/video/fbdev/vga16fb.c
@@ -98,6 +98,18 @@ static const struct fb_fix_screeninfo vga16fb_fix = {
 	.accel		= FB_ACCEL_NONE
 };
 
+/*
+ * Verify that the address to read or write is in [VGA_FB_PHYS, VGA_FB_PHYS + VGA_FB_PHYS_LEN)
+ * range, for ioctl(VT_RESIZE) allows a TTY to set arbitrary rows/columns values which will crash
+ * the kernel due to out of bounds access when trying to redraw the screen.
+ */
+static inline bool is_valid_iomem(const struct fb_info *info, const char __iomem *where)
+{
+	return info->screen_base <= where && where < info->screen_base + VGA_FB_PHYS_LEN;
+}
+
+#define IS_SAFE(where) is_valid_iomem(info, (where))
+
 /* The VGA's weird architecture often requires that we read a byte and
    write a byte to the same location.  It doesn't matter *what* byte
    we write, however.  This is because all the action goes on behind
@@ -851,7 +863,7 @@ static void vga_8planes_fillrect(struct fb_info *info, const struct fb_fillrect
                         int x;
 
                         /* we can do memset... */
-                        for (x = width; x > 0; --x) {
+			for (x = width; x > 0 && IS_SAFE(where); --x) {
                                 writeb(rect->color, where);
                                 where++;
                         }
@@ -864,7 +876,7 @@ static void vga_8planes_fillrect(struct fb_info *info, const struct fb_fillrect
                 oldop = setop(0x18);
                 oldsr = setsr(0xf);
                 setmask(0x0F);
-                for (y = 0; y < rect->height; y++) {
+		for (y = 0; y < rect->height && IS_SAFE(where) && IS_SAFE(where + 1); y++) {
                         rmw(where);
                         rmw(where+1);
                         where += info->fix.line_length;
@@ -919,7 +931,7 @@ static void vga16fb_fillrect(struct fb_info *info, const struct fb_fillrect *rec
 				setmask(0xff);
 
 				while (height--) {
-					for (x = 0; x < width; x++) {
+					for (x = 0; x < width && IS_SAFE(dst); x++) {
 						writeb(0, dst);
 						dst++;
 					}
@@ -935,7 +947,7 @@ static void vga16fb_fillrect(struct fb_info *info, const struct fb_fillrect *rec
 
 				setmask(0xff);
 				while (height--) {
-					for (x = 0; x < width; x++) {
+					for (x = 0; x < width && IS_SAFE(dst); x++) {
 						rmw(dst);
 						dst++;
 					}
@@ -975,7 +987,7 @@ static void vga_8planes_copyarea(struct fb_info *info, const struct fb_copyarea
                 dest = info->screen_base + dx + area->dy * info->fix.line_length;
                 src = info->screen_base + sx + area->sy * info->fix.line_length;
                 while (height--) {
-                        for (x = 0; x < width; x++) {
+			for (x = 0; x < width && IS_SAFE(src) && IS_SAFE(dest); x++) {
                                 readb(src);
                                 writeb(0, dest);
                                 src++;
@@ -991,7 +1003,7 @@ static void vga_8planes_copyarea(struct fb_info *info, const struct fb_copyarea
                 src = info->screen_base + sx + width +
 			(area->sy + height - 1) * info->fix.line_length;
                 while (height--) {
-                        for (x = 0; x < width; x++) {
+			for (x = 0; x < width && IS_SAFE(src - 1) && IS_SAFE(dest - 1); x++) {
                                 --src;
                                 --dest;
                                 readb(src);
@@ -1065,7 +1077,7 @@ static void vga16fb_copyarea(struct fb_info *info, const struct fb_copyarea *are
 				dst = info->screen_base + (dx/8) + dy * info->fix.line_length;
 				src = info->screen_base + (sx/8) + sy * info->fix.line_length;
 				while (height--) {
-					for (x = 0; x < width; x++) {
+					for (x = 0; x < width && IS_SAFE(src) && IS_SAFE(dst); x++) {
 						readb(src);
 						writeb(0, dst);
 						dst++;
@@ -1080,7 +1092,7 @@ static void vga16fb_copyarea(struct fb_info *info, const struct fb_copyarea *are
 				src = info->screen_base + (sx/8) + width + 
 					(sy + height  - 1) * info->fix.line_length;
 				while (height--) {
-					for (x = 0; x < width; x++) {
+					for (x = 0; x < width && IS_SAFE(src - 1) && IS_SAFE(dst - 1); x++) {
 						dst--;
 						src--;
 						readb(src);
@@ -1130,13 +1142,15 @@ static void vga_8planes_imageblit(struct fb_info *info, const struct fb_image *i
         where = info->screen_base + dx + image->dy * info->fix.line_length;
 
         setmask(0xff);
-        writeb(image->bg_color, where);
-        readb(where);
+	if (IS_SAFE(where)) {
+		writeb(image->bg_color, where);
+		readb(where);
+	}
         selectmask();
         setmask(image->fg_color ^ image->bg_color);
         setmode(0x42);
         setop(0x18);
-        for (y = 0; y < image->height; y++, where += info->fix.line_length)
+	for (y = 0; y < image->height && IS_SAFE(where); y++, where += info->fix.line_length)
                 writew(transl_h[cdat[y]&0xF] | transl_l[cdat[y] >> 4], where);
         setmask(oldmask);
         setsr(oldsr);
@@ -1165,14 +1179,16 @@ static void vga_imageblit_expand(struct fb_info *info, const struct fb_image *im
 				selectmask();
 				
 				setmask(0xff);
-				writeb(image->bg_color, where);
-				rmb();
-				readb(where); /* fill latches */
+				if (IS_SAFE(where)) {
+					writeb(image->bg_color, where);
+					rmb();
+					readb(where); /* fill latches */
+				}
 				setmode(3);
 				wmb();
 				for (y = 0; y < image->height; y++) {
 					dst = where;
-					for (x = image->width/8; x--;) 
+					for (x = image->width/8; x-- && IS_SAFE(dst);)
 						writeb(*cdat++, dst++);
 					where += info->fix.line_length;
 				}
@@ -1187,7 +1203,7 @@ static void vga_imageblit_expand(struct fb_info *info, const struct fb_image *im
 				setmask(0xff);
 				for (y = 0; y < image->height; y++) {
 					dst = where;
-					for (x=image->width/8; x--;){
+					for (x = image->width/8 && IS_SAFE(dst); x--;) {
 						rmw(dst);
 						setcolor(image->fg_color);
 						selectmask();
@@ -1237,8 +1253,10 @@ static void vga_imageblit_color(struct fb_info *info, const struct fb_image *ima
 					setcolor(*cdat);
 					selectmask();
 					setmask(1 << (7 - (x % 8)));
-					fb_readb(dst);
-					fb_writeb(0, dst);
+					if (IS_SAFE(dst)) {
+						fb_readb(dst);
+						fb_writeb(0, dst);
+					}
 
 					cdat++;
 				}
-- 
2.18.4


