From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: Re: fbdev cursor part 1.
Date: Mon, 23 Feb 2004 15:21:51 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040223132151.GA7255@sci.fi>
References: <Pine.LNX.4.44.0402222234120.2390-100000@phoenix.infradead.org> <1077496550.5960.9.camel@gaston> <Pine.GSO.4.58.0402231156040.14277@waterleaf.sonytel.be> <1077533958.5942.42.camel@gaston> <Pine.GSO.4.58.0402231343270.14277@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AvG9e-000569-Fz
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 23 Feb 2004 05:29:50 -0800
Received: from gw02.mail.saunalahti.fi ([195.197.172.116])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1AvFqi-0007XO-LK
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 23 Feb 2004 05:10:16 -0800
Received: from kuori.saunalahti.fi (kuori.saunalahti.fi [195.197.175.23])
	by gw02.mail.saunalahti.fi (Postfix) with ESMTP id 46AD5F171AA
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 23 Feb 2004 15:21:52 +0200 (EET)
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.58.0402231343270.14277@waterleaf.sonytel.be>
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
To: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Mon, Feb 23, 2004 at 01:44:34PM +0100, Geert Uytterhoeven wrote:
> On Mon, 23 Feb 2004, Benjamin Herrenschmidt wrote:
> > Here's the code in atyfb:
> >
> > static inline void wait_for_fifo(u16 entries, const struct atyfb_par =
*par)
> > {
> > 	while ((aty_ld_le32(FIFO_STAT, par) & 0xffff) >
> > 	       ((u32) (0x8000 >> entries)));
> > }
>=20
> That's OK, as long as entries <=3D 15.

It's actually entries <=3D 16 since 0x0000 means all last 16 FIFO entries=
=20
are free. I didn't see any place where this would be broken or too many=20
register writes were done after wait_for_fifo().

> Using this register you cannot check for more than 15. There's another =
register
> for that, and the difference between PRO and older is in that second re=
gister.

BTW would it be possible to add a new accelerator type for Pro chips. I'd=
=20
like to identify Pro chips in my DirectFB driver because there are a few=20
important differences between Pro and older models. Othwerwise I'm going=20
to have to the same thing I did with matrox cards and use /proc/bus/pci :=
(

--=20
Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
