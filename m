From: Michal Januszewski <spock@gentoo.org>
Subject: [PATCH] fbcon: don't draw cursor when it's
	disabled
Date: Sun, 1 Apr 2007 14:47:44 +0200
Message-ID: <20070401124744.GB4040@spock.one.pl>
Reply-To: spock@gentoo.org, linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HXzTP-0001RX-9m for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 01 Apr 2007 05:47:55 -0700
Received: from ipn26-148.piekary.net ([83.238.26.148])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HXzTN-0006As-SA
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 01 Apr 2007 05:47:55 -0700
Content-Disposition: inline
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org

From: Michal Januszewski <spock@gentoo.org>

When the cursor and echo are disabled on the current console, pressing a
key will cause a black rectangle to be painted in the cursor's position.
Fix this by not touching the framebuffer in fbcon_cursor() when the
cursor is off.

Signed-off-by: Michal Januszewski <spock@gentoo.org>
---

 drivers/video/console/fbcon.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/console/fbcon.c b/drivers/video/console/fbcon.c
index f721341..7089aa8 100644
--- a/drivers/video/console/fbcon.c
+++ b/drivers/video/console/fbcon.c
@@ -1330,7 +1330,7 @@ static void fbcon_cursor(struct vc_data *vc, int mode)
 	int y;
  	int c = scr_readw((u16 *) vc->vc_pos);
 
-	if (fbcon_is_inactive(vc, info))
+	if (fbcon_is_inactive(vc, info) || vc->vc_deccm != 1)
 		return;
 
 	ops->cursor_flash = (mode == CM_ERASE) ? 0 : 1;


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
