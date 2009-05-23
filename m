From: Harald Welte <HaraldWelte@viatech.com>
Subject: [PATCH 01/14] [FB] viafb: Add missing break
	statement in switch
Date: Sat, 23 May 2009 17:41:23 +0800
Message-ID: <1243071696-9334-1-git-send-email-HaraldWelte@viatech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <laforge@prithivi.openmoko.org>) id 1M7nsD-0005Je-8k
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 23 May 2009 09:50:37 +0000
Received: from ganesha.gnumonks.org ([213.95.27.120])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1M7ns5-0007uP-V0
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 23 May 2009 09:50:37 +0000
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
Cc: Andrew Morton <akpm@linux-foundation.org>, Harald Welte <HaraldWelte@viatech.com>

From: Harald Welte <laforge@gnumonks.org>

Signed-off-by: Harald Welte <HaraldWelte@viatech.com>
Acked-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---
 drivers/video/via/hw.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/video/via/hw.c b/drivers/video/via/hw.c
index fcd53ce..59ddf09 100644
--- a/drivers/video/via/hw.c
+++ b/drivers/video/via/hw.c
@@ -2272,6 +2272,7 @@ int viafb_setmode(int vmode_index, int hor_res, int ver_res, int video_bpp,
 
 	case UNICHROME_CX700:
 		viafb_write_regx(CX700_ModeXregs, NUM_TOTAL_CX700_ModeXregs);
+		break;
 
 	case UNICHROME_VX800:
 		viafb_write_regx(VX800_ModeXregs, NUM_TOTAL_VX800_ModeXregs);
-- 
1.6.2.4


------------------------------------------------------------------------------
Register Now for Creativity and Technology (CaT), June 3rd, NYC. CaT
is a gathering of tech-side developers & brand creativity professionals. Meet
the minds behind Google Creative Lab, Visual Complexity, Processing, & 
iPhoneDevCamp asthey present alongside digital heavyweights like Barbarian
Group, R/GA, & Big Spaceship. http://www.creativitycat.com 
