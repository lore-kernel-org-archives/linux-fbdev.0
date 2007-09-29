From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 03/17] nvidiafb: Correctly assign the
 i2c class with the port reversal
Date: Sat, 29 Sep 2007 09:26:55 +0800
Message-ID: <46FDA9DF.9030407@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IbSN9-000811-Ab for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 28 Sep 2007 19:48:03 -0700
Received: from wr-out-0506.google.com ([64.233.184.225])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IbSN7-00039C-VE
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 28 Sep 2007 19:48:03 -0700
Received: by wr-out-0506.google.com with SMTP id 36so1486750wra
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Fri, 28 Sep 2007 19:48:01 -0700 (PDT)
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
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

If the i2c ports are to be reversed, I2C_CLASS_HWMON assignment must
also be reversed.

Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/nvidia/nv_i2c.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/video/nvidia/nv_i2c.c b/drivers/video/nvidia/nv_i2c.c
index 0cbcb3d..6fd7cb8 100644
--- a/drivers/video/nvidia/nv_i2c.c
+++ b/drivers/video/nvidia/nv_i2c.c
@@ -126,10 +126,12 @@ void nvidia_create_i2c_busses(struct nvi
 	par->chan[2].par = par;
 
 	par->chan[0].ddc_base = (par->reverse_i2c) ? 0x36 : 0x3e;
- 	nvidia_setup_i2c_bus(&par->chan[0], "nvidia #0", 0);
+ 	nvidia_setup_i2c_bus(&par->chan[0], "nvidia #0",
+			     (par->reverse_i2c) ? I2C_CLASS_HWMON : 0);
 
 	par->chan[1].ddc_base = (par->reverse_i2c) ? 0x3e : 0x36;
- 	nvidia_setup_i2c_bus(&par->chan[1], "nvidia #1", I2C_CLASS_HWMON);
+ 	nvidia_setup_i2c_bus(&par->chan[1], "nvidia #1",
+			     (par->reverse_i2c) ? 0 : I2C_CLASS_HWMON);
 
 	par->chan[2].ddc_base = 0x50;
  	nvidia_setup_i2c_bus(&par->chan[2], "nvidia #2", 0);


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
