From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: [patch] radeonfb: FB_WAITFORVSYNC implementation
Date: Sat, 12 Mar 2005 18:10:40 +0200
Message-ID: <20050312161040.GA28469@sci.fi>
References: <1110636406.5997.86.camel@atlantis.netenviron.com> <9e473391050312073314dcb39f@mail.gmail.com> <20050312155139.GA28135@sci.fi> <9e47339105031208003cd3d834@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DA9CO-0004VJ-LT
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 12 Mar 2005 08:10:44 -0800
Received: from gw01.mail.saunalahti.fi ([195.197.172.115])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DA9CN-0006C4-2E
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 12 Mar 2005 08:10:44 -0800
Received: from kuori.saunalahti.fi (kuori.saunalahti.fi [195.197.175.23])
	by gw01.mail.saunalahti.fi (Postfix) with ESMTP id 539C7DBDE0
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 12 Mar 2005 18:10:41 +0200 (EET)
Content-Disposition: inline
In-Reply-To: <9e47339105031208003cd3d834@mail.gmail.com>
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

On Sat, Mar 12, 2005 at 11:00:56AM -0500, Jon Smirl wrote:
> On Sat, 12 Mar 2005 17:51:39 +0200, Ville Syrj=E4l=E4 <syrjala@sci.fi> =
wrote:
> > It's not a problem if one doesn't use X.Org/XFree86. Also this patch
> > should not affect X.Org/XFree86 users unless they manage to call the
> > FBIO_WAITFORVSYNC ioctl. matroxfb and atyfb both have similar interru=
pt
> > support and X can still be used with both.
>=20
> Almost all PPC Linux boxes are running radeonfb with Xorg.

What's your point? I doubt X.Org uses FBIO_WAITFORSYNC so the patch=20
should not interfere with anything.

--=20
Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
