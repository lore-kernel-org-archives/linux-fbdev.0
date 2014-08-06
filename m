From: Julia Lawall <Julia.Lawall@lip6.fr>
Date: Wed, 06 Aug 2014 20:12:18 +0000
Subject: [PATCH 4/4] drivers: video: fbdev: atmel_lcdfb.c: fix error return code
Message-Id: <1407355938-10932-4-git-send-email-Julia.Lawall@lip6.fr>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: kernel-janitors@vger.kernel.org, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

From: Julia Lawall <Julia.Lawall@lip6.fr>

Convert a zero return value on error to a negative one, as returned
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

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
The error codes chosen are the ones that are commonly used elsewhere or
these functions.  Perhaps something else is wanted.

 drivers/video/fbdev/atmel_lcdfb.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/video/fbdev/atmel_lcdfb.c b/drivers/video/fbdev/atmel_lcdfb.c
index 92640d4..1d8bdb9 100644
--- a/drivers/video/fbdev/atmel_lcdfb.c
+++ b/drivers/video/fbdev/atmel_lcdfb.c
@@ -1102,12 +1102,14 @@ static int atmel_lcdfb_of_init(struct atmel_lcdfb_info *sinfo)
 	timings = of_get_display_timings(display_np);
 	if (!timings) {
 		dev_err(dev, "failed to get display timings\n");
+		ret = -EINVAL;
 		goto put_display_node;
 	}
 
 	timings_np = of_find_node_by_name(display_np, "display-timings");
 	if (!timings_np) {
 		dev_err(dev, "failed to find display-timings node\n");
+		ret = -ENODEV;
 		goto put_display_node;
 	}
 

