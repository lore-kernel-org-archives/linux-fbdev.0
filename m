From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 31 Mar 2016 06:30:11 +0000
Subject: Re: [PATCH] omapfb: Fix regulator API abuse in dss.c and hdmi4.c
Message-Id: <56FCC3F3.7060907@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="DAMD9xdlbC3w7muOTBu4arwev2VASBa0P"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1459355376-28507-1-git-send-email-broonie@kernel.org>
In-Reply-To: <1459355376-28507-1-git-send-email-broonie@kernel.org>
To: linux-fbdev@vger.kernel.org

--DAMD9xdlbC3w7muOTBu4arwev2VASBa0P
Content-Type: multipart/mixed; boundary="Mpl3HTexL72I2vkG4NEDKTuXsfFq9Fflh"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Mark Brown <broonie@kernel.org>,
 Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
 Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org,
 Tony Lindgren <tony@atomide.com>
Message-ID: <56FCC3F3.7060907@ti.com>
Subject: Re: [PATCH] omapfb: Fix regulator API abuse in dss.c and hdmi4.c
References: <1459355376-28507-1-git-send-email-broonie@kernel.org>
In-Reply-To: <1459355376-28507-1-git-send-email-broonie@kernel.org>

--Mpl3HTexL72I2vkG4NEDKTuXsfFq9Fflh
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Mark,

On 30/03/16 19:29, Mark Brown wrote:
> The voltage changing code in this driver is broken and should be
> removed.  The driver sets a single, exact voltage on probe.  Unless
> there is a very good reason for this (which should be documented in
> comments) constraints like this need to be set via the machine
> constraints, voltage setting in a driver is expected to be used in case=
s
> where the voltage varies at runtime.
>=20
> In addition client drivers should almost never be calling
> regulator_can_set_voltage(), if the device needs to set a voltage it
> needs to set the voltage and the regulator core will handle the case
> where the regulator is fixed voltage.  If the driver can skip setting
> the voltage it should just never set the voltage.
>=20
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  drivers/video/fbdev/omap2/omapfb/dss/dsi.c   | 9 ---------
>  drivers/video/fbdev/omap2/omapfb/dss/hdmi4.c | 9 ---------
>  2 files changed, 18 deletions(-)
>=20
> diff --git a/drivers/video/fbdev/omap2/omapfb/dss/dsi.c b/drivers/video=
/fbdev/omap2/omapfb/dss/dsi.c
> index 0eec073b3919..cfd0e3d5f36a 100644
> --- a/drivers/video/fbdev/omap2/omapfb/dss/dsi.c
> +++ b/drivers/video/fbdev/omap2/omapfb/dss/dsi.c
> @@ -1180,15 +1180,6 @@ static int dsi_regulator_init(struct platform_de=
vice *dsidev)
>  		return PTR_ERR(vdds_dsi);
>  	}
> =20
> -	if (regulator_can_change_voltage(vdds_dsi)) {
> -		r =3D regulator_set_voltage(vdds_dsi, 1800000, 1800000);
> -		if (r) {
> -			devm_regulator_put(vdds_dsi);
> -			DSSERR("can't set the DSI regulator voltage\n");
> -			return r;
> -		}
> -	}
> -

This code did fix an issue, see 02b7a32083b9930543663720758de249b4f6a2a3.=


Now, even at the time when I wrote that fix, it did feel a bit odd to
me. I have to say I don't remember the discussion that led to the patch,
perhaps it was something along "yes, the driver should not need to do
that, but for the time being do it".

So where are these "machine constraints" defined?

 Tomi


--Mpl3HTexL72I2vkG4NEDKTuXsfFq9Fflh--

--DAMD9xdlbC3w7muOTBu4arwev2VASBa0P
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW/MPzAAoJEPo9qoy8lh71/pgP/jXllOKwGjylsASBprSh7gED
FBHGikUXsysSCYhF0KBe4ZvS4WWutjW/7zz9Vilt4rdtIn7HR0ukT/Om/5xXualk
gneY5wJUgqi1Rb5sxMZmhOMSSGAA5r3Hzo20KwR4WxIKrqdB7cnYANZA9maFl+G2
28jCh2RNvhG147PNZcIqdjbVmfn/X6qJdl8geguWAdMt+DE4h0C9lq4M5K6QR+2o
09HpGDRzF0+G0OsqkVNgcMb2rt4aG1CrcNz2byJv9yzFPa8d0kLnEJ4dJDZ6ZO9S
ebrAoG5vmV/t3mE+LlTd5NlBwA5H4apjWC2AnpZ0uPuE8Un15vr5b6+90yECV0yb
ZIDjfmmFnTdKyzA5LofPOChQ4F9Cubv1Z1LgdlTFenQuJLJXv8U9p1Q8Kll1BH4j
pK/iCUVtz80f9Fc8s2Ic0Jq5p/548SK6YcY1kJQk6j2Xst92tBzcKd6JZiBOKChf
69vLb2FQiKWwH4KHdhRxinaH6/MMqP39K8ZPJQZ057pHt/AeKUAyxmckBCzg57iE
VvKmBxwI4BzQy1Mj/e6vcKGschNANXu5k5gH0vJ6g03d7+1zuj+auFhpxSvz1c2J
Lllf8WsKVc/gKB/NbV0NHE9FDopix+QeOJT+2zaun6QFeVnUyeMQ6srw19tDXGgd
g50m9KvbB2oeY45JsNPw
=EInq
-----END PGP SIGNATURE-----

--DAMD9xdlbC3w7muOTBu4arwev2VASBa0P--
