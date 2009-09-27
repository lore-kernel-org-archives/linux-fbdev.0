From: Huang Weiyi <weiyi.huang@gmail.com>
Subject: [PATCH 3/5] fbdev: remove duplicated #include
Date: Sun, 27 Sep 2009 11:15:20 +0800
Message-ID: <1254021320-2920-1-git-send-email-weiyi.huang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <weiyi.huang@gmail.com>) id 1MrkEd-0003RG-Jn
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 27 Sep 2009 03:15:39 +0000
Received: from mail-px0-f194.google.com ([209.85.216.194])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MrkEW-0002zD-1u for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 27 Sep 2009 03:15:39 +0000
Received: by pxi32 with SMTP id 32so2723997pxi.4
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sat, 26 Sep 2009 20:15:26 -0700 (PDT)
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Huang Weiyi <weiyi.huang@gmail.com>

Remove duplicated #include('s) in
  drivers/video/msm/mddi.c

Signed-off-by: Huang Weiyi <weiyi.huang@gmail.com>
---
 drivers/video/msm/mddi.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/video/msm/mddi.c b/drivers/video/msm/mddi.c
index f2de5a1..b520f10 100644
--- a/drivers/video/msm/mddi.c
+++ b/drivers/video/msm/mddi.c
@@ -27,7 +27,6 @@
 #include <mach/msm_iomap.h>
 #include <mach/irqs.h>
 #include <mach/board.h>
-#include <linux/delay.h>
 
 #include <mach/msm_fb.h>
 #include "mddi_hw.h"
-- 
1.6.1.3


------------------------------------------------------------------------------
Come build with us! The BlackBerry&reg; Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9&#45;12, 2009. Register now&#33;
http://p.sf.net/sfu/devconf
