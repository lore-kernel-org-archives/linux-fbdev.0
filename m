From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: tty open screws X color palette
Date: Sun, 15 Aug 2004 09:37:06 +0000 (UTC)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200409151734.08795.adaplas@hotpop.com>
References: <20040813114713.GA2168@suse.de> <200409150902.27378.adaplas@hotpop.com> <20040815063251.GA23843@suse.de>
Reply-To: adaplas@pol.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BwHPp-0001jg-55
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 15 Aug 2004 02:35:01 -0700
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1BwHPm-0000ew-HK
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 15 Aug 2004 02:34:58 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 6D7F2767082
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 15 Aug 2004 08:39:43 +0000 (UTC)
In-Reply-To: <20040815063251.GA23843@suse.de>
Content-Disposition: inline
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Date: Wed, 15 Sep 2004 17:34:07 +0800
Content-Type: text/plain; charset="us-ascii"
To: Olaf Hering <olh@suse.de>
Cc: linux-fbdev-devel@lists.sourceforge.net

On Sunday 15 August 2004 14:32, Olaf Hering wrote:
>  On Wed, Sep 15, Antonino A. Daplas wrote:
> > On Friday 13 August 2004 19:47, Olaf Hering wrote:
> > > An 'echo foo > /dev/tty42' while X runs will screw the color palette,
> > > if tty42 wasnt in use before. Tested on ibook G3 and G4.
> > > This will happen with rage128 and radeonfb in 2.6.5 and later,
> > > X version is 4.3.99.
> > >
> > > X runs usually with a different color depth than the kernel framebuffer
> > > console.
> > > How can this be fixed? tty open should not touch the hardware if the
> > > tty is not active.
> >
> > I tried the above and nothing happens to X.  My setup is X86 nVidia AGP
> > on rivafb linux-2.6.8-rc4-mm1.
>
> Do you have 'Option "usefbdev" "true"' in our XF86Config?

No.  I tried that option before but it produces a segfault.

Tony




-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
