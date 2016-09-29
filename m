From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 29 Sep 2016 10:52:51 +0000
Subject: Re: [PATCH v2 1/3] dt-bindings: display: display-timing: Add property to configure sync drive edge
Message-Id: <68e2ba2d-90e6-d8c9-3595-cf566b18923e@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nnCH8aA2qe7rnTeF8JpK3Jw3L6TI2uCos"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20160922103526.24925-1-peter.ujfalusi@ti.com>
 <20160922103526.24925-2-peter.ujfalusi@ti.com>
In-Reply-To: <20160922103526.24925-2-peter.ujfalusi@ti.com>
To: Peter Ujfalusi <peter.ujfalusi@ti.com>, robh+dt@kernel.org, plagnioj@jcrosoft.com, airlied@linux.ie, thierry.reding@gmail.com
Cc: daniel.vetter@ffwll.ch, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org

--nnCH8aA2qe7rnTeF8JpK3Jw3L6TI2uCos
Content-Type: multipart/mixed; boundary="LoAnIed6b77XEb6R3cre25Oo5fMaPQbOn";
 protected-headers="v1"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Peter Ujfalusi <peter.ujfalusi@ti.com>, robh+dt@kernel.org,
 plagnioj@jcrosoft.com, airlied@linux.ie, thierry.reding@gmail.com
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 daniel.vetter@ffwll.ch, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org
Message-ID: <68e2ba2d-90e6-d8c9-3595-cf566b18923e@ti.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: display: display-timing: Add property
 to configure sync drive edge
References: <20160922103526.24925-1-peter.ujfalusi@ti.com>
 <20160922103526.24925-2-peter.ujfalusi@ti.com>
In-Reply-To: <20160922103526.24925-2-peter.ujfalusi@ti.com>

--LoAnIed6b77XEb6R3cre25Oo5fMaPQbOn
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 22/09/16 13:35, Peter Ujfalusi wrote:
> There are display panels which demands that the sync signal is driven o=
n
> different edge than the pixel data.
> With the syncclk-active property we can specify the clk edge to be used=
 to
> drive the sync signal. When the property is missing it indicates that t=
he
> sync is driven on the same edge as the pixel data.
>=20
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> CC: Rob Herring <robh+dt@kernel.org>
> CC: Mark Rutland <mark.rutland@arm.com>
> CC: devicetree@vger.kernel.org
> ---
>  .../devicetree/bindings/display/panel/display-timing.txt          | 8 =
++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/display/panel/display-ti=
ming.txt b/Documentation/devicetree/bindings/display/panel/display-timing=
=2Etxt
> index e1d4a0b59612..81a75893d1b8 100644
> --- a/Documentation/devicetree/bindings/display/panel/display-timing.tx=
t
> +++ b/Documentation/devicetree/bindings/display/panel/display-timing.tx=
t
> @@ -32,6 +32,14 @@ optional properties:
>  			- active low  =3D drive pixel data on falling edge/
>  					sample data on rising edge
>  			- ignored     =3D ignored
> + - syncclk-active: with
> +			- active high =3D drive sync on rising edge/
> +					sample sync on falling edge of pixel
> +					clock
> +			- active low  =3D drive sync on falling edge/
> +					sample sync on rising edge of pixel
> +					clock
> +			- omitted     =3D same configuration as pixelclk-active

I wonder if the "sample sync on..." should be left out here. It makes
sense for the pixel data, but for sync... Do the panels "sample" it, or
do they trigger on rising/falling edge?

Well, maybe that's a bit on the nitpick side, so:

Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

 Tomi


--LoAnIed6b77XEb6R3cre25Oo5fMaPQbOn--

--nnCH8aA2qe7rnTeF8JpK3Jw3L6TI2uCos
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJX7PKDAAoJEPo9qoy8lh71f6EP/0QaDHhUvNN7j3eKBp7JH8Qv
2ml1gOCp2i37X5karFcZ0uQzc8aYkAGl+BLJDv0wyGwb/fpPIsYcnNjb9lvf4STI
f4jz5iJVNxI8MtQMo91n/Ha1bYdkOqIZvSaUKxkayB9vEB/0zd6IksOD+yBI/YlX
ZrbHjoyfUf4VVu9VZZHrcDbERl3HlWuMXESzm6liHLaOGI3xvubxQwJ15vNqaLXk
y9h3oZmmBTnSqeab6KCk0OkTqNeclN4kRWOlljgObfUt6eSirDSG8DOOnmndQzW2
Jc4tAQ4apZFxec0KRq7jPUMnHxjIsYbmr4vSZq7HB5R36TaIcW2rwk5mHIx925AP
NKg5LDctnTEmhOEIZMfE+ioSNNPkPagn4XCxlsFqs0UR92h1+4Fz6n55IJbH6c7J
4bUC+/qDZVC+9yfCaohkOMiM/8ZeGPlkQqwDiMzuicLInXxzyCHJQbrZXIogZ7hw
ui5jWGCSK+RFaeRktoTd0sruKd9peV9DyUIjNkSiunErqncsEnVfm8IPtT/gQKGd
GUQznR2MfvgEsGiOo6kQOSJfDQ+mFDeedCNl++6Y2LpYkI5dGG4F4UE1geiRE4SI
Qty3arrWRj9EZlkp2YqCQzR0KcBKrinSPga2Ue21TBvOJdyPhRieLXJ6OlhIzZRn
+AigStpm1wwq8W03Hrjc
=og3m
-----END PGP SIGNATURE-----

--nnCH8aA2qe7rnTeF8JpK3Jw3L6TI2uCos--
