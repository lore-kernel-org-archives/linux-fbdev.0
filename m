From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 05 Jan 2015 11:17:31 +0000
Subject: Re: [PATCH] simplefb: Fix build failure on Sparc
Message-Id: <54AA72CB.1020303@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="vTvWVt2awebnRcqIACkW39TkgaI2Q0sIX"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1420445716-13468-1-git-send-email-hdegoede@redhat.com>
In-Reply-To: <1420445716-13468-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org

--vTvWVt2awebnRcqIACkW39TkgaI2Q0sIX
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 05/01/15 10:15, Hans de Goede wrote:
> of_platform_device_create is only defined when CONFIG_OF_ADDRESS is set=
,
> which is normally always the case when CONFIG_OF is defined, except on =
Sparc,
> so explicitly check for CONFIG_OF_ADDRESS rather then for CONFIG_OF.
>=20
> Reported-by: kbuild test robot <fengguang.wu@intel.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/video/fbdev/simplefb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/video/fbdev/simplefb.c b/drivers/video/fbdev/simpl=
efb.c
> index 92cac80..1085c04 100644
> --- a/drivers/video/fbdev/simplefb.c
> +++ b/drivers/video/fbdev/simplefb.c
> @@ -402,7 +402,7 @@ static int __init simplefb_init(void)
>  	if (ret)
>  		return ret;
> =20
> -	if (IS_ENABLED(CONFIG_OF) && of_chosen) {
> +	if (IS_ENABLED(CONFIG_OF_ADDRESS) && of_chosen) {
>  		for_each_child_of_node(of_chosen, np) {
>  			if (of_device_is_compatible(np, "simple-framebuffer"))
>  				of_platform_device_create(np, NULL, NULL);
>=20

Doesn't this depend on the compiler optimizing the
of_platform_device_create call away? Isn't that rather dangerous assumpti=
on?

 Tomi



--vTvWVt2awebnRcqIACkW39TkgaI2Q0sIX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUqnLLAAoJEPo9qoy8lh718WsP/2rmMtL256X0HzeZte1SEZ9y
dqe1y0fzUo12tk4csUsup7ApXnqDn74ouF6Jqps4DqmxMfa03U2FmAQjim3Jelh6
6uo35SdsZbDymuVB7YgjEpzBBD09sKUZO0jXfttIRcPzaYGPqO0jom+vZkUk4h0a
u6z7tEm5/C8xkNiW5c1gGv+kh+dSVCNcFDUxqY9tom6fF4WrCzf3mxHzngpqbUhc
e0XwyukspCibHFPe6sV8nwgZTCD2ZF6P9fOqAjupaiV6TEirUlGxNInt7PYOZTyt
N3qU8IgYlK5hIzsfuHR89dCiWmRp/tsPVwg/zldUhoDcqccqPg4g7CyhyMXlGRx6
FQsURuX5xeLSUeyU9V/EGQuEZ6ahYarjBgRTONOuzut3yt57hVYkNfXc0tzFFVFF
5OIjb4Af6DujNn9zX3o8Dwjg9KnpuHL3jhUiogLkZ2jGdbhibeoWoWMN/CTltR3A
gsntJr4VAVJltZ/vuJrt1J2YxPx7RPu9L1J1yYIlAFOVuXp8rR6hYidGnHx8KU6a
+/8JridWyYbSv+boazTwyu5s9tlkO0PkB5OnHS4bx7lyeCyEV+HISjoaa/B6gzM/
aaLNFYR0QyeSmxpzMLtrt+uvG6LM6z5q4bZUxIi/VsCSbzW59JlHf4NK6wLqHAJE
zzGetdzPQxH12Jw9CAlC
=lJUW
-----END PGP SIGNATURE-----

--vTvWVt2awebnRcqIACkW39TkgaI2Q0sIX--
