From: Juergen Gross <jgross@suse.com>
Date: Thu, 23 Mar 2017 12:52:52 +0000
Subject: [PATCH] xen, fbfront: fix connecting to backend
Message-Id: <20170323125252.11763-1-jgross@suse.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org, linux-fbdev@vger.kernel.org
Cc: b.zolnierkie@samsung.com, boris.ostrovsky@oracle.com, Juergen Gross <jgross@suse.com>, stable@vger.kernel.org

Connecting to the backend isn't working reliably in xen-fbfront: in
case XenbusStateInitWait of the backend has been missed the backend
transition to XenbusStateConnected will trigger the connected state
only without doing the actions required when the backend has
connected.

Cc: stable@vger.kernel.org
Signed-off-by: Juergen Gross <jgross@suse.com>
---
 drivers/video/fbdev/xen-fbfront.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/xen-fbfront.c b/drivers/video/fbdev/xen-fbfront.c
index d0115a7..3ee309c 100644
--- a/drivers/video/fbdev/xen-fbfront.c
+++ b/drivers/video/fbdev/xen-fbfront.c
@@ -643,7 +643,6 @@ static void xenfb_backend_changed(struct xenbus_device *dev,
 		break;
 
 	case XenbusStateInitWait:
-InitWait:
 		xenbus_switch_state(dev, XenbusStateConnected);
 		break;
 
@@ -654,7 +653,8 @@ static void xenfb_backend_changed(struct xenbus_device *dev,
 		 * get Connected twice here.
 		 */
 		if (dev->state != XenbusStateConnected)
-			goto InitWait; /* no InitWait seen yet, fudge it */
+			/* no InitWait seen yet, fudge it */
+			xenbus_switch_state(dev, XenbusStateConnected);
 
 		if (xenbus_read_unsigned(info->xbdev->otherend,
 					 "request-update", 0))
-- 
2.10.2

