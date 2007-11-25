From: Ville Syrjala <syrjala@sci.fi>
Subject: [PATCH 6/7] sm501: Remove a misplaced x
	character
Date: Sun, 25 Nov 2007 22:01:31 +0200
Message-ID: <11960208934176-git-send-email-syrjala@sci.fi>
References: <1196020892591-git-send-email-syrjala@sci.fi>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IwNfg-0002Rz-6E for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 25 Nov 2007 12:01:40 -0800
Received: from smtp6.pp.htv.fi ([213.243.153.40])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IwNfd-0000p9-NM
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 25 Nov 2007 12:01:40 -0800
In-Reply-To: <1196020892591-git-send-email-syrjala@sci.fi>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net
Cc: ben@simtec.co.uk, vince@simtec.co.uk, Ville Syrjala <syrjala@sci.fi>

sm501.c doesn't compile with debug enabled due to a misplaced x character.

Signed-off-by: Ville Syrjala <syrjala@sci.fi>
---
 drivers/mfd/sm501.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mfd/sm501.c b/drivers/mfd/sm501.c
index f31947c..4de8d46 100644
--- a/drivers/mfd/sm501.c
+++ b/drivers/mfd/sm501.c
@@ -137,7 +137,7 @@ static void sm501_dump_clk(struct sm501_devdata *sm)
 
 	dev_dbg(sm->dev, "PM0[%c]: "
 		 "P2 %ld.%ld MHz (%ld), V2 %ld.%ld (%ld), "
-x		 "M %ld.%ld (%ld), MX1 %ld.%ld (%ld)\n",
+		 "M %ld.%ld (%ld), MX1 %ld.%ld (%ld)\n",
 		 (pmc & 3 ) == 0 ? '*' : '-',
 		 fmt_freq(decode_div(pll2, pm0, 24, 1<<29, 31)),
 		 fmt_freq(decode_div(pll2, pm0, 16, 1<<20, 15)),
-- 
1.5.2.5


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
