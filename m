From: Julia Lawall <julia@diku.dk>
Date: Fri, 01 Apr 2011 14:23:47 +0000
Subject: [PATCH 6/6] drivers/video/bfin-lq035q1-fb.c: introduce missing kfree
Message-Id: <1301667827-20056-6-git-send-email-julia@diku.dk>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Mundt <lethal@linux-sh.org>
Cc: kernel-janitors@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

Error handling code following a kmalloc should free the allocated data.

The semantic match that finds the problem is as follows:
(http://www.emn.fr/x-info/coccinelle/)

// <smpl>
@r exists@
local idexpression x;
statement S;
expression E;
identifier f,f1,l;
position p1,p2;
expression *ptr != NULL;
@@

x@p1 = \(kmalloc\|kzalloc\|kcalloc\)(...);
...
if (x = NULL) S
<... when != x
     when != if (...) { <+...x...+> }
(
x->f1 = E
|
 (x->f1 = NULL || ...)
|
 f(...,x->f1,...)
)
...>
(
 return \(0\|<+...x...+>\|ptr\);
|
 return@p2 ...;
)

@script:python@
p1 << r.p1;
p2 << r.p2;
@@

print "* file: %s kmalloc %s return %s" % (p1[0].file,p1[0].line,p2[0].line)
// </smpl>

Signed-off-by: Julia Lawall <julia@diku.dk>

---
 drivers/video/bfin-lq035q1-fb.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/video/bfin-lq035q1-fb.c b/drivers/video/bfin-lq035q1-fb.c
index c8e1f04..23b6c4b 100644
--- a/drivers/video/bfin-lq035q1-fb.c
+++ b/drivers/video/bfin-lq035q1-fb.c
@@ -154,8 +154,10 @@ static int __devinit lq035q1_spidev_probe(struct spi_device *spi)
 
 	ret = lq035q1_control(spi, LQ035_SHUT_CTL, LQ035_ON);
 	ret |= lq035q1_control(spi, LQ035_DRIVER_OUTPUT_CTL, ctl->mode);
-	if (ret)
+	if (ret) {
+		kfree(ctl);
 		return ret;
+	}
 
 	spi_set_drvdata(spi, ctl);
 

