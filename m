From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: Re: FB model basic issues (WAS: radeon, apertures & memory mapping)
Date: Wed, 16 Mar 2005 18:35:49 -0500
Message-ID: <9e47339105031615355bb3986f@mail.gmail.com>
References: <1110784327.5787.288.camel@gaston>
	 <1110839873.5673.41.camel@gaston>
	 <1110862777.4044.592.camel@localhost> <20050315060138.GA13064@sci.fi>
	 <4236C770.8020101@hispeed.ch> <1110907029.4001.624.camel@localhost>
	 <1110942559.24296.107.camel@gaston> <20050316200808.GB6651@sci.fi>
	 <1111005770.5535.63.camel@localhost>
	 <1111015617.15509.56.camel@gaston>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DBi3M-00009y-ET
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 16 Mar 2005 15:35:52 -0800
Received: from rproxy.gmail.com ([64.233.170.194])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DBi3L-000842-Vn
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 16 Mar 2005 15:35:52 -0800
Received: by rproxy.gmail.com with SMTP id j1so300540rnf
        for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 16 Mar 2005 15:35:49 -0800 (PST)
In-Reply-To: <1111015617.15509.56.camel@gaston>
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: =?ISO-8859-1?Q?Michel_D=E4nzer?= <michel@daenzer.net>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, dri-devel@lists.sourceforge.net, xorg@lists.freedesktop.org

On Thu, 17 Mar 2005 10:26:57 +1100, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Wed, 2005-03-16 at 15:42 -0500, Michel D=E4nzer wrote:
> > On Wed, 2005-03-16 at 22:08 +0200, Ville Syrj=E4l=E4 wrote:
> > >
> > > I don't see the current system slowly evolving into some superb futur=
e
> > > system with an in kernel memory manager. The current APIs just have t=
oo
> > > many limitations. I think the memory manager must be the foundation o=
f
> > > everything and after it's in place the fbdev API should be able to us=
e it.
> > > The only change to simple fbdev apps would be that they can't get acc=
ess
> > > to any offscreen memory as they do now. Something like DirectFB would=
 need
> > > to change to accomodate the new system but I don't see that as a prob=
lem.
> >
> > I agree on this.
>=20
> Ok, ok, I'll do crap since that's what everybody wants.

Why don't we modify the new radoenfb driver to have a real
arbitration/management layer. Directfb can continue to use the old
driver. The rule is that you can't mix old and new style fbdev drivers
in a system. Over time DirectFb and X can be fixed to use the new
model.

There is going to have to be a transition path while we debug the
arbitration/management layer and figure out the right API for it.
Supporting multiple disparate users of the graphics hardware is a
quite complex feature that no other operating system implements.


>=20
> Ben.
>=20
>=20
> _______________________________________________
> xorg mailing list
> xorg@lists.freedesktop.org
> http://lists.freedesktop.org/mailman/listinfo/xorg
>=20


--=20
Jon Smirl
jonsmirl@gmail.com


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
