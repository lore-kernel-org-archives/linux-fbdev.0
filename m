From: "Jordan Crouse" <jordan.crouse@amd.com>
Subject: [PATCH 4/4] [PATCH] gxfb: Add timings for the
	OLPC LCD
Date: Mon, 24 Jul 2006 10:56:07 -0600
Message-ID: <20060724165607.18822.38609.stgit@cosmic.amd.com>
References: <20060724165454.18822.30310.stgit@cosmic.amd.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1G548v-0006Xp-Gk for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 24 Jul 2006 10:22:57 -0700
Received: from outbound-fra.frontbridge.com ([62.209.45.174]
	helo=outbound2-fra-R.bigfish.com)
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44) id 1G548u-0004p8-Lg
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 24 Jul 2006 10:22:57 -0700
In-Reply-To: <20060724165454.18822.30310.stgit@cosmic.amd.com>
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
To: akpm@osdl.org
Cc: blizzard@redhat.com, dwmw2@redhat.com, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

From: Jordan Crouse <jordan.crouse@amd.com>

Add a mode for the OLPC LCD.

Signed-off-by: Jordan Crouse <jordan.crouse@amd.com>
---

 drivers/video/geode/gxfb_core.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/video/geode/gxfb_core.c b/drivers/video/geode/gxfb_core.c
index 1e0d47e..75c7fd9 100644
--- a/drivers/video/geode/gxfb_core.c
+++ b/drivers/video/geode/gxfb_core.c
@@ -103,6 +103,9 @@ static const struct fb_videomode __initd
 	{ NULL, 85, 1600, 1200, 4357, 304, 64, 46, 1, 192, 3,
 	  FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
 	  FB_VMODE_NONINTERLACED, FB_MODE_IS_VESA },
+	{ "OLPC-1", 50, 1200, 900, 17460, 24, 8, 4, 5, 8, 3,
+	  FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
+	  FB_VMODE_NONINTERLACED, 0 }
 };
 
 static int gxfb_check_var(struct fb_var_screeninfo *var, struct fb_info *info)



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
