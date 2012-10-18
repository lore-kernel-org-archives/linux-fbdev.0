From: David Vrabel <david.vrabel@citrix.com>
Date: Thu, 18 Oct 2012 10:03:37 +0000
Subject: [PATCH 4/5] xen-fbfront: handle backend CLOSED without CLOSING
Message-Id: <1350554618-14582-4-git-send-email-david.vrabel@citrix.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <507FD39F.4060601@citrix.com>
In-Reply-To: <507FD39F.4060601@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: xen-devel@lists.xen.org
Cc: David Vrabel <david.vrabel@citrix.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>

From: David Vrabel <david.vrabel@citrix.com>

Backend drivers shouldn't transistion to CLOSED unless the frontend is
CLOSED.  If a backend does transition to CLOSED too soon then the
frontend may not see the CLOSING state and will not properly shutdown.

So, treat an unexpected backend CLOSED state the same as CLOSING.

Signed-off-by: David Vrabel <david.vrabel@citrix.com>
Acked-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
---
Cc: linux-fbdev@vger.kernel.org
Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
---
 drivers/video/xen-fbfront.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/video/xen-fbfront.c b/drivers/video/xen-fbfront.c
index b7f5173..917bb56 100644
--- a/drivers/video/xen-fbfront.c
+++ b/drivers/video/xen-fbfront.c
@@ -641,7 +641,6 @@ static void xenfb_backend_changed(struct xenbus_device *dev,
 	case XenbusStateReconfiguring:
 	case XenbusStateReconfigured:
 	case XenbusStateUnknown:
-	case XenbusStateClosed:
 		break;
 
 	case XenbusStateInitWait:
@@ -670,6 +669,10 @@ InitWait:
 		info->feature_resize = val;
 		break;
 
+	case XenbusStateClosed:
+		if (dev->state = XenbusStateClosed)
+			break;
+		/* Missed the backend's CLOSING state -- fallthrough */
 	case XenbusStateClosing:
 		xenbus_frontend_closed(dev);
 		break;
-- 
1.7.2.5

