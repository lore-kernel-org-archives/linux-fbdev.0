From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH] remove makefile reference to removed
	driver
Date: Mon, 4 May 2009 18:54:01 +0200
Message-ID: <20090504185401.c36a4a9d.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <krzysztof.h1@poczta.fm>) id 1M11M6-0000Cf-GW
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 04 May 2009 16:49:26 +0000
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1M11M5-00048E-6h for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 04 May 2009 16:49:26 +0000
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>
Cc: Andrew Morton <akpm@linux-foundation.org>

From: Krzysztof Helt <krzysztof.h1@wp.pl>

The cyblafb driver is removed so
remove its last track in the makefile.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---
It would be nice to have this patch in the 2.6.30
as the rest of the cyblafb driver has been removed
in the 2.6.30.

 drivers/video/Makefile |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/video/Makefile b/drivers/video/Makefile
index 0dbd6c6..d8d0be5 100644
--- a/drivers/video/Makefile
+++ b/drivers/video/Makefile
@@ -56,7 +56,6 @@ obj-$(CONFIG_FB_CT65550)          += chipsfb.o
 obj-$(CONFIG_FB_IMSTT)            += imsttfb.o
 obj-$(CONFIG_FB_FM2)              += fm2fb.o
 obj-$(CONFIG_FB_VT8623)           += vt8623fb.o
-obj-$(CONFIG_FB_CYBLA)            += cyblafb.o
 obj-$(CONFIG_FB_TRIDENT)          += tridentfb.o
 obj-$(CONFIG_FB_LE80578)          += vermilion/
 obj-$(CONFIG_FB_S3)               += s3fb.o
-- 
1.6.0.3


----------------------------------------------------------------------
Gotowka na koncie. Otworz konto direct i wez podwojny limit. 	 
http://link.interia.pl/f2145


------------------------------------------------------------------------------
Register Now & Save for Velocity, the Web Performance & Operations 
Conference from O'Reilly Media. Velocity features a full day of 
expert-led, hands-on workshops and two days of sessions from industry 
leaders in dedicated Performance & Operations tracks. Use code vel09scf 
and Save an extra 15% before 5/3. http://p.sf.net/sfu/velocityconf
