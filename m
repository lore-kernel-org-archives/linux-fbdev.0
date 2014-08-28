From: Thierry Reding <thierry.reding@gmail.com>
Date: Thu, 28 Aug 2014 10:08:35 +0000
Subject: Re: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
Message-Id: <20140828100834.GA14388@ulmo>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="tKW2IUtsqtDRztdT"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20140825152232.GE15297@lukather> <20140826080432.GD17263@ulmo>
 <20140826135341.GM15297@lukather> <20140826143550.GB3027@ulmo>
 <20140826210248.GO15297@lukather> <20140827065440.GG15640@ulmo>
 <20140827084526.GR15297@lukather> <20140827095241.GC23186@ulmo>
 <20140827154221.GX15297@lukather>
 <CAOMqctSY7AJKHthe+aG8--Ok6JiY1g2zM_tN10S2nELOSe=qMw@mail.gmail.com>
In-Reply-To: <CAOMqctSY7AJKHthe+aG8--Ok6JiY1g2zM_tN10S2nELOSe=qMw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2014 at 10:57:29PM +0200, Michal Suchanek wrote:
> Hello,
>=20
> On 27 August 2014 17:42, Maxime Ripard <maxime.ripard@free-electrons.com>=
 wrote:
> > On Wed, Aug 27, 2014 at 11:52:48AM +0200, Thierry Reding wrote:
> >> On Wed, Aug 27, 2014 at 10:45:26AM +0200, Maxime Ripard wrote:
> >> > On Wed, Aug 27, 2014 at 08:54:41AM +0200, Thierry Reding wrote:
> >> > > On Tue, Aug 26, 2014 at 11:02:48PM +0200, Maxime Ripard wrote:
> >> > > > On Tue, Aug 26, 2014 at 04:35:51PM +0200, Thierry Reding wrote:
> >> [...]
> >> > > > > > Mike Turquette repeatedly said that he was against such a DT=
 property:
> >> > > > > > https://lkml.org/lkml/2014/5/12/693
> >> > > > >
> >> > > > > Mike says in that email that he's opposing the addition of a p=
roperty
> >> > > > > for clocks that is the equivalent of regulator-always-on. That=
's not
> >> > > > > what this is about. If at all it'd be a property to mark a clo=
ck that
> >> > > > > should not be disabled by default because it's essential.
> >> > > >
> >> > > > It's just semantic. How is "a clock that should not be disabled =
by
> >> > > > default because it's essential" not a clock that stays always on?
> >> > >
> >> > > Because a clock that should not be disabled by default can be turn=
ed off
> >> > > when appropriate. A clock that is always on can't be turned off.
> >> >
> >> > If a clock is essential, then it should never be disabled. Or we don=
't
> >> > share the same meaning of essential.
> >>
> >> Essential for the particular use-case.
> >
> > So, how would the clock driver would know about which use case we're
> > in? How would it know about which display engine is currently running?
> > How would it know about which video output is being set?
> >
> > Currently, we have two separate display engines, which can each output
> > either to 4 different outputs (HDMI, RGB/LVDS, 2 DSI). Each and every
> > one of these combinations would require different clocks. What clocks
> > will we put in the driver? All of them?
> >
>=20
> since simplefb cannot be extended how about adding, say, dtfb which
> claims the resources from dt and then instantiates a simplefb once the
> resources are claimed? That is have a dtfb which has the clocks
> assigned and has simplefb as child dt node.

I don't see how that changes anything. All you do is add another layer
of indirection. The fundamental problem remains the same and isn't
solved.

Thierry

--tKW2IUtsqtDRztdT
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT/v+iAAoJEN0jrNd/PrOhIN8P/0YQuU71mmyleDzTvlH8bQes
8YE80qgcb2VplW6BurdkBGWz9PTrMFvZ1QyY+XJ4mLqbiVB7UdbKzihK/8Lw+o6E
3caUXNSkfGnYAYv9YEDv6rcftwVsowxLnNUfhfL4GUYgU76e2WKxn7Mi3vPYJB5Y
XM1B+vUFFI8hCkSEwtUZFPeLIlRscJQKnFROvflf4uVhIQoAPoB2jXsG4NABiLxI
MD7+E09B3wIuDC8ebTqnVFpqG9UeCE6DH/7dHznlFR7V5NHaizUBAzmS0Fs8u22X
+b8pUVvVDB4byZQEjzh9JjvMSHM4wvIMlydlh/mFQVc4k3qtOXMb6CuQEEKBdQ+V
VJWOzGZvydC/LYqvD/40dMqmNyRhG7cqIptVG+xwun0npaawo9NWUKIpmXdqadEv
ExN+Fe4tP7z791fGZQQO80N0wc2Y9SZnhY0uOFMEK4zTZLP8HwOpj2Yp0qDevsXi
AJ27gqyId00BkNSgSO4C3DPG6hvOiFAjUC65+rMOFXfdKkwftB0jTbHrFrx1u20J
q1MdwyHFdWO3zRsZoALte/JqRYZw4ENmFwGvFk9Vc1mu4YXIDlOtr0+M2CY8PEjd
isK0+KSBJD8oan4YtU3qWAEcZf3rzBXNX8AVqeic/mXc0UpbHU9FU+RW49WDsYM0
Rv7UnT/e0WKP7jLP75Sc
=tk9I
-----END PGP SIGNATURE-----

--tKW2IUtsqtDRztdT--
