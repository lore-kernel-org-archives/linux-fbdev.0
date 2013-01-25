From: Alexander Holler <holler@ahsoftware.de>
Date: Fri, 25 Jan 2013 18:49:27 +0000
Subject: [PATCH 2/3 v2] fb: udlfb: fix hang at disconnect
Message-Id: <1359139768-32294-2-git-send-email-holler@ahsoftware.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <50F2A310.5010006@ahsoftware.de>
 <1359139768-32294-1-git-send-email-holler@ahsoftware.de>
In-Reply-To: <1359139768-32294-1-git-send-email-holler@ahsoftware.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: linux-fbdev@vger.kernel.org, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, Bernie Thompson <bernie@plugable.com>, Steve Glendinning <steve.glendinning@shawell.net>, Alexander Holler <holler@ahsoftware.de>, stable@vger.kernel.org

When a device was disconnected the driver may hang at waiting for urbs it never
will get. Fix this by using a timeout while waiting for the used semaphore.

There is still a memory leak if a timeout happens, but at least the driver
now continues his disconnect routine.

Cc: <stable@vger.kernel.org>
Signed-off-by: Alexander Holler <holler@ahsoftware.de>
---
 drivers/video/udlfb.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/video/udlfb.c b/drivers/video/udlfb.c
index 86d449e..db6cc66 100644
--- a/drivers/video/udlfb.c
+++ b/drivers/video/udlfb.c
@@ -1832,8 +1832,9 @@ static void dlfb_free_urb_list(struct dlfb_data *dev)
 	/* keep waiting and freeing, until we've got 'em all */
 	while (count--) {
 
-		/* Getting interrupted means a leak, but ok at disconnect */
-		ret = down_interruptible(&dev->urbs.limit_sem);
+		/* Timeout likely occurs at disconnect (resulting in a leak) */
+		ret = down_timeout_killable(&dev->urbs.limit_sem,
+						FREE_URB_TIMEOUT);
 		if (ret)
 			break;
 
-- 
1.7.11.7

