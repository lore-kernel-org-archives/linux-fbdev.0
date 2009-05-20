From: Harald Welte <HaraldWelte@viatech.com>
Subject: [PATCH 02/15] [FB] viafb: Add missing break
	statement in switch
Date: Thu, 21 May 2009 04:28:40 +0800
Message-ID: <1242851333-325-2-git-send-email-HaraldWelte@viatech.com>
References: <1242851333-325-1-git-send-email-HaraldWelte@viatech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <laforge@prithivi.openmoko.org>) id 1M6sjR-0006L0-T9
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 20 May 2009 20:49:45 +0000
Received: from ganesha.gnumonks.org ([213.95.27.120])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1M6sjQ-0003q7-W7
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 20 May 2009 20:49:45 +0000
In-Reply-To: <1242851333-325-1-git-send-email-HaraldWelte@viatech.com>
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
Cc: Harald Welte <HaraldWelte@viatech.com>

From: Harald Welte <laforge@gnumonks.org>

Signed-off-by: Harald Welte <HaraldWelte@viatech.com>
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
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables 
unlimited royalty-free distribution of the report engine 
for externally facing server and web deployment. 
http://p.sf.net/sfu/businessobjects
