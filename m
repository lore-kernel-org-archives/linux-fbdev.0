From: Jaya Kumar <jayakumar.lkml@gmail.com>
Date: Wed, 30 Jun 2010 01:52:13 +0000
Subject: Re: [PATCH 1/4] HID: picolcd: fix deferred_io init/cleanup to
Message-Id: <AANLkTingjmM4OmkdXl9IOUe5zsj0QxTdix1h34pVHWGl@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20100509184911.3f136b77@neptune.home>
	<AANLkTik0EkPYKdnhrpF7yK6eXIrHMsNYrzSC6tyeBR0P@mail.gmail.com>
	<20100510080047.5adade6f@pluto.restena.lu>
	<20100526215829.28a4aa47@neptune.home>
	<20100530130945.5c03797f@neptune.home>
	<20100623123225.4c16e653@neptune.home>
	<alpine.LNX.2.00.1006241053360.13809@pobox.suse.cz>
	<20100628222641.489c955a@neptune.home>
	<20100628222920.1127f8eb@neptune.home>
In-Reply-To: <20100628222920.1127f8eb@neptune.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: =?ISO-8859-1?Q?Bruno_Pr=E9mont?= <bonbons@linux-vserver.org>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Jun 29, 2010 at 4:29 AM, Bruno Pr=E9mont
<bonbons@linux-vserver.org> wrote:
> We need to call fb_deferred_io_init() before we register_framebuffer()
> as otherwise, in case fbcon uses our framebuffer, we will get a BUG()
> because in picolcd_fb_imageblit() we schedule defio which has not
> been initialized yet.

Hi Bruno,

The comment above seems confusing to me in that it talks about fbcon
and defio schedule.

What I see is that you originally had in picolcd:

>        error =3D register_framebuffer(info);
...
>        fb_deferred_io_init(info);

which was a bug because it called register_framebuffer (ie: made the
framebuffer available for use) and only then initialized the defio
handlers which were needed for that framebuffer memory to be used.
Drivers must always call defio_init _before_ register_framebuffer. The
bug fix to picolcd below looks correct because it now does that
sequence in the correct order.

Thanks,
jaya



>
> Note: this BUG() deadlocks ttys.
>
> Signed-off-by: Bruno Pr=E9mont <bonbons@linux-vserver.org>
> ---
> =A0drivers/hid/hid-picolcd.c | =A0 =A04 ++--
> =A01 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/hid/hid-picolcd.c b/drivers/hid/hid-picolcd.c
> index 95253b3..883d720 100644
> --- a/drivers/hid/hid-picolcd.c
> +++ b/drivers/hid/hid-picolcd.c
> @@ -707,18 +707,19 @@ static int picolcd_init_framebuffer(struct picolcd_=
data *data)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(dev, "failed to create sysfs attri=
butes\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto err_cleanup;
> =A0 =A0 =A0 =A0}
> + =A0 =A0 =A0 fb_deferred_io_init(info);
> =A0 =A0 =A0 =A0data->fb_info =A0 =A0=3D info;
> =A0 =A0 =A0 =A0error =3D register_framebuffer(info);
> =A0 =A0 =A0 =A0if (error) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(dev, "failed to register framebuff=
er\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto err_sysfs;
> =A0 =A0 =A0 =A0}
> - =A0 =A0 =A0 fb_deferred_io_init(info);
> =A0 =A0 =A0 =A0/* schedule first output of framebuffer */
> =A0 =A0 =A0 =A0schedule_delayed_work(&info->deferred_work, 0);
> =A0 =A0 =A0 =A0return 0;
>
> =A0err_sysfs:
> + =A0 =A0 =A0 fb_deferred_io_cleanup(info);
> =A0 =A0 =A0 =A0device_remove_file(dev, &dev_attr_fb_update_rate);
> =A0err_cleanup:
> =A0 =A0 =A0 =A0data->fb_vbitmap =3D NULL;
> @@ -747,7 +748,6 @@ static void picolcd_exit_framebuffer(struct picolcd_d=
ata *data)
> =A0 =A0 =A0 =A0data->fb_bpp =A0 =A0 =3D 0;
> =A0 =A0 =A0 =A0data->fb_info =A0 =A0=3D NULL;
> =A0 =A0 =A0 =A0device_remove_file(&data->hdev->dev, &dev_attr_fb_update_r=
ate);
> - =A0 =A0 =A0 fb_deferred_io_cleanup(info);
> =A0 =A0 =A0 =A0unregister_framebuffer(info);
> =A0 =A0 =A0 =A0vfree(fb_bitmap);
> =A0 =A0 =A0 =A0kfree(fb_vbitmap);
> --
> 1.7.1
>
>
