From: Andrew Walrond <andrew@walrond.org>
Subject: Re: Rivafb won't work with DVI connector
Date: Mon, 22 Nov 2004 23:47:17 +0000
Message-ID: <200411222347.17562.andrew@walrond.org>
References: <200411191137.14649.andrew@walrond.org> <200411220943.57077.andrew@walrond.org> <200411230613.02227.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CWNtz-0007gY-Oj
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 22 Nov 2004 15:47:23 -0800
Received: from [62.24.231.113] (helo=cenedra.walrond.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1CWNtw-00011D-Pq
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 22 Nov 2004 15:47:23 -0800
In-Reply-To: <200411230613.02227.adaplas@hotpop.com>
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

On Monday 22 Nov 2004 22:13, Antonino A. Daplas wrote:
>
> Try this patch (reverse the previous one first)
>
> - update code against the latest CVS version of Xorg
> - added VESA blanking support
> - added backlight support for powermacs
> - added hardware cursor support using option 'hwcur'.
> - clean-up of i2c code
>
> Let me know, again, of the results.  Thanks.
>

Ok; getting closer. In all cases booting with DVI connection: 

Booting with no module params gives an almost working 80x30 console, but 
shifted/wrapped half a screen to the right as with the previous version.

 nvidiafb: nVidia device/chipset 10DE0250
 nvidiafb: nVidia Corporation NV25 [GeForce4 Ti 4600]
 nvidiafb: CRTC0 not found
 nvidiafb: CRTC1 not found
 nvidiafb: CRTC 1 is currently programmed for DFP
 nvidiafb: Using DFP on CRTC 1
 Panel size is 1024 x 768
 nvidiafb: MTRR set to ON
 Console: switching to colour frame buffer device 80x30
 nvidiafb: PCI nVidia NV25 framebuffer (128MB @ 0xE0000000)

Note the erroneous panel detection; this is a 1600x1200 tft lcd. The panel is 
detected as 1024x768 in every following case.

Now, with params. If I omit the @60 refresh rate, all I get is a screen of 
dots; I can make out that there is are a couple of penguin smeared across the 
top, but thats about all. So all the following have @60 which produces a 
better display.

video=nvidia:1024x768-16@60

This produces a readable 128x48 display, but shifted about a quarter of a 
display to the right. The penguins are a bit disjointed aswell.

 nvidiafb: nVidia device/chipset 10DE0250
 nvidiafb: nVidia Corporation NV25 [GeForce4 Ti 4600]
 nvidiafb: CRTC0 not found
 nvidiafb: CRTC1 not found
 nvidiafb: CRTC 1 is currently programmed for DFP
 nvidiafb: Using DFP on CRTC 1
 Panel size is 1024 x 768
 nvidiafb: MTRR set to ON
 Console: switching to colour frame buffer device 128x48
 nvidiafb: PCI nVidia NV25 framebuffer (128MB @ 0xE0000000)

video=nvidia:1024x768-32@60

Same results as -16, but my test programme confirms display is 32bpp.
Dmesg is identical

Interestingly, on all the shifted/wrapped displays, If I hit ctrl-L to clear 
the screen, the prompt moves back to the correct position for just that one 
top line. The next and subsequent lines are shifted right again.

video=nvidia:1280x1024-16@60
video=nvidia:1280x1024-32@60
video=nvidia:1600x1200-16@60
video=nvidia:1600x1200-32@60

All modes above 1024x768 produce the same result; a FULLY WORKING console, but 
ONLY AT 80x25. No sign of the shifting/wrapping problem though.

 nvidiafb: nVidia device/chipset 10DE0250
 nvidiafb: nVidia Corporation NV25 [GeForce4 Ti 4600]
 nvidiafb: CRTC0 not found
 nvidiafb: CRTC1 not found
 nvidiafb: CRTC 1 is currently programmed for DFP
 nvidiafb: Using DFP on CRTC 1
 Panel size is 1024 x 768
 nvidiafb: MTRR set to ON
 Console: switching to colour frame buffer device 80x25
 nvidiafb: PCI nVidia NV25 framebuffer (128MB @ 0xE0000000)


So, the main problems as I see them are:

 - Panel is misdetected as 1024x768. Refresh rates are also likely misdetected 
since I only get gibberish unless I add @60 (although monitor doesn't report 
"out of range")

 - Displays <= 1024x768 have this shifted/wrapped to the right problem.

Getting closer though!

I'll try the dsub connection next.

Andrew


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
