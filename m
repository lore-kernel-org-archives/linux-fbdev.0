From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 26 Feb 2016 11:21:33 +0000
Subject: Re: [PATCH] fbcon: set a default value to blink interval
Message-Id: <56D0353D.3090304@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="xFGqFkswQ0s3E7iwDiLKF00ALgNceVVMm"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1455561693-28615-1-git-send-email-jean-philippe.brucker@arm.com>
In-Reply-To: <1455561693-28615-1-git-send-email-jean-philippe.brucker@arm.com>
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, linux-fbdev@vger.kernel.org
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Scot Doyle <lkml14@scotdoyle.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Pavel Machek <pavel@ucw.cz>, Thierry Reding <treding@nvidia.com>, stable@vger.kernel.org

--xFGqFkswQ0s3E7iwDiLKF00ALgNceVVMm
Content-Type: multipart/mixed; boundary="unmlHq0vVLJ0845ONKcAX5l4paeGRBr8g"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
 linux-fbdev@vger.kernel.org
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
 Scot Doyle <lkml14@scotdoyle.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Pavel Machek
 <pavel@ucw.cz>, Thierry Reding <treding@nvidia.com>, stable@vger.kernel.org
Message-ID: <56D0353D.3090304@ti.com>
Subject: Re: [PATCH] fbcon: set a default value to blink interval
References: <1455561693-28615-1-git-send-email-jean-philippe.brucker@arm.com>
In-Reply-To: <1455561693-28615-1-git-send-email-jean-philippe.brucker@arm.com>

--unmlHq0vVLJ0845ONKcAX5l4paeGRBr8g
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


On 15/02/16 20:41, Jean-Philippe Brucker wrote:
> Since commit 27a4c827c34ac4256a190cc9d24607f953c1c459
> 	fbcon: use the cursor blink interval provided by vt
>=20
> two attempts have been made at fixing a possible hang caused by
> cursor_timer_handler. That function registers a timer to be triggered a=
t
> "jiffies + fbcon_ops.cur_blink_jiffies".
>=20
> A new case had been encountered during initialisation of clcd-pl11x:
>=20
>     fbcon_fb_registered
>     do_fbcon_takeover
>=20
>     ->  do_register_con_driver
>         fbcon_startup
>     (A) add_cursor_timer (with cur_blink_jiffies =3D 0)
>=20
>     ->  do_bind_con_driver
>         visual_init
>         fbcon_init
>     (B) cur_blink_jiffies =3D msecs_to_jiffies(vc->vc_cur_blink_ms);
>=20
> If we take an softirq anywhere between A and B (and we do),
> cursor_timer_handler executes indefinitely.
>=20
> Instead of patching all possible paths that lead to this case one at a
> time, fix the issue at the source and initialise cur_blink_jiffies to
> 200ms when allocating fbcon_ops. This was its default value before
> aforesaid commit. fbcon_cursor or fbcon_init will refine this value
> downstream.
>=20
> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> Cc: <stable@vger.kernel.org> # v4.2
> ---
>  drivers/video/console/fbcon.c |    2 ++
>  1 file changed, 2 insertions(+)

Thanks, queued for 4.5 fixes.

 Tomi


--unmlHq0vVLJ0845ONKcAX5l4paeGRBr8g--

--xFGqFkswQ0s3E7iwDiLKF00ALgNceVVMm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW0DU9AAoJEPo9qoy8lh71cRAP/1x+kpDwh8pIlGXEbMwgmcHs
hfL0zMf3oY6cylEN8EspBb/MU0PS/esobtOBEzB+IE9r3qiA2QTImj+NtDVqJyAK
RUyjWlSDwxNaRbha5Iw9BukJb8pOfgT8Yg/fevG/i2tQSeAypQNoKq71V+nZdje1
rzGDCj2dgkSdt08EmguCLVCfLCU/7l1YFONv5oCBlqenTt28E/Yw87t6SMFaki2p
Lu1rGPpS/jPGvkNArmLZyytC2hsqFv+aqYDOsjmr8Msu9W6DghPUj1BlmBssa/Jp
7m7gJqKlqZBnDiFmDzlFECd41VADFTYRlRtjbe9TQgY8/FwTewAXGrMRrAJcK0in
eLqiBpgaH3DCQqoyY31k+op6OHXYQEt1aeV+/nZaV53Us9G5VzroEXXG1spZolmC
GI3eVJyW7RVlWUNqg7ORdL+/BmW7iR8CQ6ifPSWxvMvG0l1G/a4VfPHiMQQ0J6Ro
5RF4d7peu6NcSwA4wIamNWOmbBjh2wSSj5MVGrcNmDMoFx5tHCn/OG+gD6XTEl+v
PCpnk/6Nt+ml0BWsm6jFSjsuq5Qv6fSOOl8T+E6AoijTAV4RYxkugRf4hndslkwT
GBRL3UgBc0AHPKuVBcWrKuEkYIhLAZQ5Y2s5vEPDuIitr/HT99eW3QBrBmWUjc8S
nG+TqtU3WjFU8WCIclCp
=vMA7
-----END PGP SIGNATURE-----

--xFGqFkswQ0s3E7iwDiLKF00ALgNceVVMm--
