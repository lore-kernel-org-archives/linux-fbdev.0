From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: [patch] radeonfb: FB_WAITFORVSYNC implementation
Date: Wed, 16 Mar 2005 03:59:08 +0200
Message-ID: <20050316015908.GA26356@sci.fi>
References: <1110636406.5997.86.camel@atlantis.netenviron.com> <20050312151318.GA27200@sci.fi> <1110936530.5511.20.camel@africa.netenviron.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DBNoV-0005JQ-MP
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 15 Mar 2005 17:59:11 -0800
Received: from gw01.mail.saunalahti.fi ([195.197.172.115])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DBNoU-0007Bg-4C
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 15 Mar 2005 17:59:11 -0800
Received: from kuori.saunalahti.fi (kuori.saunalahti.fi [195.197.175.23])
	by gw01.mail.saunalahti.fi (Postfix) with ESMTP id F150DDC58A
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 16 Mar 2005 03:59:08 +0200 (EET)
Content-Disposition: inline
In-Reply-To: <1110936530.5511.20.camel@africa.netenviron.com>
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

On Wed, Mar 16, 2005 at 01:28:50AM +0000, Torgeir Veimo wrote:
> On Sat, 2005-03-12 at 17:13 +0200, Ville Syrj=E4l=E4 wrote:
> > On Sat, Mar 12, 2005 at 02:06:45PM +0000, Torgeir Veimo wrote:
> > > This is an implementation of the FB_WAITFORVSYNC ioctl for the rade=
onfb.
> > > A small test application is attached at the end. This patch is agai=
nst
> > > vanilla 2.6.11.
>=20
> > > +		/* clear interrupt */
> > > +		//OUTREG(GEN_INT_CNTL, int_cntl | CRTC_VBLANK_STAT_ACK);
> >=20
> > Why is this commented out?
>=20
> Well, first of all is it really important to clear the interrupt when
> enabling it?

Well, this being the vblank interrupt it's not really critical but=20
probably a good idea anyway.

> >From what I've seen the rage128 acknowledges an interrupt by writing t=
o
> the int_cntl register, while the radeon does it by writing to the
> int_status register, so I think the above code is not correct.. I might
> want to clear any vblank interrupts by writing to the int_status
> register though.

mach64 chips both enable and ack interrupts using the INT_CNTL register=20
(hence the spinlock in atyfb). Apparently they weren't really thinking=20
straight when they designed it.

--=20
Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
