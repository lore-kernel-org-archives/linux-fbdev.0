From: Alexander Kern <alex.kern@gmx.de>
Subject: Re: Re: [Fwd: AtyFB in 2.6.10, still not perfect]
Date: Sat, 19 Mar 2005 16:15:31 +0100
Message-ID: <200503191615.32610.alex.kern@gmx.de>
References: <200503151826.46073.adaplas@hotpop.com> <1110928841.6491.0.camel@willis> <200503160749.19151.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DCgeY-0008L7-OA
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 19 Mar 2005 08:18:18 -0800
Received: from mail.gmx.net ([213.165.64.20])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1DCgeX-0007yc-2r
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 19 Mar 2005 08:18:18 -0800
In-Reply-To: <200503160749.19151.adaplas@hotpop.com>
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
Content-Type: text/plain; charset="iso-8859-1"
To: linux-fbdev-devel@lists.sourceforge.net
Cc: "Antonino A. Daplas" <adaplas@hotpop.com>, Luigi Gangitano <luigi@debian.org>

Am Mittwoch, 16. M=E4rz 2005 00:49 schrieb Antonino A. Daplas:
> On Wednesday 16 March 2005 07:20, Luigi Gangitano wrote:
> > Il giorno mer, 16-03-2005 alle 04:39 +0800, Antonino A. Daplas ha
> >
> > scritto:
> > > working:
> > > atyfb: 3D RAGE (XL) [0x4752 rev 0x27] 8M SDRAM, 29.498928 MHz XTAL, 2=
30
> > > MHz PLL, 100 Mhz MCLK
> > >
> > > not working:
> > > atyfb: 3D RAGE XL (Mach64 GR, PCI-33MHz) [0x4752 rev 0x27]
> > > atyfb: 8M SDRAM (1:1), 29.498928 MHz XTAL, 230 MHz PLL, 83 Mhz MCLK, =
63
> > > MHz XCLK
> > >
> > > The MCLK value is different.  Can you try booting with
> > >
> > > video=3Datyfb:mclk:100
> > >
> > > You can also experiment with xclk:
> > >
> > > video=3Datyfb:mclk:100,xclk:63
> >
> > No luck, with neither option.
>
> Hmmn, let's just wait for the other developers to respond.
>
> Tony

Copyed from oldest mail...=20

> (as known) with 2.6.10. Latest 2.6.10 source in
> debian adds the fix that
> was integrated in 2.6.11, from
>=20
> =A0
> http://lists.debian.org/debian-sparc/2005/02/msg00063.html

It's mean you run 2.6.10 + "always hsync on SPARC" patch ?
And if you try any fixes from Tony, you see mclk 100 xclk 100 in your dmesg=
,=20
bur screen is steel garbage?

Regards Alex


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
