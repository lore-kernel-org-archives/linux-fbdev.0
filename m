From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
Date: Mon, 28 Jun 2010 20:29:20 +0000
Subject: [PATCH 1/4] HID: picolcd: fix deferred_io init/cleanup to
Message-Id: <20100628222920.1127f8eb@neptune.home>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20100509184911.3f136b77@neptune.home>
	<AANLkTik0EkPYKdnhrpF7yK6eXIrHMsNYrzSC6tyeBR0P@mail.gmail.com>
	<20100510080047.5adade6f@pluto.restena.lu>
	<20100526215829.28a4aa47@neptune.home>
	<20100530130945.5c03797f@neptune.home>
	<20100623123225.4c16e653@neptune.home>
	<alpine.LNX.2.00.1006241053360.13809@pobox.suse.cz>
	<20100628222641.489c955a@neptune.home>
In-Reply-To: <20100628222641.489c955a@neptune.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Jiri Kosina <jkosina@suse.cz>
Cc: Jaya Kumar <jayakumar.lkml@gmail.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

We need to call fb_deferred_io_init() before we register_framebuffer()
as otherwise, in case fbcon uses our framebuffer, we will get a BUG()
because in picolcd_fb_imageblit() we schedule defio which has not
been initialized yet.

Note: this BUG() deadlocks ttys.

Signed-off-by: Bruno Pr=C3=A9mont <bonbons@linux-vserver.org>
---
 drivers/hid/hid-picolcd.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-picolcd.c b/drivers/hid/hid-picolcd.c
index 95253b3..883d720 100644
--- a/drivers/hid/hid-picolcd.c
+++ b/drivers/hid/hid-picolcd.c
@@ -707,18 +707,19 @@ static int picolcd_init_framebuffer(struct picolcd_da=
ta *data)
 		dev_err(dev, "failed to create sysfs attributes\n");
 		goto err_cleanup;
 	}
+	fb_deferred_io_init(info);
 	data->fb_info    =3D info;
 	error =3D register_framebuffer(info);
 	if (error) {
 		dev_err(dev, "failed to register framebuffer\n");
 		goto err_sysfs;
 	}
-	fb_deferred_io_init(info);
 	/* schedule first output of framebuffer */
 	schedule_delayed_work(&info->deferred_work, 0);
 	return 0;
=20
 err_sysfs:
+	fb_deferred_io_cleanup(info);
 	device_remove_file(dev, &dev_attr_fb_update_rate);
 err_cleanup:
 	data->fb_vbitmap =3D NULL;
@@ -747,7 +748,6 @@ static void picolcd_exit_framebuffer(struct picolcd_dat=
a *data)
 	data->fb_bpp     =3D 0;
 	data->fb_info    =3D NULL;
 	device_remove_file(&data->hdev->dev, &dev_attr_fb_update_rate);
-	fb_deferred_io_cleanup(info);
 	unregister_framebuffer(info);
 	vfree(fb_bitmap);
 	kfree(fb_vbitmap);
--=20
1.7.1

