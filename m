From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [patch] radeonfb: FB_WAITFORVSYNC
	implementation
Date: Sun, 13 Mar 2005 10:23:31 +1100
Message-ID: <1110669811.19810.46.camel@gaston>
References: <1110636406.5997.86.camel@atlantis.netenviron.com>
	 <9e473391050312073314dcb39f@mail.gmail.com> <20050312155139.GA28135@sci.fi>
	 <9e47339105031208003cd3d834@mail.gmail.com> <20050312161040.GA28469@sci.fi>
	 <9e4733910503120821469e9b61@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DAFxn-0000Ve-DN
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 12 Mar 2005 15:24:07 -0800
Received: from gate.crashing.org ([63.228.1.57])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1DAFxl-0003fr-Si
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 12 Mar 2005 15:24:07 -0800
Received: from gaston (localhost [127.0.0.1])
	by gate.crashing.org (8.12.8/8.12.8) with ESMTP id j2CNLrgJ026004
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 12 Mar 2005 17:21:54 -0600
In-Reply-To: <9e4733910503120821469e9b61@mail.gmail.com>
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
To: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Sat, 2005-03-12 at 11:21 -0500, Jon Smirl wrote:
> On Sat, 12 Mar 2005 18:10:40 +0200, Ville Syrj=E4l=E4 <syrjala@sci.fi> =
wrote:
> > On Sat, Mar 12, 2005 at 11:00:56AM -0500, Jon Smirl wrote:
> > > On Sat, 12 Mar 2005 17:51:39 +0200, Ville Syrj=E4l=E4 <syrjala@sci.=
fi> wrote:
> > > > It's not a problem if one doesn't use X.Org/XFree86. Also this pa=
tch
> > > > should not affect X.Org/XFree86 users unless they manage to call =
the
> > > > FBIO_WAITFORVSYNC ioctl. matroxfb and atyfb both have similar int=
errupt
> > > > support and X can still be used with both.
> > >
> > > Almost all PPC Linux boxes are running radeonfb with Xorg.
> >=20
> > What's your point? I doubt X.Org uses FBIO_WAITFORSYNC so the patch
> > should not interfere with anything.
>=20
> Run something on one VT that uses radeonfb with FBIO_WAITFORSYNC.
> Switch to VT with xorg.
> Reboot box.

Not necessarily. We have the concept of active VT. FBIO_WAITFORSYNC only
need to enable interrupts during the ioctl execution, and mail stop
waiting and return an error if blank/set_var is called (and thus a VT
switch happens).

Ben.




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
