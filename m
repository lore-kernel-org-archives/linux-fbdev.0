From: Admar Schoonen <admar@luon.net>
Subject: Re: sparc64, 2 x mach64 & 2.6.8-rc4: no working XFree86
Date: Wed, 18 Aug 2004 21:27:29 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040818192728.GP21828@azrael.luon.net>
References: <20040814135408.GM21828@azrael.luon.net> <200409150521.47587.adaplas@hotpop.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BxW3n-0005yD-HE
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 18 Aug 2004 12:25:23 -0700
Received: from rg06.tte.ele.tue.nl
	([131.155.194.16] helo=azrael.luon.net ident=postfix)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1BxW3m-00087U-2m
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 18 Aug 2004 12:25:23 -0700
Content-Disposition: inline
In-Reply-To: <200409150521.47587.adaplas@hotpop.com>
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
To: adaplas@pol.net, linux-fbdev-devel@lists.sourceforge.net

On Wed, Sep 15, 2004 at 05:21:45AM +0800, Antonino A. Daplas wrote:
> > With 2.6.X (X <= 7), only the primary (onboard) card worked ; secondary
> > was always black in console and in XFree86.
> 
> con2fb was broken before that version.
I doubt that the problem is con2fbmap. con2fbmap works fine with 2.4.x
and 2.6.8-rcX (I guess 2.6.8 will work fine too).

> > Starting with 2.6.8-rc1, the console works on both cards again, however,
> > XFree86 doesn't work anymore. It crashes with signal 11 even before it
> > can display it's famous black & white dot pattern.
> 
> I tried with 1 PCI and 1 AGP nVidia card, PCI is primary.  I use vesafb on the
> primary, and I have no problems launching X on the secondary.  If I initialize
> the secondary card's ROM-BIOS, I can also modprobe rivafb and launch X-fbdev on
> both the primary and secondary.
> 
> I cannot use rivafb for both because of conflicts.

I guess my problem is Ati (Mach64 only?) and/or sparc (sparc64 only?)
related. I haven't tested X-fbdev.

Admar


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
