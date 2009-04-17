From: Troy Kisky <troy.kisky@boundarydevices.com>
Subject: [PATCH] Fix edid hsync offset and width parsing.
Date: Thu, 16 Apr 2009 23:04:48 -0700
Message-ID: <1239948288-4325-1-git-send-email-troy.kisky@boundarydevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <tkisky@boundarydevices.com>) id 1LuhR5-0005mU-Ph
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 17 Apr 2009 06:20:27 +0000
Received: from mpls-qmqp-03.inet.qwest.net ([63.231.195.114])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1LuhR4-00083b-PU for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 17 Apr 2009 06:20:27 +0000
In-Reply-To: <>
References: <>
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
Cc: adaplas@gmail.com, Troy Kisky <troy.kisky@boundarydevices.com>

Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>

I cannot test this, but it looks like a bug fix.
---
 drivers/video/edid.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/edid.h b/drivers/video/edid.h
index bd89fb3..c2d98de 100644
--- a/drivers/video/edid.h
+++ b/drivers/video/edid.h
@@ -101,8 +101,8 @@
 #define V_SYNC_WIDTH       COMBINE_HI_4LO( V_SYNC_WIDTH_HI, V_SYNC_WIDTH_LO )
 #define V_SYNC_OFFSET      COMBINE_HI_4LO( V_SYNC_OFFSET_HI, V_SYNC_OFFSET_LO )
 
-#define H_SYNC_WIDTH       COMBINE_HI_4LO( H_SYNC_WIDTH_HI, H_SYNC_WIDTH_LO )
-#define H_SYNC_OFFSET      COMBINE_HI_4LO( H_SYNC_OFFSET_HI, H_SYNC_OFFSET_LO )
+#define H_SYNC_WIDTH       COMBINE_HI_8LO(H_SYNC_WIDTH_HI, H_SYNC_WIDTH_LO)
+#define H_SYNC_OFFSET      COMBINE_HI_8LO(H_SYNC_OFFSET_HI, H_SYNC_OFFSET_LO)
 
 #define H_SIZE_LO          (unsigned)block[ 12 ]
 #define V_SIZE_LO          (unsigned)block[ 13 ]
-- 
1.5.4.3


------------------------------------------------------------------------------
Stay on top of everything new and different, both inside and 
around Java (TM) technology - register by April 22, and save
$200 on the JavaOne (SM) conference, June 2-5, 2009, San Francisco.
300 plus technical and hands-on sessions. Register today. 
Use priority code J9JMT32. http://p.sf.net/sfu/p
