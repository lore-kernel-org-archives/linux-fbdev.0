From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: sparc64, 2 x mach64 & 2.6.8-rc4: no working XFree86
Date: Sat, 14 Aug 2004 21:24:34 +0000 (UTC)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200409150521.47587.adaplas@hotpop.com>
References: <20040814135408.GM21828@azrael.luon.net>
Reply-To: adaplas@pol.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bw5z3-0000Vk-VV
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 14 Aug 2004 14:22:37 -0700
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1Bw5z3-0002Z2-5N
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 14 Aug 2004 14:22:37 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id D881B798835
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 14 Aug 2004 20:27:30 +0000 (UTC)
In-Reply-To: <20040814135408.GM21828@azrael.luon.net>
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
Date: Wed, 15 Sep 2004 05:21:45 +0800
Content-Type: text/plain; charset="us-ascii"
To: Admar Schoonen <admar@luon.net>, linux-fbdev-devel@lists.sourceforge.net

On Saturday 14 August 2004 21:54, Admar Schoonen wrote:
> Hi
>
> I have a sun blade 100 with 1 onboard PGX64 and 1 pci card PGX64 (both
> Ati mach64 cards).
>
> With linux 2.4 series, both framebuffers worked, and XFree86 worked on
> both cards.
>
> With 2.6.X (X <= 7), only the primary (onboard) card worked ; secondary
> was always black in console and in XFree86.

con2fb was broken before that version.

>
> Starting with 2.6.8-rc1, the console works on both cards again, however,
> XFree86 doesn't work anymore. It crashes with signal 11 even before it
> can display it's famous black & white dot pattern.

I tried with 1 PCI and 1 AGP nVidia card, PCI is primary.  I use vesafb on the
primary, and I have no problems launching X on the secondary.  If I initialize
the secondary card's ROM-BIOS, I can also modprobe rivafb and launch X-fbdev on
both the primary and secondary.

I cannot use rivafb for both because of conflicts.

Tony




-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
