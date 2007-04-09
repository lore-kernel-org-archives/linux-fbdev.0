From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 7/7] nvidiafb: Access CRT registers
	safely
Date: Mon, 09 Apr 2007 19:44:19 +0800
Message-ID: <461A2713.9060700@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HasLI-0001rC-M3 for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 09 Apr 2007 04:47:28 -0700
Received: from py-out-1112.google.com ([64.233.166.183])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HasLI-0006Kz-Cr
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 09 Apr 2007 04:47:28 -0700
Received: by py-out-1112.google.com with SMTP id a29so1005416pyi
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 09 Apr 2007 04:47:28 -0700 (PDT)
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

Use Read/WriteCrtc() to access CRTC registers in nv_i2c.c.
These are safer because it uses the correct CRTC base
(0x3bx or 0x3dx).

Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/nvidia/nv_i2c.c |   18 ++++++------------
 1 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/video/nvidia/nv_i2c.c b/drivers/video/nvidia/nv_i2c.c
index 93615d2..3961c4a 100644
--- a/drivers/video/nvidia/nv_i2c.c
+++ b/drivers/video/nvidia/nv_i2c.c
@@ -30,16 +30,14 @@ static void nvidia_gpio_setscl(void *dat
 	struct nvidia_par *par = chan->par;
 	u32 val;
 
-	VGA_WR08(par->PCIO, 0x3d4, chan->ddc_base + 1);
-	val = VGA_RD08(par->PCIO, 0x3d5) & 0xf0;
+	val = NVReadCrtc(par, chan->ddc_base + 1) & 0xf0;
 
 	if (state)
 		val |= 0x20;
 	else
 		val &= ~0x20;
 
-	VGA_WR08(par->PCIO, 0x3d4, chan->ddc_base + 1);
-	VGA_WR08(par->PCIO, 0x3d5, val | 0x1);
+	NVWriteCrtc(par, chan->ddc_base + 1, val | 0x01);
 }
 
 static void nvidia_gpio_setsda(void *data, int state)
@@ -48,16 +46,14 @@ static void nvidia_gpio_setsda(void *dat
 	struct nvidia_par *par = chan->par;
 	u32 val;
 
-	VGA_WR08(par->PCIO, 0x3d4, chan->ddc_base + 1);
-	val = VGA_RD08(par->PCIO, 0x3d5) & 0xf0;
+	val = NVReadCrtc(par, chan->ddc_base + 1) & 0xf0;
 
 	if (state)
 		val |= 0x10;
 	else
 		val &= ~0x10;
 
-	VGA_WR08(par->PCIO, 0x3d4, chan->ddc_base + 1);
-	VGA_WR08(par->PCIO, 0x3d5, val | 0x1);
+	NVWriteCrtc(par, chan->ddc_base + 1, val | 0x01);
 }
 
 static int nvidia_gpio_getscl(void *data)
@@ -66,8 +62,7 @@ static int nvidia_gpio_getscl(void *data
 	struct nvidia_par *par = chan->par;
 	u32 val = 0;
 
-	VGA_WR08(par->PCIO, 0x3d4, chan->ddc_base);
-	if (VGA_RD08(par->PCIO, 0x3d5) & 0x04)
+	if (NVReadCrtc(par, chan->ddc_base) & 0x04)
 		val = 1;
 
 	return val;
@@ -79,8 +74,7 @@ static int nvidia_gpio_getsda(void *data
 	struct nvidia_par *par = chan->par;
 	u32 val = 0;
 
-	VGA_WR08(par->PCIO, 0x3d4, chan->ddc_base);
-	if (VGA_RD08(par->PCIO, 0x3d5) & 0x08)
+	if (NVReadCrtc(par, chan->ddc_base) & 0x08)
 		val = 1;
 
 	return val;


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
