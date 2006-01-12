From: Steve Langasek <vorlon@debian.org>
Subject: Bug#347186: linux-image-2.6.14-2-alpha-generic: garbled Matrox framebuffer
Date: Wed, 11 Jan 2006 21:15:22 -0800
Message-ID: <20060112051522.GP11974@tennyson.dodds.net>
References: <20060109090849.GB3481@tennyson.dodds.net> <20060109093517.GA23253@localhost.localdomain> <20060109105146.GE3481@tennyson.dodds.net> <20060111102827.GF7691@nancy> <43C4EAD4.2090704@pol.net> <20060109090849.GB3481@tennyson.dodds.net> <20060109093517.GA23253@localhost.localdomain> <20060109105146.GE3481@tennyson.dodds.net> <20060111102827.GF7691@nancy>
Reply-To: Steve Langasek <vorlon@debian.org>, 347186@bugs.debian.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZgGN478A9hzzvyZc"
Return-path: <bounce-debian-bugs-dist=glddb-debian-bugs-dist=m.gmane.org@lists.debian.org>
Resent-To: debian-bugs-dist@lists.debian.org
Resent-Message-ID: <handler.347186.B347186.11370429256156@bugs.debian.org>
Content-Disposition: inline
In-Reply-To: <43C4EAD4.2090704@pol.net> <20060111102827.GF7691@nancy>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:debian-bugs-dist@lists.debian.org>
List-Help: <mailto:debian-bugs-dist-request@lists.debian.org?subject=help>
List-Subscribe: <mailto:debian-bugs-dist-request@lists.debian.org?subject=subscribe>
List-Unsubscribe: <mailto:debian-bugs-dist-request@lists.debian.org?subject=unsubscribe>
To: maximilian attems <maks@sternwelten.at>, "Antonino A. Daplas" <adaplas@pol.net>
Cc: 347186@bugs.debian.org, linux-fbdev-devel@lists.sourceforge.net


--ZgGN478A9hzzvyZc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 11, 2006 at 11:28:27AM +0100, maximilian attems wrote:

> > > > Sigh, can't get a break with alpha kernel support around here.  Aft=
er
> > > > upgrading to 2.6.14 (from 2.4.27), the Matrox framebuffer no longer=
 works
> > > > correctly on my alpha with a Matrox Millenium II.  The matroxfb_bas=
e module
> > > > loads without error, but gives me corrupt video output only.

> > > Try turning off acceleration.

> > Doesn't make a difference.

> > What did make a difference was, after googling, loading fbcon manually
> > before loading matroxfb_base.  Given that I'm loading matroxfb_base by =
hand
> > (/etc/modules), it's not getting loaded via udev or anything like that,=
 it
> > seems to me that it's my responsibility to load fbcon by hand as well, =
but
> > it's still something of an unexpected change from 2.4.  It might be nic=
e to
> > have these modules all autoloaded by something, but it's not strictly
> > necessary, and some users may not want the framebuffer activated
> > automatically?

> > The other issue (and the first thing I was trying to get work, which le=
d me
> > to believe the fb was completely broken) is that, even though console w=
orks
> > on the framebuffer now, X does not.  This breakage corresponds to the k=
ernel
> > upgrade, not to any changes in X, so still looks like a kernel bug to m=
e.

> > If I turn off "UseFBDev" in my xorg.conf, X displays correctly.  I have=
n't
> > poked yet to see what this does performance-wise.

> 2.6.15 has matroxfb patches, did it make a difference on your box?

Don't know yet, thanks to bug #347556. :)

On Wed, Jan 11, 2006 at 07:24:04PM +0800, Antonino A. Daplas wrote:

> >>  It might be nice to
> >> have these modules all autoloaded by something, but it's not strictly
> >> necessary, and some users may not want the framebuffer activated
> >> automatically?

> As long as fbcon is compiled statically, you'll get the same 2.4 behavior.

<nod>  I leave it to Norbert to decide what the policy should be for fbcon
in the alpha kernel images.

> >> The other issue (and the first thing I was trying to get work, which l=
ed me
> >> to believe the fb was completely broken) is that, even though console =
works
> >> on the framebuffer now, X does not.  This breakage corresponds to the =
kernel
> >> upgrade, not to any changes in X, so still looks like a kernel bug to =
me.

> >> If I turn off "UseFBDev" in my xorg.conf, X displays correctly.  I hav=
en't
> >> poked yet to see what this does performance-wise.

> The "UseFBDev" option was added to X so it can cooperate with fbcon (ie, =
allows
> X to restore the console state by using the fbdev API ).  In 2.6, fbcon h=
as its
> own way of restoring its own state so the "UseFBDev" option is not needed=
, and in
> your case, is counterproductive.

Aha, didn't know that.  It had been my impression that this option meant
using the fbdev API for all vidcard access; but I guess that's the fbdev
driver, anyway.

So the real target for all of this was to get matroxfb working to the point
of running bterm successfully from the debian installer; and even with fbcon
working, in 2.6.14 running bterm or fbi gives me a whole lot of nothing
(console blanks, nothing gets displayed).  I'll give this another try with
2.6.15 once I've got my /usr partition mounting again.

--=20
Steve Langasek                   Give me a lever long enough and a Free OS
Debian Developer                   to set it on, and I can move the world.
vorlon@debian.org                                   http://www.debian.org/

--ZgGN478A9hzzvyZc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDxeXqKN6ufymYLloRAvzUAJ95sIlKLnANMuIjTEIa+22kv8BftgCggntd
vPYU3JXS32CsL184NZtAEYQ=
=E/+8
-----END PGP SIGNATURE-----

--ZgGN478A9hzzvyZc--
