From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 15 Jan 2015 12:39:01 +0000
Subject: Re: [patch] fbdev: off by one test (harmless)
Message-Id: <54B7B4E5.2070904@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="8djsHhgq4XS13cBAP3qu3Q80q8rrmIhBc"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20141226172657.GA14762@mwanda>
In-Reply-To: <20141226172657.GA14762@mwanda>
To: linux-fbdev@vger.kernel.org

--8djsHhgq4XS13cBAP3qu3Q80q8rrmIhBc
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 15/01/15 14:26, Dan Carpenter wrote:
> On Thu, Jan 15, 2015 at 01:56:58PM +0200, Tomi Valkeinen wrote:
>>
>> Here's a fix for the cea_array size. Does it silence the static checke=
r?
>>
>=20
> No.
>=20
>>  	for (i =3D specs->modedb_len + num; i < specs->modedb_len + num + sv=
d_n; i++) {
>>  		int idx =3D svd[i - specs->modedb_len - num];
>> -		if (!idx || idx > 63) {
>> +		if (!idx || idx > 64) {
>>  			pr_warning("Reserved SVD code %d\n", idx);
>>  		} else if (idx > ARRAY_SIZE(cea_modes) || !cea_modes[idx].xres) {
>>  			pr_warning("Unimplemented SVD code %d\n", idx);
>=20
> This static check ignores the value of "idx".
>=20
> It is only looking at "idx > ARRAY_SIZE(cea_modes)" which is off by one=

> and "idx" is used as an index in "!cea_modes[idx].xres".

Ah, right, I missed that in my patch. The check should obviously be
changed to:

if (idx >=3D ARRAY_SIZE(cea_modes)

But maybe it would be better to clean up the whole if statement to
remove the duplicate check. So in addition to increasing the cea_array si=
ze:

if (idx =3D=3D 0 || idx >=3D ARRAY_SIZE(cea_modes)) {
	pr_warning("Reserved SVD code %d\n", idx);
} else if (!cea_modes[idx].xres) {
	pr_warning("Unimplemented SVD code %d\n", idx);

 Tomi



--8djsHhgq4XS13cBAP3qu3Q80q8rrmIhBc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUt7TlAAoJEPo9qoy8lh71FioP/0zovYhNXoFcsL7pvJ1fpyEo
vINbRVM2850nltZbaoTftkcwWaYOJDIWSUtS1WTUYiFLLu42RIGhQDm+pp5wfWKc
w3XRVy2Ljp+DlaOcyA6qJUA18HsKEaYLsDP3bmaUSR4130XfPN/M3NNdHCHIR5Vj
o4anlpxaHlzK1DGEjDSWBPBg7IlyZEM9N6wH05Sbz9lETJWBlEVIwtU+tg7n7goK
i1ecKWKrWBJeQCiPjssCuIrC2/7TEjvpEWR9IOW0KDMV1RaBbhuHNhqxF97GE7Nd
wXaufc6c8j3lIrDHwL3LDQ0ONXYhf0knco4rTBdLzoPC3z3SDzktxBoZn5FichNK
XJP63F+M4wDputB9G2OCsO+TAOkms11JA0nAtGBQ6ziVuy7zLrvR/XrjN+DH8WNh
RJLVj4JmldKSccetxLzH6RvVG2Edku23TS3nYcKbGJPxYtefyCNnJKyrf2DnIej9
Ve7nK5hZSTYSaIMEYMlRatxaATDlx65zjPrHveWuTJidDk+90pwpS2QCcFrVV48b
eF67wUUL4HtNO5zplhusRAfEAT35GXqxhuUcZMyKjWKKVrapbWQyDmzK3Cj/t+h1
f+KNoz0zP3L8JfKsdQaVg1xAKE5hAyR3OQXlQL4+RNMIwijjIATR6zlOWKcQ+zzr
82wolIQ42XxngiIGER84
=+kwN
-----END PGP SIGNATURE-----

--8djsHhgq4XS13cBAP3qu3Q80q8rrmIhBc--
