From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: Rivafb won't work with DVI connector
Date: Tue, 23 Nov 2004 09:50:20 +0800
Message-ID: <200411230950.24311.adaplas@hotpop.com>
References: <200411191137.14649.andrew@walrond.org> <200411230613.02227.adaplas@hotpop.com> <200411222347.17562.andrew@walrond.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_gdpoBopo4C+7lVA"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CWPpd-0002IJ-HF
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 22 Nov 2004 17:51:01 -0800
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CWPpO-0005FP-0m
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 22 Nov 2004 17:51:01 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 7584EA20E11
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 23 Nov 2004 01:50:37 +0000 (UTC)
In-Reply-To: <200411222347.17562.andrew@walrond.org>
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
To: linux-fbdev-devel@lists.sourceforge.net, Andrew Walrond <andrew@walrond.org>


--Boundary-00=_gdpoBopo4C+7lVA
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tuesday 23 November 2004 07:47, Andrew Walrond wrote:
> On Monday 22 Nov 2004 22:13, Antonino A. Daplas wrote:
> > Try this patch (reverse the previous one first)
> >
> > - update code against the latest CVS version of Xorg
> > - added VESA blanking support
> > - added backlight support for powermacs
> > - added hardware cursor support using option 'hwcur'.
> > - clean-up of i2c code
> >
> > Let me know, again, of the results.  Thanks.
>
> Ok; getting closer. In all cases booting with DVI connection:
>
> Booting with no module params gives an almost working 80x30 console, but
> shifted/wrapped half a screen to the right as with the previous version.
>
>  nvidiafb: nVidia device/chipset 10DE0250
>  nvidiafb: nVidia Corporation NV25 [GeForce4 Ti 4600]
>  nvidiafb: CRTC0 not found
>  nvidiafb: CRTC1 not found
>  nvidiafb: CRTC 1 is currently programmed for DFP
>  nvidiafb: Using DFP on CRTC 1
>  Panel size is 1024 x 768
>  nvidiafb: MTRR set to ON
>  Console: switching to colour frame buffer device 80x30
>  nvidiafb: PCI nVidia NV25 framebuffer (128MB @ 0xE0000000)
>
> Note the erroneous panel detection; this is a 1600x1200 tft lcd. The panel
> is detected as 1024x768 in every following case.

The panel size is programmed by the BIOS, not sure what what we can do
about that.  So even if your display supports 1600x1200, you're still limited
to 1024x768.  

Perhaps, if we can combine the vesafb code so the BIOS forces it to 
1600x1200, then have nvidiafb detect and use the vesa mode, we can
get a resolution higher than 1024x768.  I'll play around with this, and I'll
give you a test patch later.
 
>
> Now, with params. If I omit the @60 refresh rate, all I get is a screen of
> dots; I can make out that there is are a couple of penguin smeared across
> the top, but thats about all. So all the following have @60 which produces
> a better display.
>
> video=nvidia:1024x768-16@60

It seems that EDID block is not detected whether digital or analog. I think
I missed a Kconfig changeset. Should be fixed with the included patch.
 
Select y to FB_NVIDIA_I2C.
 
>  - Panel is misdetected as 1024x768. Refresh rates are also likely
> misdetected since I only get gibberish unless I add @60 (although monitor
> doesn't report "out of range")
>
>  - Displays <= 1024x768 have this shifted/wrapped to the right problem.

Most probably the 1024x768@60 entry in the mode database is wreaking
havoc to the timings.  Let's use the VESA standard 1024x768-60 timing.

Try the attached patch.  It's an incremental patch so apply it on top of
nvidiafb2.diff

Tony

--Boundary-00=_gdpoBopo4C+7lVA
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="nvidiafb2-inc.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="nvidiafb2-inc.diff"

diff -Nru a/drivers/video/Kconfig b/drivers/video/Kconfig
--- a/drivers/video/Kconfig	2004-11-21 11:48:41 +08:00
+++ b/drivers/video/Kconfig	2004-11-23 08:17:32 +08:00
@@ -444,11 +444,32 @@
 	  <http://www.erd.epson.com/vdc/html/products.htm>.
 
 config FB_NVIDIA
-       tristate "nVidia Support"
-       depends on FB && PCI
-       select FB_MODE_HELPERS
+	tristate "nVidia Framebuffer Support"
+	depends on FB && PCI
+	select I2C_ALGOBIT if FB_NVIDIA_I2C
+	select I2C if FB_NVIDIA_I2C
+	select FB_MODE_HELPERS
+	help
+	  This driver supports graphics boards with the nVidia chips, TNT
+	  and newer. For very old chipsets, such as the RIVA128, then use
+	  the the rivafb.
+	  Say Y if you have such a graphics board.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called nvidiafb.
+          none yet
+
+config FB_NVIDIA_I2C
+       bool "Enable DDC Support"
+       depends on FB_NVIDIA
        help
-         none yet
+	  This enables I2C support for nVidia Chipsets.  This is used
+	  only for getting EDID information from the attached display
+	  allowing for robust video mode handling and switching.
+
+	  Because fbdev-2.6 requires that drivers must be able to
+	  independently validate video mode parameters, you should say Y
+	  here.
 
 config FB_RIVA
 	tristate "nVidia Riva support"
diff -Nru a/drivers/video/modedb.c b/drivers/video/modedb.c
--- a/drivers/video/modedb.c	2004-11-17 18:15:20 +08:00
+++ b/drivers/video/modedb.c	2004-11-23 09:42:18 +08:00
@@ -86,8 +86,8 @@
 	FB_SYNC_HOR_HIGH_ACT|FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED
     }, {
 	/* 1024x768 @ 60 Hz, 48.4 kHz hsync */
-	NULL, 60, 1024, 768, 15384, 168, 8, 29, 3, 144, 6,
-	0, FB_VMODE_NONINTERLACED
+	NULL, 60, 1024, 768, 15384, 160, 24, 29, 3, 136, 6,
+	0, FB_VMODE_NONINTERLACED, FB_MODE_IS_VESA
     }, {
 	/* 640x480 @ 100 Hz, 53.01 kHz hsync */
 	NULL, 100, 640, 480, 21834, 96, 32, 36, 8, 96, 6,

--Boundary-00=_gdpoBopo4C+7lVA--




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
