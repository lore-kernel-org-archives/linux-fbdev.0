From: Peter Senna Tschudin <peter.senna@gmail.com>
Date: Tue, 18 Sep 2012 12:07:59 +0000
Subject: [PATCH 09/10] drivers/video/ps3fb.c: fix error return code
Message-Id: <1347970080-25175-9-git-send-email-peter.senna@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1347970080-25175-1-git-send-email-peter.senna@gmail.com>
In-Reply-To: <1347970080-25175-1-git-send-email-peter.senna@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: geoff@infradead.org
Cc: cbe-oss-dev@lists.ozlabs.org, linux-fbdev@vger.kernel.org, FlorianSchandinat@gmx.de, Peter Senna Tschudin <peter.senna@gmail.com>, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org

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
 drivers/video/ps3fb.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/video/ps3fb.c b/drivers/video/ps3fb.c
index 4e292f2..0b340d6 100644
--- a/drivers/video/ps3fb.c
+++ b/drivers/video/ps3fb.c
@@ -1034,6 +1034,7 @@ static int __devinit ps3fb_probe(struct ps3_system_bus_device *dev)
 	if (status) {
 		dev_err(&dev->core, "%s: lv1_gpu_memory_allocate failed: %d\n",
 			__func__, status);
+		retval = -ENOMEM;
 		goto err_close_device;
 	}
 	dev_dbg(&dev->core, "ddr:lpar:0x%llx\n", ddr_lpar);
@@ -1046,6 +1047,7 @@ static int __devinit ps3fb_probe(struct ps3_system_bus_device *dev)
 		dev_err(&dev->core,
 			"%s: lv1_gpu_context_allocate failed: %d\n", __func__,
 			status);
+		retval = -ENOMEM;
 		goto err_gpu_memory_free;
 	}
 
@@ -1053,6 +1055,7 @@ static int __devinit ps3fb_probe(struct ps3_system_bus_device *dev)
 	dinfo = (void __force *)ioremap(lpar_driver_info, 128 * 1024);
 	if (!dinfo) {
 		dev_err(&dev->core, "%s: ioremap failed\n", __func__);
+		retval = -ENOMEM;
 		goto err_gpu_context_free;
 	}
 
@@ -1121,8 +1124,10 @@ static int __devinit ps3fb_probe(struct ps3_system_bus_device *dev)
 	}
 
 	info = framebuffer_alloc(sizeof(struct ps3fb_par), &dev->core);
-	if (!info)
+	if (!info) {
+		retval = -ENOMEM;
 		goto err_context_fb_close;
+	}
 
 	par = info->par;
 	par->mode_id = ~ps3fb_mode;	/* != ps3fb_mode, to trigger change */
-- 
1.7.11.4

