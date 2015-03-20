From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 20 Mar 2015 11:15:37 +0000
Subject: Re: [PATCH] video: fbdev: sh_mobile_lcdcfb: Fix ROP3 sysfs attribute parsing
Message-Id: <550C0159.3030001@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="cMFfQkbB4Ci9VJkMEghRp8W2dcBdr3VPv"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1426347519-2541-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1426347519-2541-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-fbdev@vger.kernel.org

--cMFfQkbB4Ci9VJkMEghRp8W2dcBdr3VPv
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 18/03/15 00:27, Laurent Pinchart wrote:
> Hi Tomi,
>=20
> Could you please pick this patch up for v4.1 ? I can send a pull reques=
t if it=20
> makes your life easier.
>=20
> On Sunday 15 March 2015 10:32:11 Geert Uytterhoeven wrote:
>> On Sat, Mar 14, 2015 at 4:38 PM, Laurent Pinchart wrote:
>>> The ROP3 attribute is expressed as an integer in the 0-255 range. Rem=
ove
>>> the wrong conversion to boolean when parsing it.
>>>
>>> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
>>> Signed-off-by: Laurent Pinchart
>>> <laurent.pinchart+renesas@ideasonboard.com>
>>
>> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks, queued for 4.1.

 Tomi



--cMFfQkbB4Ci9VJkMEghRp8W2dcBdr3VPv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVDAFZAAoJEPo9qoy8lh71ee0P/0iYK3y2ua/dHk9ZaWR3zSor
e7DtGZZcLG6MvuPSdE7JhMEgkFiqzsp83Mo5kECuq3lPALpntgbOE0UzkPCVA4w5
dcPNw6ynpUdVzdL1g93sMBedXfEEgNRJvgGWoT2Xq5PmsY4vtzbFWk2iA3NUPaz7
DgAS1yNzj/92wTkktxRIhNgfVH9woSRVOxIcL3cL3xrKqf+/pMbJ1V1SlMeguXix
n3LUZ/gCWNUVFyHPaeqybWp/yY2WxmDGAFeB0kJFUKqiHTxH2+BzoesiaCWXxT8F
Wmv3wLwemGAT2F90fJci1P0w8GqxmOO+ogrjxSFxiME8ZVlzL9TC+PaifJnQDAw3
wt1165F/JrmhoGwGRymV9GzoweV3McDyAgcjh717impNd/U0v4F8nowH0vjOJh7c
5hzre74G9sbNeajDDm251onfF9J5HWjGm33Y049cmlo7buoLO2V5AgSy1wNQbdYl
PH2B/rZe8sh8W32rrBn2kyEpJ61wuzOZ4x/O7C9qHY6pIZOcAjq66AbDnAPASENS
ehIbrvs81dE1jdqXFriwHn93H6mjREb7/F4SWZXIrP/lrDe1cfT1kxjwE9yBd1IJ
SlP28JTNhgXndpx2yRULdxcAGcNS1k5/ttf0Ms7lF+Znnicr+Le9SXUfx0m557fR
2dvYgjgTKDeOSs0FN5pJ
=D3Go
-----END PGP SIGNATURE-----

--cMFfQkbB4Ci9VJkMEghRp8W2dcBdr3VPv--
