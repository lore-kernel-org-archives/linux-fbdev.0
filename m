From: Andrew Walrond <andrew@walrond.org>
Subject: Re: Rivafb won't work with DVI connector
Date: Tue, 23 Nov 2004 15:09:24 +0000
Message-ID: <200411231509.24489.andrew@walrond.org>
References: <200411191137.14649.andrew@walrond.org> <200411231232.57420.andrew@walrond.org> <200411232229.00311.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CWcIW-0005hI-MI
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 23 Nov 2004 07:09:40 -0800
Received: from [62.24.231.113] (helo=cenedra.walrond.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1CWcIQ-0008Q8-Ub
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 23 Nov 2004 07:09:40 -0800
In-Reply-To: <200411232229.00311.adaplas@hotpop.com>
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

On Tuesday 23 Nov 2004 14:28, Antonino A. Daplas wrote:
>
> Okay, try the attached patch.
>

Ok, booting on dsub without params now results in a good 1024x768 (128x48) 
console and boots cleanly. (Note this was a 1600x1200 (200xwhatever) before 
the patch, which is the preferred, native resolution of the screen.)

 nvidiafb: nVidia device/chipset 10DE0250
 nvidiafb: nVidia Corporation NV25 [GeForce4 Ti 4600]
 i2c_adapter i2c-0: registered as adapter #0
 i2c_adapter i2c-1: registered as adapter #1
 i2c_adapter i2c-2: registered as adapter #2
 nvidiafb: CRTC0 not found
 nvidiafb: CRTC1 found
 i2c_adapter i2c-0: master_xfer: with 2 msgs.
 nvidiafb: EDID found from BUS1
 i2c_adapter i2c-1: master_xfer: with 2 msgs.
 nvidiafb: EDID found from BUS2
 nvidiafb: CRTC 0appears to have a CRT attached
 nvidiafb: Using CRT on CRTC 0
 nvidiafb: MTRR set to ON
 Console: switching to colour frame buffer device 128x48
 nvidiafb: PCI nVidia NV25 framebuffer (128MB @ 0xE0000000)

Booting on dvi with no kernel params results in a broken (right shifted) 80x30 
display as before.

 nvidiafb: nVidia device/chipset 10DE0250
 nvidiafb: nVidia Corporation NV25 [GeForce4 Ti 4600]
 i2c_adapter i2c-0: registered as adapter #0
 i2c_adapter i2c-1: registered as adapter #1
 i2c_adapter i2c-2: registered as adapter #2
 nvidiafb: CRTC0 not found
 nvidiafb: CRTC1 not found
 i2c_adapter i2c-0: master_xfer: with 2 msgs.
 nvidiafb: EDID found from BUS1
 i2c_adapter i2c-1: master_xfer: with 2 msgs.
 i2c_adapter i2c-1: master_xfer: with 2 msgs.
 i2c_adapter i2c-1: master_xfer: with 2 msgs.
 nvidiafb: CRTC 1 is currently programmed for DFP
 nvidiafb: Using DFP on CRTC 1
 Panel size is 1024 x 768
 nvidiafb: MTRR set to ON
 Console: switching to colour frame buffer device 80x30
 nvidiafb: PCI nVidia NV25 framebuffer (128MB @ 0xE0000000)

Booting on dvi with video=nvidiafb:1600x1200-32@60 results in a fully working 
console, but only at 80x25

 nvidiafb: nVidia device/chipset 10DE0250
 nvidiafb: nVidia Corporation NV25 [GeForce4 Ti 4600]
 i2c_adapter i2c-0: registered as adapter #0
 i2c_adapter i2c-1: registered as adapter #1
 i2c_adapter i2c-2: registered as adapter #2
 nvidiafb: CRTC0 not found
 nvidiafb: CRTC1 not found
 i2c_adapter i2c-0: master_xfer: with 2 msgs.
 nvidiafb: EDID found from BUS1
 i2c_adapter i2c-1: master_xfer: with 2 msgs.
 i2c_adapter i2c-1: master_xfer: with 2 msgs.
 i2c_adapter i2c-1: master_xfer: with 2 msgs.
 nvidiafb: CRTC 1 is currently programmed for DFP
 nvidiafb: Using DFP on CRTC 1
 Panel size is 1024 x 768
 nvidiafb: MTRR set to ON
 Console: switching to colour frame buffer device 80x25
 nvidiafb: PCI nVidia NV25 framebuffer (128MB @ 0xE0000000)

The Oops has gone though :)

Andrew


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
