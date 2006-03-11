From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 9/18] savagefb: Fix kfree before use
Date: Sat, 11 Mar 2006 09:50:28 +0800
Message-ID: <44122CE4.4080607@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FHtNX-0002Wq-Lu
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 10 Mar 2006 17:58:47 -0800
Received: from pproxy.gmail.com ([64.233.166.180])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FHtNX-0003lQ-FI
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 10 Mar 2006 17:58:48 -0800
Received: by pproxy.gmail.com with SMTP id z59so419612pyg
        for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 10 Mar 2006 17:58:45 -0800 (PST)
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

par->edid is kfree'd before using in fb_edid_to_monspecs()

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/savage/savagefb_driver.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/savage/savagefb_driver.c b/drivers/video/savage/savagefb_driver.c
index ab727ea..10e6b3a 100644
--- a/drivers/video/savage/savagefb_driver.c
+++ b/drivers/video/savage/savagefb_driver.c
@@ -2021,8 +2021,8 @@ static int __devinit savagefb_probe (str
 #if defined(CONFIG_FB_SAVAGE_I2C)
 	savagefb_create_i2c_busses(info);
 	savagefb_probe_i2c_connector(info, &par->edid);
-	kfree(par->edid);
 	fb_edid_to_monspecs(par->edid, &info->monspecs);
+	kfree(par->edid);
 	fb_videomode_to_modelist(info->monspecs.modedb,
 				 info->monspecs.modedb_len,
 				 &info->modelist);




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
