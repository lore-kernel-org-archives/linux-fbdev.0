From: Francois Romieu <francois@fr.zoreil.com>
Subject: Re: [patch] Re: GeForce 4 MX have no working frame buffer at all..
Date: Sat, 21 Aug 2004 22:00:07 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040821200007.GA10966@electric-eye.fr.zoreil.com>
References: <412729BC.5000102@mitose.net> <20040821111414.GA6818@electric-eye.fr.zoreil.com> <200408212009.30477.adaplas@hotpop.com> <41278A27.2070608@mitose.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Byc3j-0005hC-3n
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 21 Aug 2004 13:01:51 -0700
Received: from electric-eye.fr.zoreil.com ([213.41.134.224] helo=fr.zoreil.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.34)
	id 1Byc3h-0007Fo-7g
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 21 Aug 2004 13:01:51 -0700
Content-Disposition: inline
In-Reply-To: <41278A27.2070608@mitose.net>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="iso-8859-1"
To: Ploum Ploum <ploum@mitose.net>
Cc: adaplas@pol.net, linux-fbdev-devel@lists.sourceforge.net

Ploum Ploum <ploum@mitose.net> :
[...]
> I've applied the mm3 patch from kernel.org and the patch supplied by=20
> Fran=E7ois Romieu but there's no change at all.

Bug of mine: I did not notice the lower part of the mask.

> Note, I forget to say that I can enable the framebuffer but only at=20
> 800x600.  If I put vga=3Dash (video=3Dvesafb), it simply won't recognis=
e any=20
> number that correspond to a higher resolution. Also, using the=20
> framebuffer at 800x600 has a grave bug : once that X is started, I=20
> cannot anymore see a console, only a black screen. those console works=20
> perfectly (I can "blind" type on it) but I cannot see it.  Even if I=20
> kill X, only a black screen remains.

X messes with the hardware. You do not want to kill it.

> I've put video=3Drivafb also, but then it simply doesn't work and boot =
on=20
> a non-fb console.

Can you reproduce this test without nvidia proprietary module loaded at
startup ?

As a minimum there should be some messages prefixed by "rivafb: xxx".

--
Ueimor


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
