From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 05 Mar 2014 08:41:03 +0000
Subject: Re: [PATCH 3/9] Doc/DT: Add DT binding documentation for DVI Connector
Message-Id: <5316E31F.9050308@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="brrLPLh10qtl3A3tiWQ06r71cgUf2Mb4l"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1393590016-9361-1-git-send-email-tomi.valkeinen@ti.com> <1393590016-9361-4-git-send-email-tomi.valkeinen@ti.com> <20140228155937.GQ21483@n2100.arm.linux.org.uk> <5310B567.7040605@ti.com> <20140228162327.GT21483@n2100.arm.linux.org.uk>
In-Reply-To: <20140228162327.GT21483-l+eeeJia6m9vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
To: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Inki Dae <inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Andrzej Hajda <a.hajda-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Tomasz Figa <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>

--brrLPLh10qtl3A3tiWQ06r71cgUf2Mb4l
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 28/02/14 18:23, Russell King - ARM Linux wrote:

> That's rather a lot of compatible strings.  Another possibility is:
>=20
> 	compatible =3D "dvi-connector";
> 	analog;
> 	digital;
> 	single-link;
> 	dual-link;

I made the following changes compared to the posted version. I decided
to leave the "single-link" out, as it's implied if "digital" is set.

 Tomi

@@ -6,11 +6,16 @@ Required properties:

 Optional properties:
 - label: a symbolic name for the connector
-- i2c-bus: phandle to the i2c bus that is connected to DVI DDC
+- ddc-i2c-bus: phandle to the i2c bus that is connected to DVI DDC
+- analog: the connector has DVI analog pins
+- digital: the connector has DVI digital pins
+- dual-link: the connector has pins for DVI dual-link

 Required nodes:
 - Video port for DVI input

+Note: One (or both) of 'analog' or 'digital' must be set.
+
 Example
 -------

@@ -18,7 +23,9 @@ dvi0: connector@0 {
        compatible =3D "dvi-connector";
        label =3D "dvi";

-       i2c-bus =3D <&i2c3>;
+       digital;
+
+       ddc-i2c-bus =3D <&i2c3>;

        dvi_connector_in: endpoint {
                remote-endpoint =3D <&tfp410_out>;



--brrLPLh10qtl3A3tiWQ06r71cgUf2Mb4l
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJTFuMfAAoJEPo9qoy8lh71D44P/i+MeIpF1+fEf97oJ5PMW3l5
bLfNhD29hSpXwDBb3XjpT4750sLjA3BnJ/3fFIv9gxLO4xehpGj3sZcSH14RzmSh
4/JOCnOhATiJ4CnyimYWfPZhJxyAW5+Y/WoH2aGW/vjZpTEc85mImdjq96sdC2KS
Xxsq99cKeSgUOoD9nvO4iojeYnqlLj+Y0vNim4S459KneNL389eKaopAWwB/eEMh
XipkG1YM1xdeh1NaW0ghe5KbyIvt7MsRahBcfumeX9gqRt2v3u6h2RqFUASxDRa4
GoLx1aEC+JplX5s4XzDQbV3YMNYnEEdP1Sxm/6jOfmjtfJNpH+6sM8U6eBJMdLXf
kI82WOZBIrYVAa18YQ8SbhBwrXnTp2V3fKXDG+jXPNdrob++VenSSJPVXDwPQyZc
rP0qJx6+/FIJLjnlE+gt3LJ5QZSQHZ5P0ox0mOE8Q/KXi298fBhD1HLw+RNB/AOj
sBjm8l94ICA1vmKhI+CIAf8rpNYvQiWYgN/uhyZ7qaCQqPJRhpcBbSj3pYbkCegA
oOe0x/8DEP9MDYfwurM58Mzg4HFX/soeC+EI1a75oIQS1NQhAwx7TUSBA1pDJG+Z
Iz6H14cNxBoUHfkhqoIpME7FO6XHwp8VbHZx6XKccyXh76OWuMBFaIJotUdddk3o
JRML7GOxOXoOEH6y13BO
=SSCl
-----END PGP SIGNATURE-----

--brrLPLh10qtl3A3tiWQ06r71cgUf2Mb4l--
