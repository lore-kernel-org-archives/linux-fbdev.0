From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 3/7] rivafb: Handle I2C bus creation
	failure
Date: Mon, 09 Apr 2007 19:38:58 +0800
Message-ID: <461A25D2.3020404@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HasKB-0001kP-Ai for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 09 Apr 2007 04:46:19 -0700
Received: from nz-out-0506.google.com ([64.233.162.231])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HasKB-0002tn-2l
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 09 Apr 2007 04:46:19 -0700
Received: by nz-out-0506.google.com with SMTP id i11so2386484nzi
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 09 Apr 2007 04:46:18 -0700 (PDT)
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
Cc: Jean Delvare <khali@linux-fr.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

From: Jean Delvare <khali@linux-fr.org>

I2C bus creation may fail, let rivafb handle that case properly.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/riva/fbdev.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/video/riva/fbdev.c b/drivers/video/riva/fbdev.c
index a37189a..b8d50f1 100644
--- a/drivers/video/riva/fbdev.c
+++ b/drivers/video/riva/fbdev.c
@@ -1789,6 +1789,8 @@ static int __devinit riva_get_EDID_i2c(s
 	NVTRACE_ENTER();
 	riva_create_i2c_busses(par);
 	for (i = 0; i < par->bus; i++) {
+		if (!par->chan[i].par)
+			continue;
 		riva_probe_i2c_connector(par, i+1, &par->EDID);
 		if (par->EDID && !fb_parse_edid(par->EDID, &var)) {
 			printk(PFX "Found EDID Block from BUS %i\n", i);


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
