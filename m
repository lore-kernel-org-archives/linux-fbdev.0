From: Juergen Gross <jgross@suse.com>
Date: Mon, 31 Oct 2016 16:48:28 +0000
Subject: [PATCH 10/12] xen: make use of xenbus_read_unsigned() in xen-fbfront
Message-Id: <1477932510-28594-11-git-send-email-jgross@suse.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1477932510-28594-1-git-send-email-jgross@suse.com>
In-Reply-To: <1477932510-28594-1-git-send-email-jgross@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, xen-devel@lists.xen.org
Cc: david.vrabel@citrix.com, boris.ostrovsky@oracle.com, Juergen Gross <jgross@suse.com>, tomi.valkeinen@ti.com, linux-fbdev@vger.kernel.org

Use xenbus_read_unsigned() instead of xenbus_scanf() when possible.
This requires to change the type of the reads from int to unsigned,
but these cases have been wrong before: negative values are not allowed
for the modified cases.

Cc: tomi.valkeinen@ti.com
Cc: linux-fbdev@vger.kernel.org

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 drivers/video/fbdev/xen-fbfront.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/video/fbdev/xen-fbfront.c b/drivers/video/fbdev/xen-fbfront.c
index 0567d51..d0115a7 100644
--- a/drivers/video/fbdev/xen-fbfront.c
+++ b/drivers/video/fbdev/xen-fbfront.c
@@ -633,7 +633,6 @@ static void xenfb_backend_changed(struct xenbus_device *dev,
 				  enum xenbus_state backend_state)
 {
 	struct xenfb_info *info = dev_get_drvdata(&dev->dev);
-	int val;
 
 	switch (backend_state) {
 	case XenbusStateInitialising:
@@ -657,16 +656,12 @@ static void xenfb_backend_changed(struct xenbus_device *dev,
 		if (dev->state != XenbusStateConnected)
 			goto InitWait; /* no InitWait seen yet, fudge it */
 
-		if (xenbus_scanf(XBT_NIL, info->xbdev->otherend,
-				 "request-update", "%d", &val) < 0)
-			val = 0;
-		if (val)
+		if (xenbus_read_unsigned(info->xbdev->otherend,
+					 "request-update", 0))
 			info->update_wanted = 1;
 
-		if (xenbus_scanf(XBT_NIL, dev->otherend,
-				 "feature-resize", "%d", &val) < 0)
-			val = 0;
-		info->feature_resize = val;
+		info->feature_resize = xenbus_read_unsigned(dev->otherend,
+							"feature-resize", 0);
 		break;
 
 	case XenbusStateClosed:
-- 
2.6.6

