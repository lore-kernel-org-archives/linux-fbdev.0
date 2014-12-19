From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 19 Dec 2014 11:59:41 +0000
Subject: Re: msync on fbdev
Message-Id: <5494132D.50204@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="KETsAPm2w4AAXm2iJkubaQjv14awmSgFu"
List-Id: <linux-fbdev.vger.kernel.org>
References: <CABMKUD9mtus77hdfPA5mAtwc8MCpyJQ-kvvvyVmKQuw2Tuo9mA@mail.gmail.com>
In-Reply-To: <CABMKUD9mtus77hdfPA5mAtwc8MCpyJQ-kvvvyVmKQuw2Tuo9mA@mail.gmail.com>
To: linux-fbdev@vger.kernel.org

--KETsAPm2w4AAXm2iJkubaQjv14awmSgFu
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 18/12/14 15:55, Martin Jackson wrote:
> Dear fbdev developers,
>=20
> This relates to the core implementation of fbdev with the
> CONFIG_FB_DEFERRED_IO option enabled.
>=20
> I believe I have found a bug when doing msync(2) on a framebuffer
> device. We are using an old (2.6.37) kernel on an embedded plaform,
> but if I look at the current torvalds kernel (fbdev kernel looks
> rather old!?), the bug seems to still be there.
>=20
> When looking at the msync(2) man page, msync is meant to return 0 on
> success and -1 on failure, however we are seeing it return 1, which is
> undocumented and in my opinion wrong.
>=20
> This is because the fb_deferred_io_fsync method returns the code from
> 'schedule_delayed_work', which is either 0 or 1 depending on whether
> the work was already scheduled, leading to the possibility that msync
> returns the value 1 to userland.

Indeed, looks broken. schedule_delayed_work() never returns an error, it
just returns a bool telling if the work was already scheduled.

I guess no one really uses deferred io much =3D).

Here's a patch:

=46rom 9cc80b3cf9d6023ede084d024ed8b5c0cb247bc2 Mon Sep 17 00:00:00 2001
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 19 Dec 2014 13:55:41 +0200
Subject: [PATCH] video/fbdev: fix defio's fsync

fb_deferred_io_fsync() returns the value of schedule_delayed_work() as
an error code, but schedule_delayed_work() does not return an error. It
returns true/false depending on whether the work was already queued.

Fix this by ignoring the return value of schedule_delayed_work().

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/fbdev/core/fb_defio.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/core/fb_defio.c
b/drivers/video/fbdev/core/fb_defio.c
index 900aa4ecd617..d6cab1fd9a47 100644
--- a/drivers/video/fbdev/core/fb_defio.c
+++ b/drivers/video/fbdev/core/fb_defio.c
@@ -83,9 +83,10 @@ int fb_deferred_io_fsync(struct file *file, loff_t
start, loff_t end, int datasy
 	cancel_delayed_work_sync(&info->deferred_work);

 	/* Run it immediately */
-	err =3D schedule_delayed_work(&info->deferred_work, 0);
+	schedule_delayed_work(&info->deferred_work, 0);
 	mutex_unlock(&inode->i_mutex);
-	return err;
+
+	return 0;
 }
 EXPORT_SYMBOL_GPL(fb_deferred_io_fsync);

--=20
2.2.0



--KETsAPm2w4AAXm2iJkubaQjv14awmSgFu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUlBMtAAoJEPo9qoy8lh71pIQP/01u7Nl3cP3M1kfJmejH2/eK
r8dmVrRO6Xo8ieeAQ+d47cbsfxyEt3bRQSelgpEE2TcNdtNVod/n/CygFPAx/vuX
3wfhYijI98Rfg0mFL3oxQiFkkBhRGUlt/k3uw2G492mZdXIv2AmweH8uDtf9LLvm
iR37e+HhWZHg4t9uH8EKfeg/MMdU85NHRicmorRmSO5zLAl5/3WHsFCssPsfOvB/
+85AyCV3G5YLx8qsMcROeV/TTw/pNqo3dkTXYfrpDHWwerO1F6+txKLM1IjYng3l
1PryniN9ivwVVtCpG/UXCaIQRDf+97+n4HsYU5H1w6FtN7cFe9hnaYZ/5BDdl10c
Diw0MP0zrUva++ysHTpoFHC8E4MNw2/9jDRWAEWbM+A5ISYubcES+GmMq5S5i83P
KgfAxEkK6Sp15Cn6o6kaUs3rHR1GztDRE2vEENVda65O+ThvHgyIywwfnFGKQCCg
YlSb/Ta54NNujuVQoX6gXEeYZa1GB21f2tHjGJ7yr3An/CTy6WV+xvgsxbHr8l+f
2SaA8ZHGgEeOP6RxGWx7CmgoipdrqyI7Idpo4Vy0RkI1ygKWJ6eSixfpnYp1jUGu
8FLEdIUOwz2M7vekosZ1tF9Uq5Fn8Z5+oIjFDBROM1m7x1Ow/5tF2pI4+FZDZusU
b7XgQKu9AiUhk5N+QU47
=sOqQ
-----END PGP SIGNATURE-----

--KETsAPm2w4AAXm2iJkubaQjv14awmSgFu--
