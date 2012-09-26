From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 26 Sep 2012 06:34:49 +0000
Subject: Re: [PATCH v2 10/18] OMAPDSS: DISPC: Configure input and output sizes for writeback
Message-Id: <1348641289.2376.3.camel@deskari>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-wZiJsiBKeRFzH1ZBlKMv"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1347538505-25359-1-git-send-email-archit@ti.com>
	  <1348553993-8083-1-git-send-email-archit@ti.com>
	  <1348553993-8083-11-git-send-email-archit@ti.com>
	 <1348583595.21717.2.camel@lappyti> <50629F0B.1080904@ti.com>
In-Reply-To: <50629F0B.1080904@ti.com>
To: Archit Taneja <a0393947@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org


--=-wZiJsiBKeRFzH1ZBlKMv
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2012-09-26 at 11:52 +0530, Archit Taneja wrote:
> On Tuesday 25 September 2012 08:03 PM, Tomi Valkeinen wrote:
> > On Tue, 2012-09-25 at 11:49 +0530, Archit Taneja wrote:
> >> Writeback uses the WB_PICTURE_SIZE register to define the size of the =
content
> >> written to memory, this is the output of the scaler. It uses the WB_SI=
ZE
> >> register to define the size of the content coming from the overlay/man=
ager to
> >> which it is connected, this is the input to the scaler. This naming is=
 different
> >> as compared to overlays.
> >>
> >> Add checks for writeback in dispc_ovl_set_input_size() and
> >> dispc_ovl_set_output_size() to write to the correct registers.
> >>
> >> Signed-off-by: Archit Taneja <archit@ti.com>
> >> ---
> >>   drivers/video/omap2/dss/dispc.c |    7 +++++--
> >>   1 file changed, 5 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss=
/dispc.c
> >> index e42e902..04fdd33 100644
> >> --- a/drivers/video/omap2/dss/dispc.c
> >> +++ b/drivers/video/omap2/dss/dispc.c
> >> @@ -719,7 +719,7 @@ static void dispc_ovl_set_input_size(enum omap_pla=
ne plane, int width,
> >>   {
> >>   	u32 val =3D FLD_VAL(height - 1, 26, 16) | FLD_VAL(width - 1, 10, 0)=
;
> >>
> >> -	if (plane =3D=3D OMAP_DSS_GFX)
> >> +	if (plane =3D=3D OMAP_DSS_GFX || plane =3D=3D OMAP_DSS_WB)
> >>   		dispc_write_reg(DISPC_OVL_SIZE(plane), val);
> >>   	else
> >>   		dispc_write_reg(DISPC_OVL_PICTURE_SIZE(plane), val);
> >> @@ -734,7 +734,10 @@ static void dispc_ovl_set_output_size(enum omap_p=
lane plane, int width,
> >>
> >>   	val =3D FLD_VAL(height - 1, 26, 16) | FLD_VAL(width - 1, 10, 0);
> >>
> >> -	dispc_write_reg(DISPC_OVL_SIZE(plane), val);
> >> +	if (plane =3D=3D OMAP_DSS_WB)
> >> +		dispc_write_reg(DISPC_OVL_PICTURE_SIZE(plane), val);
> >> +	else
> >> +		dispc_write_reg(DISPC_OVL_SIZE(plane), val);
> >>   }
> >
> > Should we just rename the dispc registers to DISPC_OVL_IN_SIZE and
> > DISPC_OVL_OUT_SIZE, and then we could do without the ifs? The registers
> > have always confused me a bit, I don't know why they are named so in th=
e
> > TRM.
>=20
> It'll be hard for someone who's referring to the TRM in that case. It'll=
=20
> also be hard to track reg dumps if these names change. I think we should=
=20
> stick to the TRM names only.

Generally speaking I agree.

However, with each new OMAP we get register name changes. We already
have at least a few of those, and I think it'll just get worse. So at
some point we'll have a mishmash of register names from different omap
versions, or we'll rename the registers according to one particular omap
version (probably the latest one), or we'll name the registers as seems
best for the driver.

But yes, perhaps it's still best to keep the reg names as they are.
Perhaps there's even a logic with the names, I just can't see it =3D).

 Tomi


--=-wZiJsiBKeRFzH1ZBlKMv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQYqIJAAoJEPo9qoy8lh71q2MP+wX4cG8yGjynuZhGEeWe247p
KwPRsyJc19SviR0ONuRa/qjUnd1jbYTvYEWw/+UqKbMGd+cdiSDuS/80AqxOK4vK
1uBCQGFblTNS83gkhtXWn0y+CzMN0xiExTKPqg/R5ABA53jVX/yigH+EUbqXxit7
rozXUgMgIInfk1Oj/4QgaL4Bwvh/eD+7XXV/eEuvPDWBhELwIuylTGzPFQtRmhk3
7lKm6g7OgccI6xasmuPbW9cmqkXu8Yu3SlnUo/hUfKd2Ozp4ldcAB3T28twLXozk
kqDYE5N3NijVGPxtVTp5R/XKBFrudHQiriL1z/Y0B43g6dE8UQ7SBnPImsk2XRJE
tdMfCiFYPbybQtToy2Z8DrdISuFvhuFz8sBs28k8sr3GDAj2J+YQIzR31qpBA2Y+
Dbpmfa8IOc9dFRdSXp0bBq9KJSMMhUiKeMZsDniN2s+HkjMjq9JRLCsYodjSKNQ8
/t7bsPu7PgCiHGLF8UQD1/MF03j0be/OmlzHHNeSdfpU6sPH5pSVCcuUd+21N0Qy
Pulu9q7P5JUNdfzeVExgV/qybfObtQpCfOvbcxE7PTb0AqOIzhpeB/eO8ThYR/Nw
NXCgRSMqyllhMyB3I0PT3K2MQk9BrqZv9xX1+Ny5aWaLTCxzRADmpOi1TZxgzXXE
ImbiOtN5NBsjdSQ3D+Lp
=PV6N
-----END PGP SIGNATURE-----

--=-wZiJsiBKeRFzH1ZBlKMv--

