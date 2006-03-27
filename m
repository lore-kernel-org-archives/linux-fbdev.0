From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 1/7] fbcon: Save current display during initialization
Date: Mon, 27 Mar 2006 20:58:42 +0800
Message-ID: <4427E182.70402@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FNrXB-0002XQ-Sn
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 27 Mar 2006 05:13:25 -0800
Received: from xproxy.gmail.com ([66.249.82.196])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FNrXB-0007zZ-B0
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 27 Mar 2006 05:13:25 -0800
Received: by xproxy.gmail.com with SMTP id t4so937073wxc
        for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 27 Mar 2006 05:13:25 -0800 (PST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

The current display was not saved during initialization.  This leads to
hard to track console corruption, such as a misplaced cursor, which is
correctible by switching consoles.  Fix this minor bug.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/console/fbcon.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/video/console/fbcon.c b/drivers/video/console/fbcon.c
index 041d069..dcc8bcb 100644
--- a/drivers/video/console/fbcon.c
+++ b/drivers/video/console/fbcon.c
@@ -1142,6 +1142,7 @@ static void fbcon_init(struct vc_data *v
 		set_blitting_type(vc, info);
 	}
 
+	ops->p = &fb_display[fg_console];
 }
 
 static void fbcon_deinit(struct vc_data *vc)




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
