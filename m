From: Jing Xiangfeng <jingxiangfeng@huawei.com>
Date: Thu, 17 Sep 2020 13:15:15 +0000
Subject: [PATCH] fbcon: Remove the superfluous break
Message-Id: <20200917131515.147029-1-jingxiangfeng@huawei.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: b.zolnierkie@samsung.com, gregkh@linuxfoundation.org, daniel.vetter@ffwll.ch, jirislaby@kernel.org, ndesaulniers@google.com, natechancellor@gmail.com, george.kennedy@oracle.com, peda@axentia.se
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, jingxiangfeng@huawei.com

Remove the superfuous break, as there is a 'return' before it.

Signed-off-by: Jing Xiangfeng <jingxiangfeng@huawei.com>
---
 drivers/video/fbdev/core/fbcon.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 0b49b0f44edf..623359aadd1e 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -1727,7 +1727,6 @@ static bool fbcon_scroll(struct vc_data *vc, unsigned int t, unsigned int b,
 				    vc->vc_video_erase_char,
 				    vc->vc_size_row * count);
 			return true;
-			break;
 
 		case SCROLL_WRAP_MOVE:
 			if (b - t - count > 3 * vc->vc_rows >> 2) {
@@ -1818,7 +1817,6 @@ static bool fbcon_scroll(struct vc_data *vc, unsigned int t, unsigned int b,
 				    vc->vc_video_erase_char,
 				    vc->vc_size_row * count);
 			return true;
-			break;
 
 		case SCROLL_WRAP_MOVE:
 			if (b - t - count > 3 * vc->vc_rows >> 2) {
-- 
2.17.1
