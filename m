From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] GeForce 5200 on rivafb
Date: Sat, 11 Dec 2004 10:21:52 -0800
Message-ID: <7voeh0n1a7.fsf@assigned-by-dhcp.cox.net>
References: <200412112322.05601.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Cdgr4-0002h7-AW
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 12 Dec 2004 19:26:34 -0800
Received: from fed1rmmtai01.cox.net ([68.230.241.58])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1Cdgr3-0003Xm-F8
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 12 Dec 2004 19:26:34 -0800
In-Reply-To: <200412112322.05601.adaplas@hotpop.com> (Antonino A. Daplas's
 message of "Sat, 11 Dec 2004 23:22:04 +0800")
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
Content-Transfer-Encoding: 7bit
To: "Antonino A. Daplas" <adaplas@hotpop.com>
Cc: linux-fbdev-devel@lists.sourceforge.net

Thanks for a quick response.

>>>>> "AAD" == Antonino A Daplas <adaplas@hotpop.com> writes:

AAD> Dec 10 19:04:40 siamese kernel:       Display is GTF capable
AAD> Dec 10 19:04:40 siamese kernel: nvidiafb: Unable to detect which 
AAD> CRTCNumber...
AAD> Dec 10 19:04:40 siamese kernel: ...Defaulting to CRTCNumber 1
AAD> Dec 10 19:04:40 siamese kernel: nvidiafb: Using DFP on CRTC 1
AAD> Dec 10 19:04:40 siamese kernel: Panel size is 1 x 1

AAD> Panel size of 1x1 is a bad sign.  (Panel size is set by video BIOS).

What should it say normally?  The monitor is a CRT (ViewSonic
PF775a) connected via a DSub connector.  I have rebuilt the
kernel without I2C support and the boot log says "Defaulting to
CRTCNumber 0".  With this, I get a working framebuffer console
and fbdev X works on it.

Dec 10 23:10:22 siamese kernel: nvidiafb: nVidia device/chipset 10DE0110
Dec 10 23:10:22 siamese kernel: nvidiafb: nVidia Corporation NV11 [GeForce2 MX/MX 400]
Dec 10 23:10:22 siamese kernel: nvidiafb: Unable to detect display type...
Dec 10 23:10:22 siamese kernel: ...Using default of CRT
Dec 10 23:10:22 siamese kernel: nvidiafb: Unable to detect which CRTCNumber...
Dec 10 23:10:22 siamese kernel: ...Defaulting to CRTCNumber 0
Dec 10 23:10:22 siamese kernel: nvidiafb: Using CRT on CRTC 0
Dec 10 23:10:22 siamese kernel: nvidiafb: MTRR set to ON
Dec 10 23:10:22 siamese kernel: Console: switching to colour frame buffer device 200x75
Dec 10 23:10:22 siamese kernel: nvidiafb: PCI nVidia NV11 framebuffer (64MB @ 0xD8000000)

AAD> Can you try the following:
AAD> 1. Change this line in drivers/video/fbmon.c

AAD> #undef DEBUG
AAD> to 
AAD> #define DEBUG

Will do, but I have one question.  The last time I tried
turning debugging on on rivafb-i2c it was very unpleasant;
eventually the driver ended up reporting scrolling events on the
console which caused further scrolling which is reported on the
console which caused further scrolling ... ;-).  I could not get
the control back even with SysRQ.  Is there a trick to avoid
this kind of trouble and still have debugging enabled?

AAD> 2. Experiment with the following boot options:

AAD> So you can try this, for a start:
AAD> video=nvidiafb:forceCRTC:1

I presume I should use forceCRTC:0 to match the working "sans
i2c" case.

Is it possible that EDID is not being read correctly in my
configuration?  Could it be a hardware problem (either the card,
the monitor, or the connecting cable)?  If so, how would I
determine if it indeed is a hardware problem?

Thanks.



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
