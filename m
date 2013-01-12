From: Alexander Holler <holler@ahsoftware.de>
Date: Sat, 12 Jan 2013 13:20:22 +0000
Subject: [PATCH] fb: udlfb: fix hang at disconnect
Message-Id: <1357996822-13072-1-git-send-email-holler@ahsoftware.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: linux-fbdev@vger.kernel.org, Bernie Thompson <bernie@plugable.com>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Steve Glendinning <steve.glendinning@shawell.net>, Dave Airlie <airlied@redhat.com>, Alexander Holler <holler@ahsoftware.de>, stable@vger.kernel.org

When a device was disconnected the driver may hang at waiting for urbs it never
will get. Fix this by using a timeout while waiting for the used semaphore.

There is still a memory leak if a timeout happens, but at least the driver
now continues his disconnect routine.

Cc: <stable@vger.kernel.org>
Signed-off-by: Alexander Holler <holler@ahsoftware.de>
---
 drivers/video/udlfb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/udlfb.c b/drivers/video/udlfb.c
index 86d449e..cc4a8d1 100644
--- a/drivers/video/udlfb.c
+++ b/drivers/video/udlfb.c
@@ -1832,8 +1832,8 @@ static void dlfb_free_urb_list(struct dlfb_data *dev)
 	/* keep waiting and freeing, until we've got 'em all */
 	while (count--) {
 
-		/* Getting interrupted means a leak, but ok at disconnect */
-		ret = down_interruptible(&dev->urbs.limit_sem);
+		/* Timeout likely occurs at disconnect (resulting in a leak) */
+		ret = down_timeout(&dev->urbs.limit_sem, GET_URB_TIMEOUT);
 		if (ret)
 			break;
 
-- 
1.7.11.7

