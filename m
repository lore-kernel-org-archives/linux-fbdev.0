From: Thierry Reding <thierry.reding@gmail.com>
Date: Mon, 25 Aug 2014 15:05:04 +0000
Subject: Re: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
Message-Id: <20140825150501.GE14763@ulmo.nvidia.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="PGNNI9BzQDUtgA2J"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1407914239-12054-1-git-send-email-libv@skynet.be>
 <1407914239-12054-5-git-send-email-libv@skynet.be>
 <53EB9471.3090204@wwwdotorg.org> <20140813170106.GT15297@lukather>
 <20140825121228.GB4163@ulmo.nvidia.com>
 <20140825124410.GZ15297@lukather>
 <20140825133953.GJ4163@ulmo.nvidia.com>
 <53FB3E7F.4000503@redhat.com>
 <20140825141600.GA14763@ulmo.nvidia.com>
 <20140825145854.GA15297@lukather>
In-Reply-To: <20140825145854.GA15297@lukather>
To: linux-arm-kernel@lists.infradead.org


--PGNNI9BzQDUtgA2J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 25, 2014 at 04:58:54PM +0200, Maxime Ripard wrote:
> On Mon, Aug 25, 2014 at 04:16:29PM +0200, Thierry Reding wrote:
> > On Mon, Aug 25, 2014 at 03:47:43PM +0200, Hans de Goede wrote:
> > > On 08/25/2014 03:39 PM, Thierry Reding wrote:
> > > > On Mon, Aug 25, 2014 at 02:44:10PM +0200, Maxime Ripard wrote:
> > > >> On Mon, Aug 25, 2014 at 02:12:30PM +0200, Thierry Reding wrote:
> > > >>> On Wed, Aug 13, 2014 at 07:01:06PM +0200, Maxime Ripard wrote:
> > > >>>> On Wed, Aug 13, 2014 at 10:38:09AM -0600, Stephen Warren wrote:
> > > >>> [...]
> > > >>>>> If not, perhaps the clock driver should force the clock to be
> > > >>>>> enabled (perhaps only if the DRM/KMS driver isn't enabled?).
> > > >>>>
> > > >>>> I'm sorry, but I'm not going to take any code that will do that =
in our
> > > >>>> clock driver.
> > > >>>>
> > > >>>> I'm not going to have a huge list of ifdef depending on configur=
ation
> > > >>>> options to know which clock to enable, especially when clk_get s=
hould
> > > >>>> have the consumer device as an argument.
> > > >>>
> > > >>> Are you saying is that you want to solve a platform-specific prob=
lem by
> > > >>> pushing code into simple, generic drivers so that your platform c=
ode can
> > > >>> stay "clean"?
> > > >>
> > > >> Are you saying that this driver would become "dirty" with such a p=
atch?
> > > >=20
> > > > Yes. Others have said the same and even provided alternative soluti=
ons
> > > > on how to solve what's seemingly a platform-specific problem in a
> > > > platform-specific way.
> > >=20
> > > This is not platform specific, any platform with a complete clock dri=
ver
> > > will suffer from the same problem (the clock driver disabling unclaim=
ed
> > > ahb gates, and thus killing the video output) if it wants to use simp=
lefb
> > > for early console support.
> >=20
> > It is platform specific in that your platform may require certain clocks
> > to remain on.
>=20
> The platform doesn't. simplefb does. simplefb is the obvious consumer
> for these clocks, and given the current API and abstraction we have,
> it should be the one claiming the clocks too.

No. simplefb just wants to write to some memory that hardware has been
set up to scan out. The platform requires that the clocks be on. Other
platforms may not even allow turning off the clocks.

> > The next platform may require power domains to remain on during boot
> > and yet another one may rely on regulators to stay on during
> > boot. By your argument simplefb will need to be taught to handle
> > pretty much every type of resource that the kernel has.
>=20
> And I wouldn't find anything wrong with that. We're already doing so
> for any generic driver in the kernel (AHCI, EHCI comes to my mind
> first, there's probably a lot of others). Why wouldn't we do as such
> for this one?

Yes, and we've had similar discussions in those subsystems too.

Thierry

--PGNNI9BzQDUtgA2J
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT+1CdAAoJEN0jrNd/PrOhQl0QAJCPvJiwzEC0dT6GO5vZi6Yg
2vPno9GJ/G1u/aOjnDI2jz/WBNxprmA5OJH6j1IyxgX0mTimIci4sm6SNJwjEJli
Dj8/4XdMw8b1+z0idvhdkVWJhbI2UtloLipMvZUNnhrEpWvZyB8UCMXtCnKSrjUF
RcZmtI62tUu8XAZ1rxOUCjQxFyJdcWIg4E9+qiopNCEHSCbbhzeNZr7gR4WHabMs
knMvEFTNQVO437i+1/t3urET/ykEUQKLTxzTc3RbYd6j6EuFx1Wmti6U7WS519XT
MszsIHGUfJnaJDP180UClDOmo3p17reYiBXpdQLh5EE2gPQRxMLCtYnSa5p8qfQc
Oz9pZmw/znvqoYp98Lq+zEnj1vFHX5Ux6FzbV5I/ZhwpEV0hPhO8nty7zjnUnFBF
SYFm2jsQJnSufyCpsh5bjqG2JdxzKcyCT2OKpKqXxvgeADubkt8KD+OoyQixgTRr
UPyzh4Ard0G8w+6zk/vg4Qo16sZlSeIDdpFoL7LQPYppjS54996soFVt29zbdo6G
ovKYmk5LBJfjsiPpfDzVeMks9aEriPCPEWq+1juBksqLy1eDlAMX7H5/fv54Izzl
vZN0/IQ0xLK8kR/h283N+53WY6Yu6aCX6tQNaucRkHXI8SpJWFHpuNxkZ9GxKuKl
HPYR2aKNHPhC2SQN9Ekz
=4zVY
-----END PGP SIGNATURE-----

--PGNNI9BzQDUtgA2J--
