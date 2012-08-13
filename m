From: Tejun Heo <tj@kernel.org>
Date: Mon, 13 Aug 2012 23:27:08 +0000
Subject: Re: [PATCH 0/7] HID: picoLCD updates
Message-Id: <20120813232708.GF25632@google.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20120730213656.0a9f6d30@neptune.home>
 <20120809200947.2194e89f@neptune.home>
In-Reply-To: <20120809200947.2194e89f@neptune.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Bruno =?iso-8859-1?Q?Pr=E9mont?= <bonbons@linux-vserver.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, linux-fbdev@vger.kernel.org

Hello,

On Thu, Aug 09, 2012 at 08:09:47PM +0200, Bruno Pr=E9mont wrote:
> As you are working on workqueues and related code, could you have a look
> at my usage of them in combination with db_defio?
>=20
> The delayed memory corruptions or system reboots after unbinding/unpluggi=
ng
> the PicoLCD seem very much related to workqueue used to handle the deferr=
ed
> IO to framebuffer.
>=20
> I think things don't get cleaned-up as they should though I'm not sure
> where the trouble lies.
>=20
> For ease of reading, I'm inlineing below the framebuffer related code of
> PicoLCD (for complete driver after this patch series apply the whole seri=
es
> on top of 3.5 https://lkml.org/lkml/2012/7/30/375 )
...
> void picolcd_exit_framebuffer(struct picolcd_data *data)
> {
> 	struct fb_info *info =3D data->fb_info;
> 	u8 *fb_vbitmap =3D data->fb_vbitmap;
>=20
> 	if (!info)
> 		return;
>=20
> 	device_remove_file(&data->hdev->dev, &dev_attr_fb_update_rate);
> 	info->par =3D NULL;
> 	unregister_framebuffer(info);
> 	data->fb_vbitmap =3D NULL;
> 	data->fb_bitmap  =3D NULL;
> 	data->fb_bpp     =3D 0;
> 	data->fb_info    =3D NULL;
> 	kfree(fb_vbitmap);
> }

I'm kinda shooting in the dark but who flushes / cancels
fb_info->deferred_work?

Thanks.

--=20
tejun
