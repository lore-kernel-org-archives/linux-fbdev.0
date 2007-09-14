From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 02/12] nvidiafb: Add boot option to
	reverse i2c port assignment
Date: Sat, 15 Sep 2007 07:59:51 +0800
Message-ID: <46EB2077.2060004@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IWLER-0007gS-NV for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 14 Sep 2007 17:09:56 -0700
Received: from rv-out-0910.google.com ([209.85.198.189])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IWLER-0003jU-CG
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 14 Sep 2007 17:09:55 -0700
Received: by rv-out-0910.google.com with SMTP id g11so3286302rvb
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Fri, 14 Sep 2007 17:09:55 -0700 (PDT)
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
Cc: Petr Vandrovec <vandrove@vc.cvut.cz>, Alex Kanavin <ak@sensi.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

There are a few nvidia hardware where the i2c port assignments are
reversed, i.e., the 1st i2c port is assigned to the secondary display and
the 2nd i2c port to the primary display. In most cases, if only 1 display
is attached, or if only 1 flatpanel and 1 analog display is attached, the
port reversal is of no consequence.  However if 2 flatpanels are attached,
it can cause display problems.

There is no sane way of determining if the hardware reversed the i2c port
assignment, so the simplest fix is to add a boot/module option, 
"reverse_i2c to explicitly reverse the i2c port.

This also restores i2c ordering back to the pre-2.6.22 state.

Signed-off-by: Antonino Daplas <adaplas@gail.com>
---

 drivers/video/nvidia/nv_i2c.c  |    8 ++++----
 drivers/video/nvidia/nv_type.h |    1 +
 drivers/video/nvidia/nvidia.c  |    6 ++++++
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/video/nvidia/nv_i2c.c b/drivers/video/nvidia/nv_i2c.c
index afe4567..0cbcb3d 100644
--- a/drivers/video/nvidia/nv_i2c.c
+++ b/drivers/video/nvidia/nv_i2c.c
@@ -125,11 +125,11 @@ void nvidia_create_i2c_busses(struct nvi
 	par->chan[1].par = par;
 	par->chan[2].par = par;
 
-	par->chan[0].ddc_base = 0x36;
- 	nvidia_setup_i2c_bus(&par->chan[0], "nvidia #0", I2C_CLASS_HWMON);
+	par->chan[0].ddc_base = (par->reverse_i2c) ? 0x36 : 0x3e;
+ 	nvidia_setup_i2c_bus(&par->chan[0], "nvidia #0", 0);
 
-	par->chan[1].ddc_base = 0x3e;
- 	nvidia_setup_i2c_bus(&par->chan[1], "nvidia #1", 0);
+	par->chan[1].ddc_base = (par->reverse_i2c) ? 0x3e : 0x36;
+ 	nvidia_setup_i2c_bus(&par->chan[1], "nvidia #1", I2C_CLASS_HWMON);
 
 	par->chan[2].ddc_base = 0x50;
  	nvidia_setup_i2c_bus(&par->chan[2], "nvidia #2", 0);
diff --git a/drivers/video/nvidia/nv_type.h b/drivers/video/nvidia/nv_type.h
index 2fdf77e..f132aab 100644
--- a/drivers/video/nvidia/nv_type.h
+++ b/drivers/video/nvidia/nv_type.h
@@ -135,6 +135,7 @@ struct nvidia_par {
 	int paneltweak;
 	int LVDS;
 	int pm_state;
+	int reverse_i2c;
 	u32 crtcSync_read;
 	u32 fpSyncs;
 	u32 dmaPut;
diff --git a/drivers/video/nvidia/nvidia.c b/drivers/video/nvidia/nvidia.c
index a7fe214..30e14eb 100644
--- a/drivers/video/nvidia/nvidia.c
+++ b/drivers/video/nvidia/nvidia.c
@@ -79,6 +79,7 @@ static int noscale __devinitdata = 0;
 static int paneltweak __devinitdata = 0;
 static int vram __devinitdata = 0;
 static int bpp __devinitdata = 8;
+static int reverse_i2c __devinitdata;
 #ifdef CONFIG_MTRR
 static int nomtrr __devinitdata = 0;
 #endif
@@ -1305,6 +1306,7 @@ static int __devinit nvidiafb_probe(stru
 	par->CRTCnumber = forceCRTC;
 	par->FpScale = (!noscale);
 	par->paneltweak = paneltweak;
+	par->reverse_i2c = reverse_i2c;
 
 	/* enable IO and mem if not already done */
 	pci_read_config_word(pd, PCI_COMMAND, &cmd);
@@ -1486,6 +1488,8 @@ static int __devinit nvidiafb_setup(char
 			noaccel = 1;
 		} else if (!strncmp(this_opt, "noscale", 7)) {
 			noscale = 1;
+		} else if (!strncmp(this_opt, "reverse_i2c", 11)) {
+			reverse_i2c = 1;
 		} else if (!strncmp(this_opt, "paneltweak:", 11)) {
 			paneltweak = simple_strtoul(this_opt+11, NULL, 0);
 		} else if (!strncmp(this_opt, "vram:", 5)) {
@@ -1582,6 +1586,8 @@ MODULE_PARM_DESC(mode_option, "Specify i
 module_param(bpp, int, 0);
 MODULE_PARM_DESC(bpp, "pixel width in bits"
 		 "(default=8)");
+module_param(reverse_i2c, int, 0);
+MODULE_PARM_DESC(reverse_i2c, "reverse port assignment of the i2c bus");
 #ifdef CONFIG_MTRR
 module_param(nomtrr, bool, 0);
 MODULE_PARM_DESC(nomtrr, "Disables MTRR support (0 or 1=disabled) "


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
