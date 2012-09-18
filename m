From: Peter Senna Tschudin <peter.senna@gmail.com>
Date: Tue, 18 Sep 2012 12:07:53 +0000
Subject: [PATCH 03/10] drivers/video/cg3.c: fix error return code
Message-Id: <1347970080-25175-3-git-send-email-peter.senna@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1347970080-25175-1-git-send-email-peter.senna@gmail.com>
In-Reply-To: <1347970080-25175-1-git-send-email-peter.senna@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: FlorianSchandinat@gmx.de
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Peter Senna Tschudin <peter.senna@gmail.com>

From: Peter Senna Tschudin <peter.senna@gmail.com>

Convert a nonnegative error return code to a negative one, as returned
elsewhere in the function.

A simplified version of the semantic match that finds this problem is as
follows: (http://coccinelle.lip6.fr/)

// <smpl>
(
if@p1 (\(ret < 0\|ret != 0\))
 { ... return ret; }
|
ret@p1 = 0
)
... when != ret = e1
    when != &ret
*if(...)
{
  ... when != ret = e2
      when forall
 return ret;
}
// </smpl>

Signed-off-by: Peter Senna Tschudin <peter.senna@gmail.com>
---
 drivers/video/cg3.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/video/cg3.c b/drivers/video/cg3.c
index f927a7b..c5e7612 100644
--- a/drivers/video/cg3.c
+++ b/drivers/video/cg3.c
@@ -398,7 +398,8 @@ static int __devinit cg3_probe(struct platform_device *op)
 			goto out_unmap_screen;
 	}
 
-	if (fb_alloc_cmap(&info->cmap, 256, 0))
+	err = fb_alloc_cmap(&info->cmap, 256, 0);
+	if (err)
 		goto out_unmap_screen;
 
 	fb_set_cmap(&info->cmap, info);
-- 
1.7.11.4

