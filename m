From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 1/4] fbdev: Fix Sharp UXGA checking
Date: Mon, 05 Mar 2007 17:49:30 +0800
Message-ID: <45EBE7AA.8050601@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HO9re-0000a6-9c for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 05 Mar 2007 01:52:18 -0800
Received: from nz-out-0506.google.com ([64.233.162.239])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HO9rc-0003eB-Ol
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 05 Mar 2007 01:52:18 -0800
Received: by nz-out-0506.google.com with SMTP id i11so2494886nzi
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 05 Mar 2007 01:52:16 -0800 (PST)
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

If the Ultrasharp UXGA is detected, the check function returns a nonzero
value.  It should return the type of fix instead.

Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/fbmon.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/video/fbmon.c b/drivers/video/fbmon.c
index 05a9464..438b941 100644
--- a/drivers/video/fbmon.c
+++ b/drivers/video/fbmon.c
@@ -183,10 +183,11 @@ static int check_edid(unsigned char *edi
 		break;
 	case FBMON_FIX_TIMINGS:
 		b = edid + DETAILED_TIMING_DESCRIPTIONS_START;
+		ret = fix;
 
 		for (i = 0; i < 4; i++) {
 			if (edid_is_limits_block(b)) {
-				ret = fix;
+				ret = 0;
 				break;
 			}
 


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
