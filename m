From: Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Fri, 14 Nov 2014 10:24:17 +0000
Subject: Re: [PATCH 4/7] ARM: dts: sun6i: Add simplefb node
Message-Id: <20141114102417.GY20972@lukather>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="P6PRkhImOxklJvkF"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1415871109-28332-1-git-send-email-hdegoede@redhat.com>
 <1415871109-28332-4-git-send-email-hdegoede@redhat.com>
 <20141113164606.GM20972@lukather> <5464EFF9.9010203@redhat.com>
In-Reply-To: <5464EFF9.9010203@redhat.com>
To: linux-arm-kernel@lists.infradead.org


--P6PRkhImOxklJvkF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2014 at 06:52:57PM +0100, Hans de Goede wrote:
> Hi,
>=20
> On 11/13/2014 05:46 PM, Maxime Ripard wrote:
> > Hi,
> >=20
> > On Thu, Nov 13, 2014 at 10:31:46AM +0100, Hans de Goede wrote:
> >> Add a simplefb template node for u-boot to further fill and activate.
> >>
> >> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> >> ---
> >>  arch/arm/boot/dts/sun6i-a31.dtsi | 10 ++++++++++
> >>  1 file changed, 10 insertions(+)
> >>
> >> diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6=
i-a31.dtsi
> >> index 543f895..438952e 100644
> >> --- a/arch/arm/boot/dts/sun6i-a31.dtsi
> >> +++ b/arch/arm/boot/dts/sun6i-a31.dtsi
> >> @@ -62,6 +62,16 @@
> >>  		ethernet0 =3D &gmac;
> >>  	};
> >> =20
> >> +	chosen {
> >> +		#address-cells =3D <1>;
> >> +		#size-cells =3D <1>;
> >> +		ranges;
> >> +
> >> +		framebuffer0 {
> >> +			compatible =3D "simple-framebuffer";
> >> +			status =3D "disabled";
> >=20
> > Aren't we suppose to have clocks in there too?
>=20
> I deliberately left them out as they are not needed on sun6i, once the bl=
ocks
> are setup ahb access is not necessary, but it seems that the ahb_gate bits
> in sun4i / sun5i / sun7i double as a reset. Toggling them on / off / on b=
reaks
> the mode, while toggling module clocks on / off / on only causes a glitch.
>=20
> Since the sun6i has a separate reset controller, the clock gates seem to =
really
> only control ahb access which is not necessary once the mode has been set=
 up.

Ok. That can always be changed in the future if we ever find we need
them anyway.

I'll merge these four patches as soon as the bindings doc is
acked-by/merged by Grant or any other DT maintainer.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--P6PRkhImOxklJvkF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUZdhRAAoJEBx+YmzsjxAgJIQQAJJPp+WBAFH8nPYhiovSMRar
9E0VWsURwgJK4pnlBKJPfkTyNdal1BWwsjG4IHFW1l026OdBkxddEt6qJDZnjck1
uuvmChz92+8nD0DrZA9QH88dK2hoe2sFRYnXQu3ND8yvVktosWpD69vGBTuNl9Zi
st2df2Jj58PndFCPya2ZEkLaW5M4puGPdQ9Tr0gcawgZ/3hYIWh/rkLh7/MBBVQ3
o3d26wSjONVi9CeIEN9HGgzwSr5Ryx3Rrbab9fNrsuokIU/7dFh4jbOuDIEVrQ+w
96eI5blXughtmC0E8ROpxGtYZ7g1xtqZOOGfKHVGv1VE5TKiPKGchEvgqHwCuXES
FPEdjOMt5oofidydA6mqpNXhONMFWjyXklKmZgaufa3+oHFcRpJFGLA2YQNhaRHD
1owYvxcNJhlbtVNyzdN2LJZUY55uasXs2ULRKRERsHzymmrpMR370NGt1IrzeQFN
QdzIy/TaGmAPPsTTQfll0nRR59vq3QE05BT6o1r4cy6Rs6bIQrk/7Co19aO6yPVA
GRovwprE0P78JAgfLr4WPiO1wS7zm4nlb5BqmnKFPaQ9Zj7C1WU67w3XVg2iUOES
dTewv1PPVo5ws8VPLz5jZPaKFVw3AP/GMPj0kTpVrMR/Nh4rumwT8Shk9zYQ34S3
DRDFzkPUmX3oWtqrt5lG
=JSAV
-----END PGP SIGNATURE-----

--P6PRkhImOxklJvkF--
