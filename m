From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 20 Feb 2015 12:04:38 +0000
Subject: Re: [PATCH v6 2/2] fbcon: expose cursor blink interval via sysfs
Message-Id: <54E722D6.9010900@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="NNlQtaevX9MBKUBeob3X91p4lWOWe7GV9"
List-Id: <linux-fbdev.vger.kernel.org>
References: <alpine.DEB.2.11.1501300836140.2305@localhost.localdomain> <alpine.DEB.2.11.1501300843200.2423@localhost.localdomain> <alpine.DEB.2.11.1501300932470.2288@localhost.localdomain> <alpine.DEB.2.11.1501300938070.2359@localhost.localdomain>
In-Reply-To: <alpine.DEB.2.11.1501300938070.2359@localhost.localdomain>
To: Scot Doyle <lkml14@scotdoyle.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Richard Weinberger <richard.weinberger@gmail.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

--NNlQtaevX9MBKUBeob3X91p4lWOWe7GV9
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 30/01/15 11:40, Scot Doyle wrote:
> fbcon toggles cursor display state every 200 milliseconds when blinking=
=2E
> Since users prefer different toggle intervals, expose the interval via
> /sys/class/graphics/fbcon/cursor_blink_ms so that it may be customized.=

>=20
> Values written to the interface set the approximate time interval in
> milliseconds between cursor toggles, from 1 to 32767. Since the interva=
l
> is stored internally as a number of jiffies, the millisecond value read=

> from the interface may not exactly match the entered value.
>=20
> An outstanding blink timer is reset after a new value is entered.
>=20
> If the cursor blink is disabled, either via the 'cursor_blink' boolean
> setting or some other mechanism, the 'cursor_blink_ms' setting may stil=
l
> be modified. The new value will be used if the blink is reactivated.
>=20
> Signed-off-by: Scot Doyle <lkml14@scotdoyle.com>
> ---
>  drivers/video/console/fbcon.c | 65 +++++++++++++++++++++++++++++++++++=
++++++++
>  1 file changed, 65 insertions(+)
>=20
> diff --git a/drivers/video/console/fbcon.c b/drivers/video/console/fbco=
n.c
> index 7a2030b..7baa333 100644
> --- a/drivers/video/console/fbcon.c
> +++ b/drivers/video/console/fbcon.c
> @@ -3495,11 +3495,76 @@ err:
>  	return count;
>  }
> =20
> +static ssize_t show_cursor_blink_ms(struct device *device,
> +				    struct device_attribute *attr, char *buf)
> +{
> +	struct fbcon_ops *ops;
> +	int idx, ms =3D -1;
> +
> +	if (fbcon_has_exited)
> +		return -ENODEV;
> +
> +	console_lock();
> +	idx =3D con2fb_map[fg_console];
> +
> +	if (idx !=3D -1 && registered_fb[idx] !=3D NULL) {
> +		ops =3D ((struct fb_info *)registered_fb[idx])->fbcon_par;

I don't think the above typecast is needed. I can remove the typecast
when applying to my tree.

So queuing for 3.21. Thanks!

 Tomi



--NNlQtaevX9MBKUBeob3X91p4lWOWe7GV9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU5yLWAAoJEPo9qoy8lh71+iMP/iqdMO158C0m42EmS/4EP11/
WRPx79Bdb19uTQRt4FSdegGOtQ8oI6LBWyIzcpflyTde5+5UxvXu/kAYWUE7sMWm
9bCUT285HmIpbasNwyGpogfdXJ2uxbCcRR5MeAPq7kupERP4EaKqBC/BqzQr9hhg
P70zgtK6k/EbJ5KqZp/5uimjp1DiP5wnKfVd10xjOGUM2prgcifY4RzedVNx7A+j
QVsw9Ueao1T9QK/6EEoz7PYmHLKwd3MMrwx1bMLRyhjAeUQrKmxWZeBr1FPJDlt+
XATG1eSjirsxxl1gCWCDBqVglDv8Kt6MWdsTfKKHFmtgLvypUszVjAAqKJODrZDV
gtXGbn9wJE94c9o3Q7+7hs9sq9cPOfRjSINbu0VVa+fKXzoDFfeoME2LrEVbqi4J
ySXR+YJ9SYwGB2VbK/h/bFm6EOgMtzTySwO1Ppzq9YNNtKLbupY3NCL4tS9xRp8I
DX9wg4zF+DIUjPdNaKoYVcHZcaWUAX9K/NA/ofYTjth2BT+2Uul2Odc933Za+Vud
sB/tCgxjKYpBGwqAJnP2rmKSav5TW08vRTw31JVjbxEZ8EWHiDwNingVcZ5j0KJX
uli3UefKOdobNMy5h76rDa1uG7lFrzG38zbqD3VFUmE8/snEyHwnH9KKqFyrCysc
ByJHgfN6jA6JSjSvtGnK
=X7Tc
-----END PGP SIGNATURE-----

--NNlQtaevX9MBKUBeob3X91p4lWOWe7GV9--
