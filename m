From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Date: Wed, 17 Jun 2020 17:56:47 +0000
Subject: [PATCH][next] fbdev/fb.h: Use struct_size() helper in kzalloc()
Message-Id: <20200617175647.GA26370@embeddedor>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>

Make use of the struct_size() helper instead of an open-coded version
in order to avoid any potential type mistakes.

This code was detected with the help of Coccinelle and, audited and
fixed manually.

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 include/linux/fb.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/fb.h b/include/linux/fb.h
index 3b4b2f0c6994..2b530e6d86e4 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -506,8 +506,9 @@ struct fb_info {
 };
 
 static inline struct apertures_struct *alloc_apertures(unsigned int max_num) {
-	struct apertures_struct *a = kzalloc(sizeof(struct apertures_struct)
-			+ max_num * sizeof(struct aperture), GFP_KERNEL);
+	struct apertures_struct *a;
+
+	a = kzalloc(struct_size(a, ranges, max_num), GFP_KERNEL);
 	if (!a)
 		return NULL;
 	a->count = max_num;
-- 
2.27.0
