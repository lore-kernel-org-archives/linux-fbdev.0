From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: [Fwd: AtyFB in 2.6.10, still not perfect]
Date: Tue, 15 Mar 2005 18:26:46 +0800
Message-ID: <200503151826.46073.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DB9GO-0004aC-FT
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 15 Mar 2005 02:27:00 -0800
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DB9GM-0007IH-PH
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 15 Mar 2005 02:27:00 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 4C602FB23A2
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 15 Mar 2005 10:26:44 +0000 (UTC)
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
To: Luigi Gangitano <luigi@debian.org>, adaplas@hotpop.com
Cc: Alexander Kern <alex.kern@gmx.de>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


--- Luigi Gangitano <luigi@debian.org> wrote:
> Hi,
> David S. Miller told me to forward this information
> to you. I'm using

I don't have any hardware for this driver, and never really contributed
anything to its development, except for a few patches that are quite
obvious.

I'll CC the linux-fbdev list as well as Alex Kern.

In the meantime, can you try the ff:

1. enable/disable CONFIG_FB_ATY_XL_INIT in your kernel
config and see if that makes a difference.

2. Try using fbset to adjust the display settings, or pick a new
mode.  Remember to set csync to high.

3.  Does xfree86 manifest the same problem if atyfb is off?

4.  Can you post the dmesg, config and fbset -i of both the
working and non-working kernel?

Tony
> Debian/sparc on a SunBlade 100. AtyFB worked fine
> with 2.6.8 and broke
> (as known) with 2.6.10. Latest 2.6.10 source in
> debian adds the fix that
> was integrated in 2.6.11, from
> 
>  
> http://lists.debian.org/debian-sparc/2005/02/msg00063.html
> 
> atyfb works now with 2.6.10 but the output is
> garbled.
> 
> Please let me know if I can help with more
> informations.
> 
> Regards,
> 
> L
> 
> 
> ------- Messaggio inoltrato -------
> > Da: Luigi Gangitano <luigi@debian.org>
> > A: debian-sparc@lists.debian.org
> > Oggetto: AtyFB in 2.6.10, still not perfect
> > Data: Mon, 14 Mar 2005 23:50:02 +0100
> > Hi all,
> > I've just upgraded to the latest
> kernel-source-2.6.10 and recompiled it.
> > AtyFB on my SB100 works now (sort of), but the
> console misses the first
> > column on the left and some random pixels are
> corrupted. Under XFree86
> > I've got the same corruption of randome areas of
> the screen (I'll try to
> > get some screenshot if this is of help).
> > 
> > This is the relevant output of kernel (really I
> still don't know how to
> > interpret it... :-)):
> > 
> > atyfb: 3D RAGE XL (Mach64 GR, PCI-33MHz) [0x4752
> rev 0x27]
> > atyfb: 8M SDRAM (1:1), 29.498928 MHz XTAL, 230 MHz
> PLL, 83 Mhz MCLK, 63
> > MHz XCLK
> > atyfb: setting up CRTC
> > atyfb: set primary CRT to 1152x900 NN composite P
> > atyfb: CRTC_H_TOTAL_DISP: 8f00be
> > atyfb: CRTC_H_SYNC_STRT_WID: 300296
> > atyfb: CRTC_V_TOTAL_DISP: 38303a8
> > atyfb: CRTC_V_SYNC_STRT_WID: 240385
> > atyfb: CRTC_OFF_PITCH: 24000000
> > atyfb: CRTC_VLINE_CRNT_VLINE: 0
> > atyfb: CRTC_GEN_CNTL: b000210
> > atyfb: atyfb_set_par
> > atyfb:  Set Visible Mode to 1152x900-8
> > atyfb:  Virtual resolution 1152x7246,
> pixclock_in_ps 10644 (calculated
> > 10644)
> > atyfb:  Dot clock:           93 MHz
> > atyfb:  Horizontal sync:     61 kHz
> > atyfb:  Vertical refresh:    65 Hz
> > atyfb:  x  style: 93.10108 1152 1210 1338 1528  
> 900 902 906 937
> > atyfb:  fb style: 10644  190 1152 58 128 31 900 2
> 4
> > debug atyfb: Mach64 non-shadow register values:
> > debug atyfb: 0x2000:  008F00BE 00300296 038303A8
> 00240385
> > debug atyfb: 0x2010:  03880000 24000000 08000001
> 0B002210
> > debug atyfb: 0x2020:  003A0556 01200522 00000000
> 00000000
> > debug atyfb: 0x2030:  00000000 00110202 00000000
> 0000C001
> > debug atyfb: 0x2040:  00000000 00000000 00000000
> 00000000
> > debug atyfb: 0x2050:  00000000 00000000 00000000
> 00000000
> > debug atyfb: 0x2060:  36BB3121 24FBA121 00000000
> 00000000
> > debug atyfb: 0x2070:  00000000 00000000 01003300
> 00050000
> > debug atyfb: 0x2080:  00000000 00000000 00000000
> 00000000
> > debug atyfb: 0x2090:  00803000 00000000 00000100
> 00000000
> > debug atyfb: 0x20A0:  7B23A040 00000101 007F8091
> E5000C81
> > debug atyfb: 0x20B0:  10151A3B 00010000 00010000
> 00000000
> > debug atyfb: 0x20C0:  00FF0000 86010182 00000000
> 00000000
> > debug atyfb: 0x20D0:  00000100 00000008 00000000
> 000000C2
> > debug atyfb: 0x20E0:  27004752 00400014 00000000
> 00000000
> > debug atyfb: 0x20F0:  00000000 0000B14D 037FFCF8
> 00000000
> > 
> > debug atyfb: Mach64 PLL register values:
> > debug atyfb: 0x00:  ADD541E4 8A0301CF 8E9E6501
> 801B0000
> > debug atyfb: 0x10:  06CF4000 10B6AC10 408024FD
> 00000002
> > debug atyfb: 0x20:  06AC06AC 1424FD00 00255500
> 00000000
> > debug atyfb: 0x30:  00000000 00000000 00000000
> 00000000
> > 
> > Console: switching to colour frame buffer device
> 144x56
> > atyfb: fb0: ATY Mach64 frame buffer device on PCI
> > 
> > Regards,
> > 
> -- 
>  Luigi Gangitano -- <luigi@debian.org> --
> <gangitano@lugroma3.org>
>  GPG: 1024D/924C0C26: 12F8 9C03 89D3 DB4A 9972  C24A
> F19B A618 924C 0C26
> 




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
