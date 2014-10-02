From: Thierry Reding <thierry.reding@gmail.com>
Date: Thu, 02 Oct 2014 08:27:58 +0000
Subject: Re: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
Message-Id: <20141002082757.GB30167@ulmo>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="V0207lvV8h4k8FAm"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20140902092508.GR15297@lukather>
 <20140927235601.19023.31593@quantum> <20140929080637.GB12506@ulmo>
 <20140929161101.GS16977@sirena.org.uk>
 <20140930060312.GE29874@ulmo> <20140930180036.GI4273@sirena.org.uk>
 <20141001081443.GC18463@ulmo> <20141001122008.GW4273@sirena.org.uk>
 <20141001124852.GB21733@ulmo> <20141001171704.GG4273@sirena.org.uk>
In-Reply-To: <20141001171704.GG4273@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org


--V0207lvV8h4k8FAm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 01, 2014 at 06:17:04PM +0100, Mark Brown wrote:
> On Wed, Oct 01, 2014 at 02:48:53PM +0200, Thierry Reding wrote:
> > On Wed, Oct 01, 2014 at 01:20:08PM +0100, Mark Brown wrote:
[...]
> > >                and that the DT must not contain any hint of simplefb =
as
> > > shipped separately.
>=20
> > Well, I don't think it should because it describes the same resources
> > that the device tree node for the real device already describes. But
> > perhaps this is one of the cases where duplication isn't all that bad?
>=20
> If we were worried about this wecould also do it by referring to
> those nodes and saying "get all the resources these things need" rather
> than duplicating the references (this might make it easier to work out
> when the system is ready to hand off to the real drivers).

That's problematic to some degree because not all resource types may
have a binding that allows them to be automatically probed, so it could
be difficult to implement "get all the resources this thing needs". But
perhaps we can come up with good enough heuristics to make that work
reliably.

One downside of that is that there may be a lot of components involved
in getting display to work and not all resources may be needed to keep
the current state running, so we may be claiming too many. But given
that we'd eventually release all of them anyway this shouldn't be too
much of an issue.

> > >                     That's never going to work well as far as I can s=
ee
> > > but doesn't seem like an ABI stability issue, or at least not a
> > > reasonable one.
>=20
> > It would work well under the assumption that the kernel wouldn't be
> > touching any of the resources that simplefb depends on. If that's not a
> > reasonable assumption then I think we can't make simplefb work the way
> > it's currently written.
>=20
> I can't see how that's reasonable unless the kernel has some way of
> figuring out what it shouldn't be touching.

Agreed. It's become clear in this discussion that we can't do this in
the way x86 and other more firmware-oriented architectures do it. They
get away with it because they in fact hide all of this in the firmware
or don't provide a way to control the resources in such a fine-grained
manner to begin with.

Thierry

--V0207lvV8h4k8FAm
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJULQyNAAoJEN0jrNd/PrOhwM0QALgLBB+MYNxV9RjiSlZpwLpj
MrjxolNUPguwO+bGRAkn5O/De588XdgN2MUvSUYZ7/KbyZ4ArMRygXZPc9GFYsDu
PpgA9HmXJ3uetsVePIDFY3PKQbmy4VqlMKIO5fAy8sTel68BRzgcMZsDJiXBUNKX
wZR60Kfnn2w3/sEzejD78DSI9Ah4zaNgN6qDGf1Pr8OuuMdgSGH1d5KugWY+0lex
Ix7MvX0JvmlCs1j26Yzf6HNmoZw3mJ3vUe4fW6LKkX9OFFvGCDZV9DzkKCAqdAHe
Blh6C0tXisCZJzU5XUHgbdI96PnRrnG65DsJTfqCGj6IZlCiesXheKBnzSjCqKfY
65gC5ND/Hyei9LVW60lN+Dhw5EXYVh3aHQ7ZFHPHwUzx8z5sQnB6AoQC30E4UTVr
D8aIjTl1qO0MPxNh+HLIjsLdMIvb8GHm2BDHQLsybacuqDZ0EYx7LSuI4/GcajXi
QWDlJMKqXYSbhfkcf/f/sPGgaeTioGoZfXsV+eDMzICgxOJvr3n1PDv8FsNxrANJ
XCoj3m8ozXQmDqJG/Qed4ZGJTVDKMtyxqhTbD5WvvSpgvfZqjRjFKV/QhZQlZGba
uRFmHuBjvCv/Y8MFKL3HrAHRxed3dPJWgRa4t78XfmwXdWWoLzH0KBQ/Lslg/NtX
grCkqDHQK+DH7mE2fGS7
=j8gC
-----END PGP SIGNATURE-----

--V0207lvV8h4k8FAm--
