From: James Simmons <jsimmons@infradead.org>
Subject: Re: console fb: init blackout. (CyberBlade/i1)
Date: Wed, 17 Mar 2004 22:14:36 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0403172208140.19415-100000@phoenix.infradead.org>
References: <20040315172529.GA1199@foko.komputilo.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B3jJC-0000ql-3m
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 17 Mar 2004 14:14:42 -0800
Received: from phoenix.infradead.org ([213.86.99.234])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1B3jJA-0006A0-VH
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 17 Mar 2004 14:14:41 -0800
In-Reply-To: <20040315172529.GA1199@foko.komputilo.org>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Joost Witteveen <joost@iliana.nl>
Cc: linux-fbdev-devel@lists.sourceforge.net, joostje@foko.komputilo.org


> When defining FRAMEBUFFER_CONSOLE on my system, kernels
> 2.6.3 and 2.6.4 will black out the screen while the kernel
> is booting (so fast I cannot see any line from the kernel
> messages). X comes up normally, and everything else seems
> to work fine too (only the VC's stay black when I try to
> visit them with control-alt-F1 etc).
> 
> 2.6.1 did not have this. (Don't know about 2.6.2).
> 
> If there is anything I can do to help you figure out what
> the problem is, please tell.
> 
> (Personally I don't use the console framebuffer, so I just 
> comment it out).
> 
> 
> Video: Trident Microsystems CyberBlade/i1 (rev 6a)
>        VGA-onboard on a MS 6368 motherboard

First of all in your lilo.conf what do you have vga= set to.
Plus are you using a fbdev X server?

> #
> # Graphics support
> #
> CONFIG_FB=y
> # CONFIG_FB_PM2 is not set
> CONFIG_FB_CYBER2000=y

Unset this option. You don't have this card.

> # CONFIG_FB_IMSTT is not set
> CONFIG_FB_VGA16=y

I recommend disabling this driver.

> CONFIG_FB_VESA=y
> # CONFIG_VIDEO_SELECT is not set
> # CONFIG_FB_HGA is not set
> # CONFIG_FB_RIVA is not set
> # CONFIG_FB_I810 is not set
> # CONFIG_FB_MATROX is not set
> # CONFIG_FB_RADEON_OLD is not set
> # CONFIG_FB_RADEON is not set
> # CONFIG_FB_ATY128 is not set
> # CONFIG_FB_ATY is not set
> # CONFIG_FB_SIS is not set
> # CONFIG_FB_NEOMAGIC is not set
> # CONFIG_FB_KYRO is not set
> # CONFIG_FB_3DFX is not set
> # CONFIG_FB_VOODOO1 is not set
> CONFIG_FB_TRIDENT=y
> # CONFIG_FB_VIRTUAL is not set
> 
> #
> # Console display driver support
> #
> CONFIG_VGA_CONSOLE=y
> # CONFIG_MDA_CONSOLE is not set
> CONFIG_DUMMY_CONSOLE=y
> 
> # (note: I just edit-ed this option in again, as I'm typing
> # this from a non-frame-buffer kernel)
> CONFIG_FRAMEBUFFER_CONSOLE=y

It shoudl work. I don't know if the Trident driver works since I liack 
that hardware.




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
