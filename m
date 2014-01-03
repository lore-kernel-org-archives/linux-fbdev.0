From: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
Date: Fri, 03 Jan 2014 19:02:09 +0000
Subject: [PATCH v2] allow xenfb initialization for hvm guests
Message-Id: <1388775730-2984-1-git-send-email-stefano.stabellini@eu.citrix.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: xen-devel@lists.xensource.com
Cc: linux-kernel@vger.kernel.org, konrad.wilk@oracle.com, stefano.stabellini@eu.citrix.com, boris.ostrovsky@oracle.com, plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, linux-fbdev@vger.kernel.org

There is no reasons why an HVM guest shouldn't be allowed to use xenfb.
As a matter of fact ARM guests, HVM from Linux POV, can use xenfb.
Given that no Xen toolstacks configure a xenfb backend for x86 HVM
guests, they are not affected.

Please note that at this time QEMU needs few outstanding fixes to
provide xenfb on ARM:

http://marc.info/?l=qemu-devel&m8739419700837&w=2

Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
Acked-by: David Vrabel <david.vrabel@citrix.com>
CC: boris.ostrovsky@oracle.com
CC: plagnioj@jcrosoft.com
CC: tomi.valkeinen@ti.com
CC: linux-fbdev@vger.kernel.org
CC: konrad.wilk@oracle.com
---
 drivers/video/xen-fbfront.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/xen-fbfront.c b/drivers/video/xen-fbfront.c
index cd005c2..02e1c01 100644
--- a/drivers/video/xen-fbfront.c
+++ b/drivers/video/xen-fbfront.c
@@ -692,7 +692,7 @@ static DEFINE_XENBUS_DRIVER(xenfb, ,
 
 static int __init xenfb_init(void)
 {
-	if (!xen_pv_domain())
+	if (!xen_domain())
 		return -ENODEV;
 
 	/* Nothing to do if running in dom0. */
-- 
1.7.10.4

