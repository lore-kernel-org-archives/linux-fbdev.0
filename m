From: "Jan Beulich" <JBeulich@suse.com>
Date: Thu, 07 Jul 2016 07:48:53 +0000
Subject: [PATCH] xen-fbfront: correct return value checks on xenbus_scanf()
Message-Id: <577E258502000078000FBE6F@prv-mh.provo.novell.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: plagnioj@jcrosoft.com, tomi.valkeinen@ti.com
Cc: Juergen Gross <JGross@suse.com>, xen-devel@lists.xenproject.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>, David Vrabel <david.vrabel@citrix.com>, linux-fbdev <linux-fbdev@vger.kernel.org>

Only a positive return value indicates success.

Signed-off-by: Jan Beulich <jbeulich@suse.com>
---
 drivers/video/fbdev/xen-fbfront.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- 4.7-rc6-xenbus_scanf.orig/drivers/video/fbdev/xen-fbfront.c
+++ 4.7-rc6-xenbus_scanf/drivers/video/fbdev/xen-fbfront.c
@@ -658,13 +658,13 @@ InitWait:
 			goto InitWait; /* no InitWait seen yet, fudge it */
 
 		if (xenbus_scanf(XBT_NIL, info->xbdev->otherend,
-				 "request-update", "%d", &val) < 0)
+				 "request-update", "%d", &val) <= 0)
 			val = 0;
 		if (val)
 			info->update_wanted = 1;
 
 		if (xenbus_scanf(XBT_NIL, dev->otherend,
-				 "feature-resize", "%d", &val) < 0)
+				 "feature-resize", "%d", &val) <= 0)
 			val = 0;
 		info->feature_resize = val;
 		break;



