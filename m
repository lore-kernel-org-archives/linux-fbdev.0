From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 09 Sep 2014 11:04:56 +0000
Subject: Re: [PATCH] video: fbdev: use %*ph specifier to dump small buffers
Message-Id: <540EDED8.50102@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="9I3F5fmNwj6OJSvVkVO3B8f40a8IPPqtT"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1409928455-31086-1-git-send-email-andriy.shevchenko@linux.intel.com>
In-Reply-To: <1409928455-31086-1-git-send-email-andriy.shevchenko@linux.intel.com>
To: linux-fbdev@vger.kernel.org

--9I3F5fmNwj6OJSvVkVO3B8f40a8IPPqtT
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 05/09/14 17:47, Andy Shevchenko wrote:
> Instead of dereference each byte let's use %*ph specifier in the printk=
()
> calls.
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/video/fbdev/core/fbsysfs.c | 12 ++----------
>  drivers/video/fbdev/udlfb.c        |  7 ++-----
>  2 files changed, 4 insertions(+), 15 deletions(-)
>=20

Thanks, queued for 3.18.

 Tomi



--9I3F5fmNwj6OJSvVkVO3B8f40a8IPPqtT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUDt7YAAoJEPo9qoy8lh715PAP/Az+KKJkRqEg4Oq8GIb5idD1
bF4yqxVEBSzFrT7/kL/G6oqfVdylnfwtpj9CktZK9RXUl29DEemrj4usfRjce4Q+
HSc9YxrvTt4q8/GJHbu/n4BQ3QMcz0SfJDH1Me/ecA11k6QsyHj2++bi3j0AG1BS
DqONxgaqdnbpMqROGCBbroAPyvbAD0y6XU/O4qtTMlibFoR3p5kw6ItH96sUuUyO
/Nmu4yhK2WSzbSknAHGAfGmpdPOENBJyGYfq2dN+bUNjaFpoySFFWadPH8PMf4L+
2WYXR1lwEmW1KDHHCbLSgf5fQcvHoWxO5SneIGfvh/ouZLMRRP4RdT+ayJOAx5dV
3Ia5qrTNSQeCN9dpn7s7msyo+C1s6PegujBlqEjGvt6TEIY9MUGQdKJ94PKpagKs
dxA1vzPQBw43EbhlRUQXwaPy7xx52cJBOeFAEhkH0Ztjq4rGGP+w9DrSG0CnrLOm
Q8ZvZAhwgVZWgDieWuEmEUG5oVajO8wAn3YQxXhV+6aBmR+LBEPVzVCyDxhQx4Jp
PcxG2i5VChqB00Ot8yNnYQYgw/mGpSOU4s0rBhb7n4a0MUSw3gd2Zyvu5CF6dDsc
U3QPxJ9zIsq4k9E2BMpU2OEmF0FJ9tqGOarq0m8FjnZP4bPrhELzLcYFcmZn4ZXH
MkzqJzddQ1krSrPm+hBE
=vg+y
-----END PGP SIGNATURE-----

--9I3F5fmNwj6OJSvVkVO3B8f40a8IPPqtT--
