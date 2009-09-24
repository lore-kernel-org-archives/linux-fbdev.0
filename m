From: Jaswinder Singh Rajput <jaswinder@kernel.org>
Subject: [PATCH] video: includecheck fix: da8xx-fb.c
Date: Thu, 24 Sep 2009 16:37:10 +0530
Message-ID: <1253790430.5860.11.camel__39611.1376503997$1253790717$gmane$org@ht.satnam>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jaswinder@kernel.org>) id 1MqmBg-0003Z3-TF
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 24 Sep 2009 11:08:36 +0000
Received: from hera.kernel.org ([140.211.167.34])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MqmBb-0002IO-Tm
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 24 Sep 2009 11:08:36 +0000
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Kevin Hilman <khilman@deeprootsystems.com>, Krzysztof Helt <krzysztof.h1@wp.pl>, Pavel Kiryukhin <pkiryukhin@ru.mvista.com>, Steve Chen <schen@mvista.com>, Sudhakar Rajashekhara <sudh>


fix the following 'make includecheck' warning:

  drivers/video/da8xx-fb.c: linux/device.h is included more than once.

Signed-off-by: Jaswinder Singh Rajput <jaswinderrajput@gmail.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Krzysztof Helt <krzysztof.h1@wp.pl>
Cc: Pavel Kiryukhin <pkiryukhin@ru.mvista.com>
Cc: Steve Chen <schen@mvista.com>
Cc: Sudhakar Rajashekhara <sudhakar.raj@ti.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 drivers/video/da8xx-fb.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/video/da8xx-fb.c b/drivers/video/da8xx-fb.c
index 42e1005..d065894 100644
--- a/drivers/video/da8xx-fb.c
+++ b/drivers/video/da8xx-fb.c
@@ -26,7 +26,6 @@
 #include <linux/device.h>
 #include <linux/platform_device.h>
 #include <linux/uaccess.h>
-#include <linux/device.h>
 #include <linux/interrupt.h>
 #include <linux/clk.h>
 #include <video/da8xx-fb.h>
-- 
1.6.0.6



------------------------------------------------------------------------------
Come build with us! The BlackBerry&reg; Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9&#45;12, 2009. Register now&#33;
http://p.sf.net/sfu/devconf
