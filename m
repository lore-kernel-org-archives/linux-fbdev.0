From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
Date: Tue, 14 Aug 2012 06:30:44 +0000
Subject: Re: [PATCH 0/7] HID: picoLCD updates
Message-Id: <20120814083044.78b401d2@pluto.restena.lu>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20120730213656.0a9f6d30@neptune.home>
	<20120809200947.2194e89f@neptune.home>
	<20120813232708.GF25632@google.com>
In-Reply-To: <20120813232708.GF25632@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Tejun Heo <tj@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, linux-fbdev@vger.kernel.org

Hello Tejun,

[Tejun: sorry for duplicate, did hit "reply" instead of "reply to all"]

On Mon, 13 Aug 2012 16:27:08 Tejun Heo <tj@kernel.org> wrote:
> On Thu, Aug 09, 2012 at 08:09:47PM +0200, Bruno Pr=C3=A9mont wrote:
> > As you are working on workqueues and related code, could you have a look
> > at my usage of them in combination with db_defio?
> >=20
> > The delayed memory corruptions or system reboots after unbinding/unplug=
ging
> > the PicoLCD seem very much related to workqueue used to handle the defe=
rred
> > IO to framebuffer.
> >=20
> > I think things don't get cleaned-up as they should though I'm not sure
> > where the trouble lies.
> >=20
> > For ease of reading, I'm inlineing below the framebuffer related code of
> > PicoLCD (for complete driver after this patch series apply the whole se=
ries
> > on top of 3.5 https://lkml.org/lkml/2012/7/30/375 )
> ...
> > void picolcd_exit_framebuffer(struct picolcd_data *data)
> > {
> > 	struct fb_info *info =3D data->fb_info;
> > 	u8 *fb_vbitmap =3D data->fb_vbitmap;
> >=20
> > 	if (!info)
> > 		return;
> >=20
> > 	device_remove_file(&data->hdev->dev, &dev_attr_fb_update_rate);
> > 	info->par =3D NULL;
> > 	unregister_framebuffer(info);
> > 	data->fb_vbitmap =3D NULL;
> > 	data->fb_bitmap  =3D NULL;
> > 	data->fb_bpp     =3D 0;
> > 	data->fb_info    =3D NULL;
> > 	kfree(fb_vbitmap);
> > }
>=20
> I'm kinda shooting in the dark but who flushes / cancels
> fb_info->deferred_work?

fb_deferred_io_cleanup() does so and is called by destroy fbops
(when last reference to fb_info is returned):


static void picolcd_fb_destroy(struct fb_info *info)
{
	/* make sure no work is deferred */
	fb_deferred_io_cleanup(info);

	vfree((u8 *)info->fix.smem_start);
	framebuffer_release(info);
	printk(KERN_DEBUG "picolcd_fb_destroy(%p)\n", info);
}


=3D=3D=3D drivers/video/fb_defio.c =3D=3Dvoid fb_deferred_io_cleanup(struct=
 fb_info *info)
{
        struct fb_deferred_io *fbdefio =3D info->fbdefio;
        struct page *page;
        int i;

        BUG_ON(!fbdefio);
        cancel_delayed_work_sync(&info->deferred_work);

        /* clear out the mapping that we setup */
        for (i =3D 0 ; i < info->fix.smem_len; i +=3D PAGE_SIZE) {
                page =3D fb_deferred_io_page(info, i);
                page->mapping =3D NULL;
        }

        info->fbops->fb_mmap =3D NULL;
        mutex_destroy(&fbdefio->lock);
}



Thanks,
Bruno
