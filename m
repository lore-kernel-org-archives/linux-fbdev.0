From: Andrew Walrond <andrew@walrond.org>
Subject: Re: Rivafb won't work with DVI connector
Date: Tue, 23 Nov 2004 16:08:19 +0000
Message-ID: <200411231608.19517.andrew@walrond.org>
References: <200411191137.14649.andrew@walrond.org> <200411231509.24489.andrew@walrond.org> <200411232318.00795.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CWdDZ-0004SF-Mu
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 23 Nov 2004 08:08:37 -0800
Received: from [62.24.231.113] (helo=cenedra.walrond.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1CWdDW-0002QF-M0
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 23 Nov 2004 08:08:37 -0800
In-Reply-To: <200411232318.00795.adaplas@hotpop.com>
Content-Disposition: inline
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: "Antonino A. Daplas" <adaplas@hotpop.com>

On Tuesday 23 Nov 2004 15:18, Antonino A. Daplas wrote:
> On Tuesday 23 November 2004 23:09, Andrew Walrond wrote:
> > On Tuesday 23 Nov 2004 14:28, Antonino A. Daplas wrote:
> > > Okay, try the attached patch.
> >
> > Ok, booting on dsub without params now results in a good 1024x768
> > (128x48) console and boots cleanly. (Note this was a 1600x1200
> > (200xwhatever) before the patch, which is the preferred, native
> > resolution of the screen.)
>

Actually, I think this is die to having both dsub and dvi attached during that 
test. Just dsub boots to 1600x1200 as before

> Can you enable debugging in drivers/video/fbmon.c?  Just change the "undef"
> to define in this line:
>
> #undef DEBUG  /* define this for verbose EDID parsing output */
>
> Send me the dmesg output for both dvi and dsub.
>

DSUB

nvidiafb: nVidia device/chipset 10DE0250
nvidiafb: nVidia Corporation NV25 [GeForce4 Ti 4600]
i2c_adapter i2c-0: registered as adapter #0
i2c_adapter i2c-1: registered as adapter #1
i2c_adapter i2c-2: registered as adapter #2
nvidiafb: CRTC0 not found
nvidiafb: CRTC1 found
i2c_adapter i2c-0: master_xfer: with 2 msgs.
i2c_adapter i2c-0: master_xfer: with 2 msgs.
i2c_adapter i2c-0: master_xfer: with 2 msgs.
i2c_adapter i2c-1: master_xfer: with 2 msgs.
nvidiafb: EDID found from BUS2
========================================
Display Information (EDID)
========================================
   EDID Version 1.3
   Manufacturer: IVM
   Model: 4800
   Serial#: 95
   Year: 2001 Week 44
   Monitor Name: iiyama
   Monitor Name: AU4831D
   Display Characteristics:
      Monitor Operating Limits: From EDID
           H: 24-80KHz V: 50-85Hz DCLK: 170MHz
      Analog Display Input: Input Voltage - 0.700V/0.000V
      Sync: Separate Composite
      Max H-size in cm: 39
      Max V-size in cm: 29
      Gamma: 2.20
      DPMS: Active yes, Suspend yes, Standby yes
      RGB Color Display
      Chroma
         RedX:     0.619 RedY:     0.340
         GreenX:   0.279 GreenY:   0.600
         BlueX:    0.140 BlueY:    0.090
         WhiteX:   0.289 WhiteY:   0.300
      First DETAILED Timing is preferred
   Supported VESA Modes
      720x400@70Hz
      640x480@60Hz
      640x480@67Hz
      640x480@72Hz
      640x480@75Hz
      800x600@56Hz
      800x600@60Hz
      800x600@72Hz
      800x600@75Hz
      832x624@75Hz
      1024x768@60Hz
      1024x768@70Hz
      1024x768@75Hz
      1280x1024@75Hz
      Manufacturer's mask: 0
   Standard Timings
      1600x1200@60Hz
      1280x1024@60Hz
      1280x1024@70Hz
      1152x864@75Hz
      1152x864@85Hz
      1024x768@66Hz
      1024x768@70Hz
      1024x768@85Hz
   Detailed Timings
      162 MHz 1600 1664 1856 2160 1200 1201 1204 1250 +HSync +VSync

========================================
nvidiafb: CRTC 0appears to have a CRT attached
nvidiafb: Using CRT on CRTC 0
nvidiafb: MTRR set to ON
Console: switching to colour frame buffer device 200x75
nvidiafb: PCI nVidia NV25 framebuffer (128MB @ 0xE0000000)



DVI

nvidiafb: nVidia device/chipset 10DE0250
nvidiafb: nVidia Corporation NV25 [GeForce4 Ti 4600]
i2c_adapter i2c-0: registered as adapter #0
i2c_adapter i2c-1: registered as adapter #1
i2c_adapter i2c-2: registered as adapter #2
nvidiafb: CRTC0 not found
nvidiafb: CRTC1 not found
i2c_adapter i2c-0: master_xfer: with 2 msgs.
nvidiafb: EDID found from BUS1
========================================
Display Information (EDID)
========================================
   EDID Version 1.3
   Manufacturer: IVM
   Model: 4800
   Serial#: 1001
   Year: 2002 Week 1
   Monitor Name: iiyama
   Display Characteristics:
      Monitor Operating Limits: From EDID
           H: 30-80KHz V: 56-85Hz DCLK: 170MHz
      Digital Display Input
      Sync: Serration on
      Max H-size in cm: 39
      Max V-size in cm: 29
      Gamma: 2.20
      DPMS: Active yes, Suspend yes, Standby yes
      RGB Color Display
      Chroma
         RedX:     0.619 RedY:     0.340
         GreenX:   0.279 GreenY:   0.600
         BlueX:    0.140 BlueY:    0.090
         WhiteX:   0.289 WhiteY:   0.300
      First DETAILED Timing is preferred
   Supported VESA Modes
      720x400@70Hz
      640x480@60Hz
      640x480@67Hz
      640x480@72Hz
      640x480@75Hz
      800x600@56Hz
      800x600@60Hz
      800x600@72Hz
      800x600@75Hz
      832x624@75Hz
      1024x768@60Hz
      1024x768@70Hz
      1024x768@75Hz
      1280x1024@75Hz
      1152x870@75Hz
      Manufacturer's mask: 0
   Standard Timings
      1280x1024@60Hz
      1024x819@85Hz
      800x640@85Hz
      640x512@85Hz
   Detailed Timings
      65 MHz 1024 1040 1104 1344 768 781 783 817 -HSync -VSync

      162 MHz 1600 1664 1856 2160 1200 1201 1204 1250 +HSync +VSync

========================================
i2c_adapter i2c-1: master_xfer: with 2 msgs.
i2c_adapter i2c-1: master_xfer: with 2 msgs.
i2c_adapter i2c-1: master_xfer: with 2 msgs.
nvidiafb: CRTC 1 is currently programmed for DFP
nvidiafb: Using DFP on CRTC 1
Panel size is 1024 x 768
nvidiafb: MTRR set to ON
Console: switching to colour frame buffer device 80x30
nvidiafb: PCI nVidia NV25 framebuffer (128MB @ 0xE0000000)


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
