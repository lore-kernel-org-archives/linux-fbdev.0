From: Andrew Walrond <andrew@walrond.org>
Subject: Re: Rivafb won't work with DVI connector
Date: Mon, 22 Nov 2004 09:23:05 +0000
Message-ID: <200411220923.05415.andrew@walrond.org>
References: <200411191137.14649.andrew@walrond.org> <200411201552.53919.andrew@walrond.org> <200411220807.23572.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CWAQI-0001n4-0f
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 22 Nov 2004 01:23:50 -0800
Received: from [62.24.231.113] (helo=cenedra.walrond.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1CWAPr-00030x-Qy
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 22 Nov 2004 01:23:49 -0800
In-Reply-To: <200411220807.23572.adaplas@hotpop.com>
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
To: adaplas@pol.net
Cc: linux-fbdev-devel@lists.sourceforge.net

On Monday 22 Nov 2004 00:11, Antonino A. Daplas wrote:
> On Saturday 20 November 2004 23:52, Andrew Walrond wrote:
> > On Friday 19 Nov 2004 22:08, Antonino A. Daplas wrote:
> > > On Friday 19 November 2004 19:37, Andrew Walrond wrote:
> > > > I have a TFT LCD screen (1600x1200) with both D-Sub and DVI inputs,
> > > > and a NV25 [GeForce4 Ti 4600] with same outputs.
>
> Can you try this driver rewrite for nVidia chipsets? I'm planning to add
> this driver because it's getting harder and harder to support newer
> chipsets with the old code.
>
> - based on the most recent Xorg nv driver
> - supports console acceleration via DMA instead of PIO
> - should support all chipsets supported by rivafb except for
>   Riva128 (NV_ARCH_03) and in theory should also support
>   NV_ARCH_30 and NV_ARCH_40 chipsets. I've already added
>   a few pci_ids for these newer chipsets.
>
> The reference file that I based the driver on seems to have better DVI
> support, so hopefully this works.
>
> You have to disable rivafb in your kernel config.  The module name is
> nvidiafb and boot options are very similar to rivafb:
>
> video=nvidiafb:<your options>
>
> This is a preliminary patch, but it should be almost as functional as
> rivafb.
>

Hi Tony,

Some results. I both cases I booted with
 video=nvidia:1600x1200-16@60
on an Iiuama AU4831D 1600x1200 TFT LCD with both dsub and dvi connectors.

Using the dsub connector, everything works fine. From dmesg:

 nvidiafb: nVidia device/chipset 10DE0250
 nvidiafb: nVidia Corporation NV25 [GeForce4 Ti 4600]
   ...can't find one
   ...found one
 nvidiafb: CRTC 0appears to have a CRT attached
 nvidiafb: Using CRT on CRTC 0
 nvidiafb: MTRR set to ON
 Console: switching to colour frame buffer device 200x75
 nvidiafb: PCI nVidia NV25 framebuffer (128MB @ 0xE0000000)

Using the dvi connector, I get lovely shade of green filling the whole screen. 
Dmesg is interesting:

 nvidiafb: nVidia device/chipset 10DE0250
 nvidiafb: nVidia Corporation NV25 [GeForce4 Ti 4600]
   ...can't find one
   ...can't find one
 nvidiafb: CRTC 1 is currently programmed for DFP
 nvidiafb: Using DFP on CRTC 1
 Panel size is 1024 x 768
 nvidiafb: MTRR set to ON
 warning: many lost ticks.
 Your time source seems to be instable or some driver is hogging interupts
 rip default_idle+0x20/0x30
 Console: switching to colour frame buffer device 200x75
 nvidiafb: PCI nVidia NV25 framebuffer (128MB @ 0xE0000000)

Notice in particular
 - "some driver hogging interrupts"
 - "Panel size is 1024x768" (should be 1600x1200)

I'll try to boot on dvi without and module parameters and report back shortly.

Anything else I can do to help, let me know.

Andrew


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
