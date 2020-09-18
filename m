From: Jing Xiangfeng <jingxiangfeng@huawei.com>
Date: Fri, 18 Sep 2020 01:05:21 +0000
Subject: [PATCH v2] fbcon: Remove the superfluous break
Message-Id: <20200918010521.69950-1-jingxiangfeng@huawei.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: b.zolnierkie@samsung.com, gregkh@linuxfoundation.org, daniel.vetter@ffwll.ch, ndesaulniers@google.com, gustavoars@kernel.org, jirislaby@kernel.org, george.kennedy@oracle.com, natechancellor@gmail.com, peda@axentia.se, krzysztof.h1@wp.pl, akpm@linux-foundation.org, adaplas@gmail.com
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, jingxiangfeng@huawei.com

Remove the superfluous break, as there is a 'return' before it.

Fixes: bad07ff74c32 ("fbcon: smart blitter usage for scrolling")
Signed-off-by: Jing Xiangfeng <jingxiangfeng@huawei.com>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>
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
