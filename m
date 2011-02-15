From: Axel Lin <axel.lin@gmail.com>
Date: Tue, 15 Feb 2011 09:35:02 +0000
Subject: [PATCH] video: add missing framebuffer_release in error path
Message-Id: <1297762502.4049.2.camel@phoenix>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Paul Mundt <lethal@linux-sh.org>, linux-fbdev@vger.kernel.org

This patch fixes a memory leak in the error path.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 drivers/video/cg14.c |    1 +
 drivers/video/cg6.c  |    1 +
 drivers/video/tcx.c  |    1 +
 3 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/video/cg14.c b/drivers/video/cg14.c
index 2424953..2063a63 100644
--- a/drivers/video/cg14.c
+++ b/drivers/video/cg14.c
@@ -565,6 +565,7 @@ out_dealloc_cmap:
 
 out_unmap_regs:
 	cg14_unmap_regs(op, info, par);
+	framebuffer_release(info);
 
 out_err:
 	return err;
diff --git a/drivers/video/cg6.c b/drivers/video/cg6.c
index 2b5a970..f3b8848 100644
--- a/drivers/video/cg6.c
+++ b/drivers/video/cg6.c
@@ -822,6 +822,7 @@ out_dealloc_cmap:
 
 out_unmap_regs:
 	cg6_unmap_regs(op, info, par);
+	framebuffer_release(info);
 
 out_err:
 	return err;
diff --git a/drivers/video/tcx.c b/drivers/video/tcx.c
index 77ad279..3d84235 100644
--- a/drivers/video/tcx.c
+++ b/drivers/video/tcx.c
@@ -481,6 +481,7 @@ out_dealloc_cmap:
 
 out_unmap_regs:
 	tcx_unmap_regs(op, info, par);
+	framebuffer_release(info);
 
 out_err:
 	return err;
-- 
1.7.1



