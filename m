From: Yisheng Xie <ysxie@foxmail.com>
Date: Sat, 30 Jun 2018 07:30:48 +0000
Subject: [PATCH v2 fbdev-for-next 2/2] fbdev: fix typo in comment
Message-Id: <1530343848-4344-1-git-send-email-ysxie@foxmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: b.zolnierkie@samsung.com, keescook@chromium.org, j.w.r.degoede@gmail.com, david@lechnology.com
Cc: andriy.shevchenko@linux.intel.com, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Yisheng Xie <ysxie@foxmail.com>

change beeng to being and occured to occurred.

Signed-off-by: Yisheng Xie <ysxie@foxmail.com>
---
v2:
 - new add one.

 include/linux/fb.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/fb.h b/include/linux/fb.h
index fd31e6f..3e7e753 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -126,7 +126,7 @@ struct fb_cursor_user {
 
 /*	The resolution of the passed in fb_info about to change */ 
 #define FB_EVENT_MODE_CHANGE		0x01
-/*	The display on this fb_info is beeing suspended, no access to the
+/*	The display on this fb_info is being suspended, no access to the
  *	framebuffer is allowed any more after that call returns
  */
 #define FB_EVENT_SUSPEND		0x02
@@ -159,9 +159,9 @@ struct fb_cursor_user {
 #define FB_EVENT_FB_UNBIND              0x0E
 /*      CONSOLE-SPECIFIC: remap all consoles to new fb - for vga_switcheroo */
 #define FB_EVENT_REMAP_ALL_CONSOLE      0x0F
-/*      A hardware display blank early change occured */
+/*      A hardware display blank early change occurred */
 #define FB_EARLY_EVENT_BLANK		0x10
-/*      A hardware display blank revert early change occured */
+/*      A hardware display blank revert early change occurred */
 #define FB_R_EARLY_EVENT_BLANK		0x11
 
 struct fb_event {
-- 
1.9.1

