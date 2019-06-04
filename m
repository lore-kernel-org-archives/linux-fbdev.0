From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Date: Tue, 04 Jun 2019 23:32:05 +0000
Subject: [PATCH] video: fbdev-MMP: Use struct_size() in devm_kzalloc()
Message-Id: <20190604233205.GA5377@embeddedor>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>

One of the more common cases of allocation size calculations is finding
the size of a structure that has a zero-sized array at the end, along
with memory for some number of elements for that array. For example:

struct foo {
    int stuff;
    struct boo entry[];
};

size = sizeof(struct foo) + count * sizeof(struct boo);
instance = devm_kzalloc(dev, size, GFP_KERNEL);

Instead of leaving these open-coded and prone to type mistakes, we can
now use the new struct_size() helper:

instance = devm_kzalloc(dev, struct_size(instance, entry, count), GFP_KERNEL);

Notice that, in this case, variable size is not necessary, hence it
is removed.

This code was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/video/fbdev/mmp/hw/mmp_ctrl.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/mmp/hw/mmp_ctrl.c b/drivers/video/fbdev/mmp/hw/mmp_ctrl.c
index 87d943f15a12..17174cd7a5bb 100644
--- a/drivers/video/fbdev/mmp/hw/mmp_ctrl.c
+++ b/drivers/video/fbdev/mmp/hw/mmp_ctrl.c
@@ -433,7 +433,7 @@ static int mmphw_probe(struct platform_device *pdev)
 {
 	struct mmp_mach_plat_info *mi;
 	struct resource *res;
-	int ret, i, size, irq;
+	int ret, i, irq;
 	struct mmphw_path_plat *path_plat;
 	struct mmphw_ctrl *ctrl = NULL;
 
@@ -461,9 +461,9 @@ static int mmphw_probe(struct platform_device *pdev)
 	}
 
 	/* allocate */
-	size = sizeof(struct mmphw_ctrl) + sizeof(struct mmphw_path_plat) *
-	       mi->path_num;
-	ctrl = devm_kzalloc(&pdev->dev, size, GFP_KERNEL);
+	ctrl = devm_kzalloc(&pdev->dev,
+			    struct_size(ctrl, path_plats, mi->path_num),
+			    GFP_KERNEL);
 	if (!ctrl) {
 		ret = -ENOMEM;
 		goto failed;
-- 
2.21.0
