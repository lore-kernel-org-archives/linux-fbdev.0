From: Thierry Reding <thierry.reding@gmail.com>
Date: Mon, 25 Aug 2014 14:53:06 +0000
Subject: Re: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
Message-Id: <20140825145303.GC14763@ulmo.nvidia.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="B4IIlcmfBL/1gGOG"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1407914239-12054-1-git-send-email-libv@skynet.be>
 <1407914239-12054-5-git-send-email-libv@skynet.be>
 <53EB9471.3090204@wwwdotorg.org> <20140813170106.GT15297@lukather>
 <20140825121228.GB4163@ulmo.nvidia.com>
 <20140825124410.GZ15297@lukather>
 <20140825133953.GJ4163@ulmo.nvidia.com>
 <53FB3E7F.4000503@redhat.com>
 <20140825141600.GA14763@ulmo.nvidia.com>
 <53FB46FF.1010208@redhat.com>
In-Reply-To: <53FB46FF.1010208@redhat.com>
To: linux-arm-kernel@lists.infradead.org


--B4IIlcmfBL/1gGOG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 25, 2014 at 04:23:59PM +0200, Hans de Goede wrote:
> Hi,
>=20
> On 08/25/2014 04:16 PM, Thierry Reding wrote:
> > On Mon, Aug 25, 2014 at 03:47:43PM +0200, Hans de Goede wrote:
> >> On 08/25/2014 03:39 PM, Thierry Reding wrote:
> >>> On Mon, Aug 25, 2014 at 02:44:10PM +0200, Maxime Ripard wrote:
> >>>> On Mon, Aug 25, 2014 at 02:12:30PM +0200, Thierry Reding wrote:
> >>>>> On Wed, Aug 13, 2014 at 07:01:06PM +0200, Maxime Ripard wrote:
> >>>>>> On Wed, Aug 13, 2014 at 10:38:09AM -0600, Stephen Warren wrote:
> >>>>> [...]
> >>>>>>> If not, perhaps the clock driver should force the clock to be
> >>>>>>> enabled (perhaps only if the DRM/KMS driver isn't enabled?).
> >>>>>>
> >>>>>> I'm sorry, but I'm not going to take any code that will do that in=
 our
> >>>>>> clock driver.
> >>>>>>
> >>>>>> I'm not going to have a huge list of ifdef depending on configurat=
ion
> >>>>>> options to know which clock to enable, especially when clk_get sho=
uld
> >>>>>> have the consumer device as an argument.
> >>>>>
> >>>>> Are you saying is that you want to solve a platform-specific proble=
m by
> >>>>> pushing code into simple, generic drivers so that your platform cod=
e can
> >>>>> stay "clean"?
> >>>>
> >>>> Are you saying that this driver would become "dirty" with such a pat=
ch?
> >>>
> >>> Yes. Others have said the same and even provided alternative solutions
> >>> on how to solve what's seemingly a platform-specific problem in a
> >>> platform-specific way.
> >>
> >> This is not platform specific, any platform with a complete clock driv=
er
> >> will suffer from the same problem (the clock driver disabling unclaimed
> >> ahb gates, and thus killing the video output) if it wants to use simpl=
efb
> >> for early console support.
> >=20
> > It is platform specific in that your platform may require certain clocks
> > to remain on. The next platform may require power domains to remain on
> > during boot and yet another one may rely on regulators to stay on during
> > boot. By your argument simplefb will need to be taught to handle pretty
> > much every type of resource that the kernel has.
> >=20
> >> As for the suggestion to simply never disable the plls / ahb gates by =
blocking
> >> them from ever being disabled in the sunxi clock driver, that is not r=
eally
> >> a solution either, as we want to be able to turn these things off to s=
afe
> >> power on screen blank once control has been turned over to the kms dri=
ver.
> >=20
> > Then perhaps part of the hand-off procedure between simplefb and DRM/KMS
> > should involve marking PLLs or "gates" as properly managed.
>=20
> And by your earlier argument also power domains, regulators, etc. So now =
we need
> to add code to each of the clock core, power-domain core, regulator core,=
 etc. to
> have them now about this initially unmanaged state thing you're introduci=
ng, as
> well as modify all involved clock / regulator / etc. drivers to mark cert=
ain
> resources as unmanaged.

Hmm... that's true. But we already have a way to deal with exactly this
situation for regulators. There's a property called regulator-boot-on
which a bootloader should set whet it has enabled a given regulator. It
can of course also be set statically in a DTS if it's know upfront that
a bootloader will always enable it. Perhaps what we need is a similar
property for clocks so that the clock framework will not inadvertently
turn off a clock that's still being used.

Thierry

--B4IIlcmfBL/1gGOG
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT+03PAAoJEN0jrNd/PrOhNj8P/2zgeUjylGuqB9fW6HvWVRUT
5VonlgfUKhk99xf98bBYqqs/yYnHLo6/9A7YDd+H4szYKd+qZqb+9J8X3gpdpGWV
pH5enCPfwkTK1WzD1X8LDUHvzV/w6cNlz/24ZmHbXXLkgxrEO9bqa2qDndzzPpAm
uqMtQaX20wZMMfoRB64F/ZNv7hPtX3d2SLM7jm2VRdCiC5Hg/6YxdWwIEBtKfd67
HrKyJQX7hjiI1Eym5zzYBnE1/yWYZ8O1G5Pm/b1Ak2H2fMl/KebwreqyacDctQ68
wnUY9PXCe9qAt5Fm9hTGaeT7pIvsfv02t221h3UnDzKykS+ZyW490oRrpcwx/IR7
dPeJls9telZAeYNY0SIeOXr/iECNW9c9OKDDyoxLGKKlg76qGGaXb1rkSaW96jDa
N4RE0eYVkJtvV/oGiDKoHcqnBhbJNPXzTPl3NFzsUpTRPobhe0Xqzo+fVmNApl/Z
XDirAiEvbsN+3UngPWi6J5cibCiINCMUfIpHJdqIE3mI57Vw3lpcWS85Zd6heyBT
bHNa0KNIEkxn/Ur8IjvxojiK1/WmV9e+T4av1lANmw6XLVo/KwBXpCR3eaZjV3o+
GPM6Xe5MJ+yM6O45m7R4lBMMz7cGOPrsAFqPD8PhaiqhbNzhssc6dBa9uBp9I0uR
G9FvricULkgKdLjkupnQ
=XGXB
-----END PGP SIGNATURE-----

--B4IIlcmfBL/1gGOG--
