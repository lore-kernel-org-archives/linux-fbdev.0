From: David Howells <dhowells@redhat.com>
Date: Wed, 15 Jun 2011 00:38:17 +0000
Subject: [PATCH] EFIFB: Fix error handling
Message-Id: <20110615003817.18883.41030.stgit@warthog.procyon.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: pjones@redhat.com
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>, linux-fbdev@vger.kernel.org, stable@kernel.org

Fix the error handling in the EFIFB driver if platform_driver_probe() fails.
In that case, the code will pass the driver struct to the _device_
unregistration function.  It presumably should pass a pointer to the device
struct instead.

The compiler gives the following warning to indicate this:

drivers/video/efifb.c: In function 'efifb_init':
drivers/video/efifb.c:544:3: warning: passing argument 1 of 'platform_device_unregister' from incompatible pointer type
include/linux/platform_device.h:40:13: note: expected 'struct platform_device *' but argument is of type 'struct platform_driver *'

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Peter Jones <pjones@redhat.com>
cc: linux-fbdev@vger.kernel.org
cc: stable@kernel.org
---

 drivers/video/efifb.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/efifb.c b/drivers/video/efifb.c
index 69c49df..784139a 100644
--- a/drivers/video/efifb.c
+++ b/drivers/video/efifb.c
@@ -541,7 +541,7 @@ static int __init efifb_init(void)
 	 */
 	ret = platform_driver_probe(&efifb_driver, efifb_probe);
 	if (ret) {
-		platform_device_unregister(&efifb_driver);
+		platform_device_unregister(&efifb_device);
 		return ret;
 	}
 

