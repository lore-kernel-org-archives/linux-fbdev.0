From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Date: Wed, 07 Aug 2019 16:13:12 +0000
Subject: [PATCH] video: fbdev/mmp/core: Use struct_size() in kzalloc()
Message-Id: <20190807161312.GA26835@embeddedor>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>

One of the more common cases of allocation size calculations is finding
the size of a structure that has a zero-sized array at the end, along
with memory for some number of elements for that array. For example:

struct mmp_path {
	...
        struct mmp_overlay overlays[0];
};

size = sizeof(struct mmp_path) + count * sizeof(struct mmp_overlay);
instance = kzalloc(size, GFP_KERNEL)

Instead of leaving these open-coded and prone to type mistakes, we can
now use the new struct_size() helper:

instance = kzalloc(struct_size(instance, overlays, count), GFP_KERNEL)

Notice that, in this case, variable size is not necessary, hence it
is removed.

This code was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/video/fbdev/mmp/core.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/mmp/core.c b/drivers/video/fbdev/mmp/core.c
index 0ffc1b7b7052..154127256a2c 100644
--- a/drivers/video/fbdev/mmp/core.c
+++ b/drivers/video/fbdev/mmp/core.c
@@ -153,13 +153,11 @@ EXPORT_SYMBOL_GPL(mmp_get_path);
 struct mmp_path *mmp_register_path(struct mmp_path_info *info)
 {
 	int i;
-	size_t size;
 	struct mmp_path *path = NULL;
 	struct mmp_panel *panel;
 
-	size = sizeof(struct mmp_path)
-		+ sizeof(struct mmp_overlay) * info->overlay_num;
-	path = kzalloc(size, GFP_KERNEL);
+	path = kzalloc(struct_size(path, overlays, info->overlay_num),
+		       GFP_KERNEL);
 	if (!path)
 		return NULL;
 
-- 
2.22.0
