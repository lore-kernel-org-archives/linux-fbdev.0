From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: [PATCH] GeForce 5200 on rivafb
Date: Sun, 12 Dec 2004 05:11:30 +0800
Message-ID: <200412120511.31725.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CdEWn-0004nW-0o
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 11 Dec 2004 13:11:45 -0800
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CdEWm-000223-2J
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 11 Dec 2004 13:11:44 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id BC26DAF3A44
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 11 Dec 2004 21:11:31 +0000 (UTC)
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
To: Junio C Hamano <junkio@cox.net>
Cc: linux-fbdev-devel@lists.sourceforge.net


--- Junio C Hamano <junkio@cox.net> wrote:

> Thanks for a quick response.
> 
> >>>>> "AAD" == Antonino A Daplas
> <adaplas@hotpop.com> writes:
> 
> AAD> Dec 10 19:04:40 siamese kernel:       Display
> is GTF capable
> AAD> Dec 10 19:04:40 siamese kernel: nvidiafb:
> Unable to detect which 
> AAD> CRTCNumber...
> AAD> Dec 10 19:04:40 siamese kernel: ...Defaulting
> to CRTCNumber 1
> AAD> Dec 10 19:04:40 siamese kernel: nvidiafb: Using
> DFP on CRTC 1
> AAD> Dec 10 19:04:40 siamese kernel: Panel size is 1
> x 1
> 
> AAD> Panel size of 1x1 is a bad sign.  (Panel size
> is set by video BIOS).
> 
> What should it say normally?  The monitor is a CRT

It should tell you the pre-configured resolution of the display, if the
display is indeed a flatpanel...
> (ViewSonic
> PF775a) connected via a DSub connector.  I have

...which apparently isn't.

> rebuilt the
> kernel without I2C support and the boot log says
> "Defaulting to
> CRTCNumber 0".  With this, I get a working
> framebuffer console
> and fbdev X works on it.

Ah, ok.  The main problem is that the EDID block of your monitor is saying
that it is a flatpanel, not a CRT.

> 
> Dec 10 23:10:22 siamese kernel: nvidiafb: nVidia
> device/chipset 10DE0110
> Dec 10 23:10:22 siamese kernel: nvidiafb: nVidia
> Corporation NV11 [GeForce2 MX/MX 400]
> Dec 10 23:10:22 siamese kernel: nvidiafb: Unable to
> detect display type...
> Dec 10 23:10:22 siamese kernel: ...Using default of
> CRT
> Dec 10 23:10:22 siamese kernel: nvidiafb: Unable to
> detect which CRTCNumber...
> Dec 10 23:10:22 siamese kernel: ...Defaulting to
> CRTCNumber 0
> Dec 10 23:10:22 siamese kernel: nvidiafb: Using CRT
> on CRTC 0
> Dec 10 23:10:22 siamese kernel: nvidiafb: MTRR set
> to ON
> Dec 10 23:10:22 siamese kernel: Console: switching
> to colour frame buffer device 200x75
> Dec 10 23:10:22 siamese kernel: nvidiafb: PCI nVidia
> NV11 framebuffer (64MB @ 0xD8000000)
> 
> AAD> Can you try the following:
> AAD> 1. Change this line in drivers/video/fbmon.c
> 
> AAD> #undef DEBUG
> AAD> to 
> AAD> #define DEBUG
> 
> Will do, but I have one question.  The last time I
> tried
> turning debugging on on rivafb-i2c it was very
> unpleasant;

No :-), this is not for nvidiafb but for the EDID parser, and it will give
you a very descriptive parsing of the EDID block.

> eventually the driver ended up reporting scrolling
> events on the
> console which caused further scrolling which is
> reported on the
> console which caused further scrolling ... ;-).  I
> could not get
> the control back even with SysRQ.  Is there a trick
> to avoid
> this kind of trouble and still have debugging
> enabled?
> 
> AAD> 2. Experiment with the following boot options:
> 
> AAD> So you can try this, for a start:
> AAD> video=nvidiafb:forceCRTC:1
> 
> I presume I should use forceCRTC:0 to match the
> working "sans
> i2c" case.

Forget this part.

> 
> Is it possible that EDID is not being read correctly
> in my
> configuration?  Could it be a hardware problem
> (either the card,
> the monitor, or the connecting cable)?  If so, how

This is a problem in the EDID block.  Displays that support both digital and
analog (dsub) inputs should also have 2 EDID blocks, depending on the
connector attached.  In your case, if it has a dsub connector, then the
monitor should give out an EDID block that says it's analog, not digital.
 
So, with a broken EDID block, I guess your best workaround is to disable
i2c in your kernel config.

BTW:  Why can't you use the 'nv' driver with X? And does rivafb work with
your card?

Tony




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
