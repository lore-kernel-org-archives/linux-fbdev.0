From: Peter Senna Tschudin <peter.senna@gmail.com>
Date: Tue, 18 Sep 2012 12:07:52 +0000
Subject: [PATCH 02/10] drivers/video/sunxvr1000.c: fix error return code
Message-Id: <1347970080-25175-2-git-send-email-peter.senna@gmail.com>
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
 drivers/video/sunxvr1000.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/video/sunxvr1000.c b/drivers/video/sunxvr1000.c
index b7f27ac..729a507 100644
--- a/drivers/video/sunxvr1000.c
+++ b/drivers/video/sunxvr1000.c
@@ -141,8 +141,10 @@ static int __devinit gfb_probe(struct platform_device *op)
 
 	gp->fb_base = of_ioremap(&op->resource[6], 0,
 				 gp->fb_size, "gfb fb");
-	if (!gp->fb_base)
+	if (!gp->fb_base) {
+		err = -ENOMEM;
 		goto err_release_fb;
+	}
 
 	err = gfb_set_fbinfo(gp);
 	if (err)
-- 
1.7.11.4

