From: Andrew Walrond <andrew@walrond.org>
Subject: Re: ATI Rage XL on x86_64
Date: Wed, 26 Jan 2005 12:09:46 +0000
Message-ID: <200501261209.46735.andrew@walrond.org>
References: <200501260910.14102.andrew@walrond.org> <200501260939.48156.andrew@walrond.org> <20050126105459.GA13231@sci.fi>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ctm00-0007Pc-Ua
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 26 Jan 2005 04:10:16 -0800
Received: from [62.24.231.113] (helo=cenedra.walrond.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1Ctlzx-0008Kk-HL
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 26 Jan 2005 04:10:16 -0800
Received: from [62.24.231.115] (helo=host62-24-231-115.dsl.vispa.com)
	by cenedra.walrond.org with esmtp (Exim 4.34)
	id 1CtlzZ-0007PO-7u
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 26 Jan 2005 12:09:54 +0000
In-Reply-To: <20050126105459.GA13231@sci.fi>
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

Hi Ville

On Wednesday 26 January 2005 10:54, Ville Syrj=E4l=E4 wrote:
> On Wed, Jan 26, 2005 at 09:39:48AM +0000, Andrew Walrond wrote:
> > On Wednesday 26 January 2005 09:10, Andrew Walrond wrote:
> >
> > Sorry the second parameter line should have been
> >  video=3Datyfb:mode:1024x768
>
> atyfb:1024x768 is the correct format.
>

I had tried that first, since it is the default. Googling and the framebuff=
er=20
howto suggested the other formats

When I try video=3Datyfb:1024x768-8@60, I get even less output:

 atyfb: using auxiliary register aperture
 atyfb: 3D RAGE XL (Mach64 GR, PCI-33MHz) [0x4752 rev 0x27]
 atyfb: 8M SDRAM (2:1) (32-bit) 29.498928 MHz XTAL, 230MHz PLL, 83 MHz MCLK=
 =20
63MHz XCLK
 atyfb: fb0: ATY Mach64 frame buffer device on PCI

In all cases, the screen blanks for a moment during boot, then reppears in=
=20
original 80x25 format.


These messages:

 atyfb: MACH64 chips are designed for max 1600x1200
 select anoter resolution
 atyfb: MACH64 chips are designed for max 1600x1200
 select anoter resolution
 atyfb: vclk out of range
 atyfb: vclk out of range

suggest to me that something is going quite wrong, probably 64bit related,=
=20
although that suprises me because I think the ppc folks use this driver qui=
te=20
a bit. But perhaps only ppc32.

I'll have a dig in the code and see whats going on.

>
> > A 1280x1024 TFT screen is attached BTW
>
> Digital or analog? The driver doesn't touch any of the TDMS registers so I
> don't know if digital flat panels will work.

Analog, so this shouldn't be an issue. I am running linux-2.6.10.

Andrew Walrond


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
