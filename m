From: Thierry Reding <thierry.reding@gmail.com>
Date: Wed, 27 May 2015 12:39:40 +0000
Subject: Re: [PATCH] fbcon: Avoid deleting a timer in IRQ context
Message-Id: <20150527123938.GA11999@ulmo.nvidia.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="bg08WKrSYDhXBjb5"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1432195083-25005-1-git-send-email-thierry.reding@gmail.com>
In-Reply-To: <1432195083-25005-1-git-send-email-thierry.reding@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Kevin Hilman <khilman@kernel.org>, Scot Doyle <lkml14@scotdoyle.com>, Daniel Stone <daniel@fooishbar.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org


--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2015 at 09:58:03AM +0200, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
>=20
> Commit 27a4c827c34a ("fbcon: use the cursor blink interval provided by
> vt") unconditionally removes the cursor blink timer. Unfortunately that
> wreaks havoc under some circumstances. An easily reproducible way is to
> use both the framebuffer console and a debug serial port as the console
> output for kernel messages (e.g. "console=3DttyS0 console=3Dtty1" on the
> kernel command-line. Upon boot this triggers a warning from within the
> del_timer_sync() function because it is called from IRQ context:
>=20
> 	[    5.070096] ------------[ cut here ]------------
> 	[    5.070110] WARNING: CPU: 0 PID: 0 at ../kernel/time/timer.c:1098 del=
_timer_sync+0x4c/0x54()
> 	[    5.070115] Modules linked in:
> 	[    5.070120] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.1.0-rc4-next-=
20150519 #1
> 	[    5.070123] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
> 	[    5.070142] [] (unwind_backtrace) from [] (show_stack+0x10/0x14)
> 	[    5.070156] [] (show_stack) from [] (dump_stack+0x70/0xbc)
> 	[    5.070164] [] (dump_stack) from [] (warn_slowpath_common+0x74/0xb0)
> 	[    5.070169] [] (warn_slowpath_common) from [] (warn_slowpath_null+0x1=
c/0x24)
> 	[    5.070174] [] (warn_slowpath_null) from [] (del_timer_sync+0x4c/0x54)
> 	[    5.070183] [] (del_timer_sync) from [] (fbcon_del_cursor_timer+0x2c/=
0x40)
> 	[    5.070190] [] (fbcon_del_cursor_timer) from [] (fbcon_cursor+0x9c/0x=
180)
> 	[    5.070198] [] (fbcon_cursor) from [] (hide_cursor+0x30/0x98)
> 	[    5.070204] [] (hide_cursor) from [] (vt_console_print+0x2a8/0x340)
> 	[    5.070212] [] (vt_console_print) from [] (call_console_drivers.const=
prop.23+0xc8/0xec)
> 	[    5.070218] [] (call_console_drivers.constprop.23) from [] (console_u=
nlock+0x498/0x4f0)
> 	[    5.070223] [] (console_unlock) from [] (vprintk_emit+0x1f0/0x508)
> 	[    5.070228] [] (vprintk_emit) from [] (vprintk_default+0x24/0x2c)
> 	[    5.070234] [] (vprintk_default) from [] (printk+0x70/0x88)
>=20
> After which the system starts spewing all kinds of weird and seemingly
> unrelated error messages.
>=20
> This commit fixes this by restoring the condition under which the call
> to fbcon_del_cursor_timer() happens.
>=20
> Reported-by: Daniel Stone <daniel@fooishbar.org>
> Reported-by: Kevin Hilman <khilman@kernel.org>
> Tested-by: Kevin Hilman <khilman@linaro.org>
> Tested-by: Scot Doyle <lkml14@scotdoyle.com>
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  drivers/video/console/fbcon.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Ping? This is an important fix, can we get this into linux-next sometime
soon?

Thierry

>=20
> diff --git a/drivers/video/console/fbcon.c b/drivers/video/console/fbcon.c
> index 05b1d1a71ef9..658c34bb9076 100644
> --- a/drivers/video/console/fbcon.c
> +++ b/drivers/video/console/fbcon.c
> @@ -1310,8 +1310,9 @@ static void fbcon_cursor(struct vc_data *vc, int mo=
de)
>  		return;
> =20
>  	ops->cur_blink_jiffies =3D msecs_to_jiffies(vc->vc_cur_blink_ms);
> -	fbcon_del_cursor_timer(info);
> -	if (!(vc->vc_cursor_type & 0x10))
> +	if (vc->vc_cursor_type & 0x10)
> +		fbcon_del_cursor_timer(info);
> +	else
>  		fbcon_add_cursor_timer(info);
> =20
>  	ops->cursor_flash =3D (mode =3D=3D CM_ERASE) ? 0 : 1;
> --=20
> 2.4.1
>=20

--bg08WKrSYDhXBjb5
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJVZbsDAAoJEN0jrNd/PrOhuioP/10TJHbBvKNVHYzePa2Wb1oP
G0LXQGjlmnj1gJim3LnQ7bpXEG3YFXrbUkzHFfBXh3zZ5aMzeGyZDJQ1W3jsSI1M
+HlvwxPUn2eb00+DxyzVxSLx7WixFmQAL76Pw06QBEbdH/JT1ewqEdl8NsPEK0Gm
hflZ/aDnq2w7oWQ/DXXIjQ2PIosTccy9LMM5lYpsxnLkmvxxvQBmaxg9iU49/Y5g
cKM/BUeBV0iQAmAW8hO5ar/elEDY33DKY0s/y0Zo3n5DaGWwdvRx4wcuJryyGgES
tBPymj13Bx23Ox3GWLqNb1t44mmZL6zX29JqsVHaJnefDq+SkSypF8f2JccTrNxl
DwL+M0V7KeQeQAVSfuJPM76H1joFX0bgnVdFcCqxLycVvjwcMhL9/ewBe+wKoz59
W51ZmMKlLpIjdYnNtJLk0uQ6uSSHGDHNd+zfgKw5Qkh8y5x89KEF+pcElyVVzXB9
R3zSNpPl3r8UpZCRbvOo9mkBP222kZq2CuWqa/iwJhzF+Sj3P4jrs36tNJkHw2Zl
gf8/0XhpnKRNaMRFNsg5lNvnNikgEmnC0saR6oFxdKiR34bdJSHjEn0SuMn5Y3Qe
hHPfWHstQDuGZtFBIahAralv8LfDhdkTBGbrtuJI+js7APVbLr7s0VR2z7/mZ6xV
45bjZgb5Ijbd4qrlVdfE
=LY63
-----END PGP SIGNATURE-----

--bg08WKrSYDhXBjb5--
