From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [patch] radeonfb: FB_WAITFORVSYNC implementation
Date: Sat, 12 Mar 2005 11:21:45 -0500
Message-ID: <9e4733910503120821469e9b61@mail.gmail.com>
References: <1110636406.5997.86.camel@atlantis.netenviron.com>
	 <9e473391050312073314dcb39f@mail.gmail.com>
	 <20050312155139.GA28135@sci.fi>
	 <9e47339105031208003cd3d834@mail.gmail.com>
	 <20050312161040.GA28469@sci.fi>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DA9UX-0005Pn-Jt
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 12 Mar 2005 08:29:29 -0800
Received: from externalmx-1.sourceforge.net ([12.152.184.25])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1DA9UW-0004Bt-4k
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 12 Mar 2005 08:29:29 -0800
Received: from rproxy.gmail.com ([64.233.170.201])
	by externalmx-1.sourceforge.net with esmtp (Exim 4.41)
	id 1DA9UV-0007KL-2b
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 12 Mar 2005 08:29:27 -0800
Received: by rproxy.gmail.com with SMTP id z35so1864320rne
        for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 12 Mar 2005 08:28:25 -0800 (PST)
In-Reply-To: <20050312161040.GA28469@sci.fi>
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

On Sat, 12 Mar 2005 18:10:40 +0200, Ville Syrj=E4l=E4 <syrjala@sci.fi> wrot=
e:
> On Sat, Mar 12, 2005 at 11:00:56AM -0500, Jon Smirl wrote:
> > On Sat, 12 Mar 2005 17:51:39 +0200, Ville Syrj=E4l=E4 <syrjala@sci.fi> =
wrote:
> > > It's not a problem if one doesn't use X.Org/XFree86. Also this patch
> > > should not affect X.Org/XFree86 users unless they manage to call the
> > > FBIO_WAITFORVSYNC ioctl. matroxfb and atyfb both have similar interru=
pt
> > > support and X can still be used with both.
> >
> > Almost all PPC Linux boxes are running radeonfb with Xorg.
>=20
> What's your point? I doubt X.Org uses FBIO_WAITFORSYNC so the patch
> should not interfere with anything.

Run something on one VT that uses radeonfb with FBIO_WAITFORSYNC.
Switch to VT with xorg.
Reboot box.

>=20
> --
> Ville Syrj=E4l=E4
> syrjala@sci.fi
> http://www.sci.fi/~syrjala/
>=20
> -------------------------------------------------------
> SF email is sponsored by - The IT Product Guide
> Read honest & candid reviews on hundreds of IT Products from real users.
> Discover which products truly live up to the hype. Start reading now.
> http://ads.osdn.com/?ad_ide95&alloc_id=14396&opclick
> _______________________________________________
> Linux-fbdev-devel mailing list
> Linux-fbdev-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel
>=20


--=20
Jon Smirl
jonsmirl@gmail.com


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
