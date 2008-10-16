From: Huang Weiyi <weiyi.huang@gmail.com>
Subject: viafb: removed duplicated #include's
Date: Fri, 17 Oct 2008 06:53:24 +0800
Message-ID: <20081017065315.2AEF.WEIYI.HUANG@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <weiyi.huang@gmail.com>) id 1Kqbim-0005eo-O0
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 16 Oct 2008 22:53:32 +0000
Received: from ti-out-0910.google.com ([209.85.142.191])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Kqbii-0002bq-7v for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 16 Oct 2008 22:53:32 +0000
Received: by ti-out-0910.google.com with SMTP id y6so95778tia.18
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 16 Oct 2008 15:53:26 -0700 (PDT)
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: JosephChan@via.com.tw, ScottFang@viatech.com.cn
Cc: linux-fbdev-devel@lists.sourceforge.net

Removed duplicated #include's in drivers/video/via/global.h.
  debug.h
  viafbdev.h
  viamode.h

Signed-off-by: Huang Weiyi <weiyi.huang@gmail.com>

diff --git a/drivers/video/via/global.h b/drivers/video/via/global.h
index 8e5263c..7543d5f 100644
--- a/drivers/video/via/global.h
+++ b/drivers/video/via/global.h
@@ -38,7 +38,6 @@
 #include "iface.h"
 #include "viafbdev.h"
 #include "chip.h"
-#include "debug.h"
 #include "accel.h"
 #include "share.h"
 #include "dvi.h"
@@ -48,12 +47,10 @@

 #include "lcd.h"
 #include "ioctl.h"
-#include "viamode.h"
 #include "via_utility.h"
 #include "vt1636.h"
 #include "tblDPASetting.h"
 #include "tbl1636.h"
-#include "viafbdev.h"

 /* External struct*/




-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
