From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 08 May 2014 10:31:59 +0000
Subject: Re: [PATCH v7][ 1/5] video: mx3fb: Use devm_kzalloc
Message-Id: <536B5D1F.1090507@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="RrxeLiUe28dnNkodg4D4TML8EXQOTJqD0"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1394788369-5096-1-git-send-email-denis@eukrea.com>
In-Reply-To: <1394788369-5096-1-git-send-email-denis@eukrea.com>
To: linux-arm-kernel@lists.infradead.org

--RrxeLiUe28dnNkodg4D4TML8EXQOTJqD0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 14/03/14 11:12, Denis Carikli wrote:
> Replace kzalloc by devm_kzalloc and remove the kfree() calls.
>=20
> Signed-off-by: Denis Carikli <denis@eukrea.com>
> ---
> ChangeLog v6->v7:
> - Removed the Cc from the patch, they went into=20
>   git send-email instead.
> ChangeLog v5->v6:
>  - New patch need
> ---
>  drivers/video/fbdev/mx3fb.c |    4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

I've picked this patch for 3.16. I didn't pick the DT related patches in
this series as there seemed to be unanswered questions about them.

 Tomi



--RrxeLiUe28dnNkodg4D4TML8EXQOTJqD0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTa10fAAoJEPo9qoy8lh71vHIP/3eZQDhS2lY9pxG3/8VOZj3f
k1HPyMdrrhDjA0zIIIaUT9dNuT/mTB7iN2op/hZLhvqal4HB6Irv+Cow4N9BjiKZ
6I9Txy5Q+mmAA2UNyNeXqKJUew2UjYAUWTjKvSy+FB9aigNEjrVX+J6dnz/sqbjl
5ppEXE55zc4FdsnJBY+p8CQV9jBvBDAEnsu9Twzo7AUaPJJt7ZnL5gmrIAc78M2c
TFF8TemQlVl6Zzp2tXyU+qTwZpZvVJEWmAfkNfE4buhYsFqyvGjliBOAH7g2jA9D
CTjs3a9O7gvw5vHqDIByfYm2gNHWwAvJ5Vz+RkOOgDkRcH+ZpiLvBfw1BpXtPlP4
n+YWO/20EpLDtvHEqU9kj3YlZEYalK9XPpCXie6lfVfqytTINOvxdRj31OYZvMZN
BqLQtKfmKAJcsvrGT1/l5Lz2W1adyFgv925KigONgROHfxuJ9gOaxdZlDX3Ttss+
C44dqfhOzqnFJlnFlyZJBNw7C38jC3ov0y1CxY2QBWoDyo5E6a1SfDazCKR9b5C7
nApDkehmSs+Ux9nYaI6y3PykpfywdkapY85//0AaWQM12Cu3y+oL9UPjIGg4iiYM
eiMn1CFCWFGgwB8Og1KzMm/olR6aGt6NVGk2H/I05d15Jg5c1nT7b9xo9qYUtMEN
u3qfnqrEzyQjqy/cTolk
=OwG/
-----END PGP SIGNATURE-----

--RrxeLiUe28dnNkodg4D4TML8EXQOTJqD0--
