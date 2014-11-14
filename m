From: Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Fri, 14 Nov 2014 11:21:01 +0000
Subject: Re: [PATCH 4/7] ARM: dts: sun6i: Add simplefb node
Message-Id: <20141114112101.GC20972@lukather>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="G5yIW5EaChZ5gJdA"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1415871109-28332-1-git-send-email-hdegoede@redhat.com>
 <1415871109-28332-4-git-send-email-hdegoede@redhat.com>
 <20141113164606.GM20972@lukather> <5464EFF9.9010203@redhat.com>
 <20141114102417.GY20972@lukather> <5465D9B1.8010707@redhat.com>
In-Reply-To: <5465D9B1.8010707@redhat.com>
To: linux-arm-kernel@lists.infradead.org


--G5yIW5EaChZ5gJdA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 14, 2014 at 11:30:09AM +0100, Hans de Goede wrote:
> Hi,
>=20
> On 11/14/2014 11:24 AM, Maxime Ripard wrote:
> > On Thu, Nov 13, 2014 at 06:52:57PM +0100, Hans de Goede wrote:
> >> Hi,
> >>
> >> On 11/13/2014 05:46 PM, Maxime Ripard wrote:
> >>> Hi,
> >>>
> >>> On Thu, Nov 13, 2014 at 10:31:46AM +0100, Hans de Goede wrote:
> >>>> Add a simplefb template node for u-boot to further fill and activate.
> >>>>
> >>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> >>>> ---
> >>>>  arch/arm/boot/dts/sun6i-a31.dtsi | 10 ++++++++++
> >>>>  1 file changed, 10 insertions(+)
> >>>>
> >>>> diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/su=
n6i-a31.dtsi
> >>>> index 543f895..438952e 100644
> >>>> --- a/arch/arm/boot/dts/sun6i-a31.dtsi
> >>>> +++ b/arch/arm/boot/dts/sun6i-a31.dtsi
> >>>> @@ -62,6 +62,16 @@
> >>>>  		ethernet0 =3D &gmac;
> >>>>  	};
> >>>> =20
> >>>> +	chosen {
> >>>> +		#address-cells =3D <1>;
> >>>> +		#size-cells =3D <1>;
> >>>> +		ranges;
> >>>> +
> >>>> +		framebuffer0 {
> >>>> +			compatible =3D "simple-framebuffer";
> >>>> +			status =3D "disabled";
> >>>
> >>> Aren't we suppose to have clocks in there too?
> >>
> >> I deliberately left them out as they are not needed on sun6i, once the=
 blocks
> >> are setup ahb access is not necessary, but it seems that the ahb_gate =
bits
> >> in sun4i / sun5i / sun7i double as a reset. Toggling them on / off / o=
n breaks
> >> the mode, while toggling module clocks on / off / on only causes a gli=
tch.
> >>
> >> Since the sun6i has a separate reset controller, the clock gates seem =
to really
> >> only control ahb access which is not necessary once the mode has been =
set up.
> >=20
> > Ok. That can always be changed in the future if we ever find we need
> > them anyway.
> >=20
> > I'll merge these four patches as soon as the bindings doc is
> > acked-by/merged by Grant or any other DT maintainer.
>=20
> Note these patches are using framebuffer0 rather then framebuffer0-hdmi a=
s node
> name, which may cause issues if we later want to add lcd support. So I've=
 a v2
> coming which changes the name to framebuffer0-hdmi, please merge that ins=
tead.

Ok :)

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--G5yIW5EaChZ5gJdA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUZeWdAAoJEBx+YmzsjxAgmMMP/iyWArNJG5a3/SaFsSHNouIs
H1szWVdWVMBFF2rReilWrXV/ofy7qlENPUD994lZ7qVC6Eku86Bmivy4DXbmPHrZ
wpjfJnCTtzWY56uSu1gr2KmsN7B9hzYykg11daQwos+vxBmS/hRg+f4QsYSXQxPK
gt8q/tPvokkYph4IYAE8/AtSYIdW4dh/by6mtViZiGunRWwEu7aCy5K49XSGKse3
2znv5RdiD7qL2a8lI+azsdCatBsGiUtB4MwhjFo2naW4oWYvtRYxVSbCWH4rFtr3
Q4T31uh8PDT1Dd+Is9DvrVLAQ/D1mT+VUSOLQfRLHw/JfbVh4uTevogNanesWYXC
3PcXqLI9dtWUKWB1CZgwtU1+H30iGmACQP9D0TR0mNG88MUc1Uan0AyIhbppA1Es
LWKoGMQllDTuon8JFyFx/7QtrHaRmnIGXbkMx4vapZfQ7bov7Q6jZjMPerImFsNN
SrEOZdNRTLbxDj1EkaDVO8tTOa9p4429BJqHHjnO+GGpPm2xAKbtJsOeMLSJEPIX
gfLGWNqht8A4fwsjyCRW+1G8zh4sVB0x9cXh0nmJeOJqVYFPjE91RrD4Ah/AyZMA
GSVR23ZWuU2m2XzCFNz/iRFPu+SPHHE1Sw7vXe4XdyQmQKZAwe/l4pwEcnsJ+WIW
6s255UwtWnxPh3MoZQjz
=dCQg
-----END PGP SIGNATURE-----

--G5yIW5EaChZ5gJdA--
