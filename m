From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 5/7][RESEND] rivafb: Fixed reversed DDC
	ports
Date: Tue, 10 Apr 2007 00:24:29 +0800
Message-ID: <461A68BD.8030205@gmail.com>
References: <461A267E.6030804@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Hawfg-0000XF-A3 for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 09 Apr 2007 09:24:48 -0700
Received: from wx-out-0506.google.com ([66.249.82.228])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Hawfg-0001gl-08
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 09 Apr 2007 09:24:48 -0700
Received: by wx-out-0506.google.com with SMTP id i30so2615898wxd
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 09 Apr 2007 09:24:47 -0700 (PDT)
In-Reply-To: <461A267E.6030804@gmail.com>
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
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, Jean Delvare <khali@linux-fr.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Fixed reversed DDC port so assignments are congruent with nvidiafb's and
X's nv driver.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

It must be my stupid typo day.  Thanks Jean.

Tony

 drivers/video/riva/rivafb-i2c.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/video/riva/rivafb-i2c.c b/drivers/video/riva/rivafb-i2c.c
index bcb2096..76e6ce3 100644
--- a/drivers/video/riva/rivafb-i2c.c
+++ b/drivers/video/riva/rivafb-i2c.c
@@ -133,11 +133,11 @@ void __devinit riva_create_i2c_busses(st
 	par->chan[1].par	= par;
 	par->chan[2].par        = par;
 
-	par->chan[0].ddc_base = 0x3e;
-	par->chan[1].ddc_base = 0x36;
+	par->chan[0].ddc_base = 0x36;
+	par->chan[1].ddc_base = 0x3e;
 	par->chan[2].ddc_base = 0x50;
-	riva_setup_i2c_bus(&par->chan[0], "BUS1", 0);
-	riva_setup_i2c_bus(&par->chan[1], "BUS2", I2C_CLASS_HWMON);
+	riva_setup_i2c_bus(&par->chan[0], "BUS1", I2C_CLASS_HWMON);
+	riva_setup_i2c_bus(&par->chan[1], "BUS2", 0);
 	riva_setup_i2c_bus(&par->chan[2], "BUS3", 0);
 }
 

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
