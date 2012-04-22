From: Julia Lawall <Julia.Lawall@lip6.fr>
Date: Sun, 22 Apr 2012 09:57:40 +0000
Subject: [PATCH] drivers/video/xen-fbfront.c: add missing cleanup code
Message-Id: <1335088660-13219-1-git-send-email-Julia.Lawall@lip6.fr>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: kernel-janitors@vger.kernel.org, Jeremy Fitzhardinge <jeremy@goop.org>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, xen-devel@lists.xensource.com, virtualization@lists.linux-foundation.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

From: Julia Lawall <Julia.Lawall@lip6.fr>

The operations in the subsequent error-handling code appear to be also
useful here.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
Not tested.

 drivers/video/xen-fbfront.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/video/xen-fbfront.c b/drivers/video/xen-fbfront.c
index cb4529c..b0bd59c 100644
--- a/drivers/video/xen-fbfront.c
+++ b/drivers/video/xen-fbfront.c
@@ -458,8 +458,13 @@ static int __devinit xenfb_probe(struct xenbus_device *dev,
 	xenfb_init_shared_page(info, fb_info);
 
 	ret = xenfb_connect_backend(dev, info);
-	if (ret < 0)
+	if (ret < 0) {
+		fb_deferred_io_cleanup(fb_info);
+		fb_dealloc_cmap(&fb_info->cmap);
+		framebuffer_release(fb_info);
+		xenbus_dev_fatal(dev, ret, "xenfb_connect_backend");
 		goto error;
+	}
 
 	ret = register_framebuffer(fb_info);
 	if (ret) {

