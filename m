From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 23 Nov 2016 07:30:09 +0000
Subject: Re: [PATCHv0 1/1] fbdev: add Intel FPGA FRAME BUFFER driver
Message-Id: <b38e19f1-0be9-37ea-94cd-d37d8b8aa7f3@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="RiaiO3avIDPpgDtLHTOeP0299JGmbgVtI"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1479287278-5192-1-git-send-email-hean.loong.ong@intel.com>
In-Reply-To: <1479287278-5192-1-git-send-email-hean.loong.ong-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
To: "Ong, Hean Loong" <hean.loong.ong-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

--RiaiO3avIDPpgDtLHTOeP0299JGmbgVtI
Content-Type: multipart/mixed; boundary="k6gLrQw114FfpIok4CKoETFAXWb5C8mNd";
 protected-headers="v1"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: "Ong, Hean Loong" <hean.loong.ong@intel.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fbdev@vger.kernel.org
Message-ID: <b38e19f1-0be9-37ea-94cd-d37d8b8aa7f3@ti.com>
Subject: Re: [PATCHv0 1/1] fbdev: add Intel FPGA FRAME BUFFER driver
References: <1479287278-5192-1-git-send-email-hean.loong.ong@intel.com>
In-Reply-To: <1479287278-5192-1-git-send-email-hean.loong.ong@intel.com>

--k6gLrQw114FfpIok4CKoETFAXWb5C8mNd
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

On 16/11/16 11:07, Ong, Hean Loong wrote:
> From: Ong Hean Loong <hean.loong.ong@intel.com>
>=20
> 	This patch enables the display port IP driver for
> 	Intel Arria 10 SOCFPGA Golden Hardware
> 	Reference Design (GHRD).
>=20
> 	The driver requires enabling the options such as
> 	Coheherent Memory Allocation,
> 	Intel FPGA Frame Buffer, Frame Buffer Conasole
>=20
> Signed-off-by: Ong Hean Loong <hean.loong.ong@intel.com>
> ---
>  .../devicetree/bindings/video/intelfpgavipfb.txt   |   22 ++
>  MAINTAINERS                                        |    6 +
>  drivers/video/fbdev/Kconfig                        |   15 +
>  drivers/video/fbdev/Makefile                       |    1 +
>  drivers/video/fbdev/intelfpgavipfb.c               |  302 ++++++++++++=
++++++++
>  5 files changed, 346 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/video/intelfpgavi=
pfb.txt
>  create mode 100644 drivers/video/fbdev/intelfpgavipfb.c

As mentioned by Rob and Alan, no new fbdev drivers please. Write a DRM
driver for this.

 Tomi


--k6gLrQw114FfpIok4CKoETFAXWb5C8mNd--

--RiaiO3avIDPpgDtLHTOeP0299JGmbgVtI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYNUWBAAoJEPo9qoy8lh71K6EP/RlD1wk8wfHdLftwMDToIAs7
qEVRIYPsIrMo3vnuFUxAYt1YgqcCo4dmQewe7e4VLcnIOO3dX+W5hSWbz491rEDq
ljnS6+uWhyC/QcPVssC7BXTjUQFn92ZON01p1OMplCo6GclKGyHs6nQXp5a3cM2h
8NazCzpdvco+koKDwf700CUV/QLNKQ8KiIahc4zYgwqA87T92+gAEO7lumt1aF2F
bfrApMLRmdAWsIWUxaaBwj9GjNBPyGUty+0RlWEjYUlS1Y6otQRjih3J7NlGcvUF
O2+Js4BFBgX994dTeGuQ0dNeuwNUBlyUV4YDcbDV/rdDYLPlH23ihcS+lAdqfssQ
feErwDwNd78qgo4GeA9UCIAzXmCBCdqL0dlMqFXtWIk3eEf0NvUfQFKVvANcSMur
fFEvSmzTWyY6rkaBfjiNlxCHZW3/NnC4ZosmU+Vm9lPDAHkpYY8ZquYYEwGsqUTH
dL9PlWjSCu+fyIObL7KYg8L3vex+RwinLV34jMfXQUgIDAeSTIR0CGU7qWg/F4G6
H5xgkyywO+iLBF1l0KAWSxiOnJm4H62OrbPYYOCns6vH4B0paQHa6h0kKqq6vN5B
U60pdATAXOiOiqgJ6uxSOr8JsFMD65UeL3vuuVjJrw+DfiKYUcHlssocvqem/k62
kWcXl9PMd/dR/ZFvNHak
=CCCx
-----END PGP SIGNATURE-----

--RiaiO3avIDPpgDtLHTOeP0299JGmbgVtI--
