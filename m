From: Peter Senna Tschudin <peter.senna@gmail.com>
Date: Tue, 18 Sep 2012 12:07:57 +0000
Subject: [PATCH 07/10] drivers/video/bw2.c: fix error return code
Message-Id: <1347970080-25175-7-git-send-email-peter.senna@gmail.com>
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
 drivers/video/bw2.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/video/bw2.c b/drivers/video/bw2.c
index 7ba74cd..6bea9a9 100644
--- a/drivers/video/bw2.c
+++ b/drivers/video/bw2.c
@@ -319,8 +319,10 @@ static int __devinit bw2_probe(struct platform_device *op)
 
 	info->screen_base = of_ioremap(&op->resource[0], 0,
 				       info->fix.smem_len, "bw2 ram");
-	if (!info->screen_base)
+	if (!info->screen_base) {
+		err = -ENOMEM;
 		goto out_unmap_regs;
+	}
 
 	bw2_blank(FB_BLANK_UNBLANK, info);
 
-- 
1.7.11.4

