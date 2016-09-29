From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 29 Sep 2016 10:54:11 +0000
Subject: Re: [PATCH v2 2/3] video: display_timing: Add flags to select the edge when the sync is driven
Message-Id: <091c4fd9-d037-4e7e-b003-140395a2ca38@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="TI5JhQnQSt0kwJ89cghREPshaHHRBb9oV"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20160922103526.24925-1-peter.ujfalusi@ti.com>
 <20160922103526.24925-3-peter.ujfalusi@ti.com>
In-Reply-To: <20160922103526.24925-3-peter.ujfalusi-l0cyMroinI0@public.gmane.org>
To: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, airlied-cv59FeDIM0c@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, daniel.vetter-/w4YWyX8dFk@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

--TI5JhQnQSt0kwJ89cghREPshaHHRBb9oV
Content-Type: multipart/mixed; boundary="53AoaU7D08ljTN5QuGanBcsRLsOqfbbK6";
 protected-headers="v1"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Peter Ujfalusi <peter.ujfalusi@ti.com>, robh+dt@kernel.org,
 airlied@linux.ie, thierry.reding@gmail.com
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 daniel.vetter@ffwll.ch, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org
Message-ID: <091c4fd9-d037-4e7e-b003-140395a2ca38@ti.com>
Subject: Re: [PATCH v2 2/3] video: display_timing: Add flags to select the
 edge when the sync is driven
References: <20160922103526.24925-1-peter.ujfalusi@ti.com>
 <20160922103526.24925-3-peter.ujfalusi@ti.com>
In-Reply-To: <20160922103526.24925-3-peter.ujfalusi@ti.com>

--53AoaU7D08ljTN5QuGanBcsRLsOqfbbK6
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 22/09/16 13:35, Peter Ujfalusi wrote:
> The sync can be - and for some panels it must be - driven on different =
edge
> then the data.

Well, the "can be" depends on the display controller =3D).

> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> CC: Rob Herring <robh+dt@kernel.org>
> CC: Mark Rutland <mark.rutland@arm.com>
> CC: devicetree@vger.kernel.org
> ---
>  include/video/display_timing.h | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/include/video/display_timing.h b/include/video/display_tim=
ing.h
> index 28d9d0d566ca..3d289e990aca 100644
> --- a/include/video/display_timing.h
> +++ b/include/video/display_timing.h
> @@ -28,6 +28,10 @@ enum display_flags {
>  	DISPLAY_FLAGS_INTERLACED	=3D BIT(8),
>  	DISPLAY_FLAGS_DOUBLESCAN	=3D BIT(9),
>  	DISPLAY_FLAGS_DOUBLECLK		=3D BIT(10),
> +	/* drive sync on pos. edge */
> +	DISPLAY_FLAGS_SYNC_POSEDGE	=3D BIT(11),
> +	/* drive sync on neg. edge */
> +	DISPLAY_FLAGS_SYNC_NEGEDGE	=3D BIT(12),
>  };
> =20
>  /*
>=20

Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

 Tomi


--53AoaU7D08ljTN5QuGanBcsRLsOqfbbK6--

--TI5JhQnQSt0kwJ89cghREPshaHHRBb9oV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJX7PLTAAoJEPo9qoy8lh71w5MP/i9UO8HkG2WUA0w6/VYDVVkp
tdy9v+rchBet8xc1LakGAlncd2ug20u4O5b7SZKph1RG9ScfFhRzV+T/hDoNdIiU
ytqNFMuG81FmFL6J8vf/M+4aKBnlKxz/MHgkUazST9dvw9/MuAt66b5sRK1VXkaX
I2yPaSPpOSvLpHSMsp3L3twWykpvsm5oYdiUFg289RKafQSwESyxkol+AlPECvB0
zl8DoKmYVU/EGErL+N1csTVYB/7XDvXYktWAC60DqSsjVIY1PvO6F9uETPbBDqxI
WFD1piCOb5mZYUQE1Fb3hGaqIMwGlRSynxhN2vQfEwRb2o94nATO3JQeGg9HKrcV
T7wkSw1O3Qb8VSgXDMPAAVA4EJVKUPr1Gj6JIY4hxqaFtzUh/duqU8N4FBnjZK2F
pIMfHot9VWKBvtADAz/ioqnEHyTuhzAROiFysi//6vucbEqwIiTAZf9N8/LLF+ox
C+WI7Jon8Jk9KgXof+tvKO8ROY9rRxX09fA9cw+dmIkrcqoEzNjTCrYnPCo6OGv/
CenzT7BmYr4uURUik3hps/T6C8iQs0EG1O0uMTyzYKo3R5Z2yfCdTCFdep0qQKpp
CdwhvBp0CyJwMeSEDNfQfIL480Kq3XICxpqievii8Jn2w3xaI3KXEW9BsYDtLtck
x6eiThk+MRV7JsFY2fNe
=OLgV
-----END PGP SIGNATURE-----

--TI5JhQnQSt0kwJ89cghREPshaHHRBb9oV--
