From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH] nvidiafb: Fix reversed DDC port
Date: Sun, 01 Apr 2007 17:35:48 +0800
Message-ID: <460F7CF4.60006@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HXwUL-0003BG-S2 for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 01 Apr 2007 02:36:42 -0700
Received: from nz-out-0506.google.com ([64.233.162.231])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HXwUK-0000qr-Ee
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 01 Apr 2007 02:36:41 -0700
Received: by nz-out-0506.google.com with SMTP id i11so1525056nzi
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 01 Apr 2007 02:36:40 -0700 (PDT)
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
Cc: Petr Vandrovec <vandrove@vc.cvut.cz>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

From: Petr Vandrovec <vandrove@vc.cvut.cz>

After I added some debugging printks I've found that code became a bit
confused because it believed that primary monitor is 1920x540, but later
it found in CRTC0's registers that panel size is 1920x1200 (Windows also
agree that 1920x1200 is primary monitor, and 1920x1080i secondary one).

When I applied attached patch then my monitor became as happy as it was
before I connected HDMI cable to secondary output.

Signed-off-by: Petr Vandrovec <vandrove@vc.cvut.cz>
Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/nvidia/nv_i2c.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/nvidia/nv_i2c.c b/drivers/video/nvidia/nv_i2c.c
index b91d404..bcde013 100644
--- a/drivers/video/nvidia/nv_i2c.c
+++ b/drivers/video/nvidia/nv_i2c.c
@@ -131,10 +131,10 @@ void nvidia_create_i2c_busses(struct nvi
 	par->chan[1].par = par;
 	par->chan[2].par = par;
 
-	par->chan[0].ddc_base = 0x3e;
+	par->chan[0].ddc_base = 0x36;
 	nvidia_setup_i2c_bus(&par->chan[0], "nvidia #0");
 
-	par->chan[1].ddc_base = 0x36;
+	par->chan[1].ddc_base = 0x3e;
 	nvidia_setup_i2c_bus(&par->chan[1], "nvidia #1");
 
 	par->chan[2].ddc_base = 0x50;


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
