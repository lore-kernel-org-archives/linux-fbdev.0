From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: [patch] radeonfb: FB_WAITFORVSYNC implementation
Date: Sat, 12 Mar 2005 19:33:46 +0200
Message-ID: <20050312173346.GA29610@sci.fi>
References: <1110636406.5997.86.camel@atlantis.netenviron.com> <20050312151318.GA27200@sci.fi> <1110647422.4004.456.camel@localhost>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DAAUo-00009W-2T
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 12 Mar 2005 09:33:50 -0800
Received: from gw02.mail.saunalahti.fi ([195.197.172.116])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DAAUm-0000mN-Hv
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 12 Mar 2005 09:33:50 -0800
Received: from kuori.saunalahti.fi (kuori.saunalahti.fi [195.197.175.23])
	by gw02.mail.saunalahti.fi (Postfix) with ESMTP id 23A51BA1A3
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 12 Mar 2005 19:33:47 +0200 (EET)
Content-Disposition: inline
In-Reply-To: <1110647422.4004.456.camel@localhost>
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

On Sat, Mar 12, 2005 at 12:10:22PM -0500, Michel D=E4nzer wrote:
> On Sat, 2005-03-12 at 17:13 +0200, Ville Syrj=E4l=E4 wrote:
> >=20
> > Also adding support for FB_ACTIVATE_VBL should be quite simple now.
>=20
> You don't need an interrupt for that. You can choose via the
> CRTC_OFFSET_CNTL:CRTC_OFFSET_FLIP_CNTL bit whether the update of the
> CRTC offset should take effect immediately or on the next vertical
> blank.

Great. Matrox and mach64 chips don't have such a bit so they need=20
to perform the flip/pan from the interrupt handler.

> Personally, I'm not sure why something that needs this functionality
> can't use the DRM...

I think the DRM is a real bitch to use. It requires a lot of hw specific=20
init code and AFAIK it needs root privilidges to get to the state where=20
you can actually use it. It's much easier to use fbdev. And IMO logically=
=20
that's where the vblank interrupt belongs since fbdev is the one=20
programming the CRTC.

--=20
Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
