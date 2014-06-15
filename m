From: Stefan Biereigel <security@biereigel-wb.de>
Date: Sun, 15 Jun 2014 07:47:50 +0000
Subject: Re: console / fbdev: fbcon support for bits_per_pixel = 1?
Message-Id: <539D4FA6.9060003@biereigel-wb.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <539C1C1F.5060904@biereigel.de> <20140614143550.59367463@neptune.home>
In-Reply-To: <20140614143550.59367463@neptune.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: =?ISO-8859-1?Q?Bruno_Pr=E9mont?= <bonbons@linux-vserver.org>, Stefan Biereigel <stefan@biereigel.de>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-console@vger.kernel.org, brian <brian.fonfara@gmx.de>

Hello Bruno,

are you sure that fbcon really uses the 1bpp mode and that it works correct=
ly? I tried to
match all var-settings to yours, and 1bpp support still seems broken. Well,=
 a workaround
would be doing it like you are: using 8bpp shadow memory and translating it=
 to packed
pixels (8px per byte) when doing LCD updates. I guess, for now that will be=
 the way to go.
I'll be there to investigate further if needed.

Thank you,
Stefan

Am 14.06.2014 14:35, schrieb Bruno Pr=E9mont:
> Hi Stefan,
>=20
> On Sat, 14 June 2014 Stefan Biereigel <stefan@biereigel.de> wrote:
>> CC: linux-console, linux-fbdev
>>
>> Hello Kernel Developers,
>> for a university assignment we are developing a frame buffer driver for =
a monochrome
>> display. We succeeded so far in making a simple "RAM frame buffer" modul=
e, which is needed
>> as the basis (we don't have read access to the RAM in the LCD).
>> We are using the system-default fb_ops (fb_sys_{read,write},
>> sys_{fillrect,copyarea,imageblit), and all is well when we use bits_per_=
pixel =3D 8. When we
>> map a console to the RAM frame buffer (con2fbmap 1 1), do strg-alt-F1, t=
ype some
>> characters there, we can then 'cat /dev/fb1' and plot the ram contents i=
n Matlab
>> (reshaping the data to be our display geometry first), where our typed c=
haracters and the
>> console appear.
>>
>> If we however change bits_per_pixel to 1, and divide line_length by 8 (a=
s it should
>> represent the line length in bytes), this suddenly stops working: echo a=
nd cat to fb1 work
>> as intended: We change our Matlab-Script to interpret every byte as 8 pi=
xels, bytes
>> written into /dev/fb1 can be read out correctly. If we however map the c=
onsole to fb1, no
>> console output can be seen in RAM - it is (seemingly) filled with garbag=
e.
>>
>> We're using fbcon as the console driver, and the first frame buffer for =
me is intelfb. I
>> see, that the bitblitting-calls for every typed character are depth 1 an=
d have correct
>> geometry, but the whole bitblitting-builtin seems not to work for bits_p=
er_pixel =3D 1, i
>> tried it with a simple test image after the initialisation...
>>
>> Is this behavior intended or are we triggering a bug here (that no one n=
oticed, because
>> who in the world uses monochrome framebuffers these days..). I can't see=
 any comments that
>> monochrome consoles should not work with 1 bit per pixel. See the code b=
elow if you spot
>> some errors (ignore some missing error handling and mediocre style for n=
ow, please).
>=20
> fbcon on 1bpp frambuffer worked for me with picoLCD (though I have found =
no userspace
> framebuffer application willing to operate at 1bpp).
> Thus I allow for 1bpp or 8bpp and convert 8bpp to 1bpp for the picolcd. A=
s for your case,
> picoLCD is "write-only" monochrome LCD backed by in-RAM shadow framebuffe=
r.
>=20
> (see drivers/hid/hid-picolcd_fb.c)
>=20
> Bruno
>=20
>> Thank you for any help and input.
>> Best regards,
>> Stefan Biereigel
>>
>> 8<--- testfb.c
>>
>> #include <linux/init.h>
>> #include <linux/module.h>
>>
>> #include <linux/fb.h>
>> #include <linux/slab.h>
>> #include <linux/wait.h>
>> #include <linux/errno.h>
>> #include <linux/platform_device.h>
>>
>> #define DISPLAY_WIDTH	240
>> #define DISPLAY_HEIGHT	64
>> #define FB_MEM_SIZE 	(DISPLAY_WIDTH * DISPLAY_HEIGHT)/8
>>
>> static struct platform_device *testfb_device;
>>
>> static struct fb_ops fbops =3D {
>> 	.owner		=3D THIS_MODULE,
>> 	.fb_fillrect	=3D sys_fillrect,
>> 	.fb_copyarea	=3D sys_copyarea,
>> 	.fb_imageblit	=3D sys_imageblit,
>> 	.fb_read	=3D fb_sys_read,
>> 	.fb_write	=3D fb_sys_write,
>> 	.fb_sync	=3D NULL,
>> };
>>
>> static int __init testfb_probe (struct platform_device *pdev) {
>> 	void *fb_mem =3D NULL;
>> 	struct fb_info *fbinfo =3D NULL;
>>
>> 	fb_mem =3D kzalloc(FB_MEM_SIZE, GFP_KERNEL);
>>
>> 	if (!fb_mem) {
>> 		pr_err("testfb: memory allocation for framebuffer failed\n");
>> 		return(-ENOMEM);
>> 	}
>> 	else
>> 		pr_debug("testfb: allocated framebuffer memory successfully\n");
>>
>> 	fbinfo =3D framebuffer_alloc(0, &pdev->dev);
>>
>> 	if (!fbinfo) {
>> 		pr_err("testfb: framebuffer_alloc() failed\n");
>> 		kfree(fb_mem);
>> 		return(-1);
>> 	}
>> 	else
>> 		pr_debug("testfb: framebuffer_alloc was successful\n");
>>
>> 	fbinfo->fix.smem_start =3D (unsigned long) fb_mem;
>> 	fbinfo->screen_base =3D (char __iomem *) fb_mem;
>> 	fbinfo->fix.smem_len =3D FB_MEM_SIZE;
>> 	fbinfo->fbops =3D &fbops;
>>
>> 	fbinfo->node			=3D 0;				/* ?int */
>> 	fbinfo->device			=3D &pdev->dev;
>> 	fbinfo->flags			=3D FBINFO_DEFAULT;		/*  */
>> 	fbinfo->var.xres		=3D DISPLAY_WIDTH;		/* visible resolution */
>> 	fbinfo->var.yres		=3D DISPLAY_HEIGHT;		/* visible resolution */
>> 	fbinfo->var.xres_virtual	=3D DISPLAY_WIDTH;		/* virtual resolution */
>> 	fbinfo->var.yres_virtual	=3D DISPLAY_HEIGHT;		/* virtual resolution */
>> 	fbinfo->var.bits_per_pixel	=3D 1;				/* bits per pixel */
>> 	fbinfo->var.activate		=3D FB_ACTIVATE_NOW;		/* set values immediately (=
or vbl) */
>> 	fbinfo->var.sync		=3D 0;				/* ?see FB_SYNC_* */
>> 	fbinfo->var.vmode		=3D FB_VMODE_NONINTERLACED;	/* non interlaced, see F=
B_VMODE_* */
>> 	fbinfo->var.left_margin 	=3D 0;
>> 	fbinfo->var.right_margin 	=3D 0;
>> 	fbinfo->var.upper_margin 	=3D 0;
>> 	fbinfo->var.lower_margin 	=3D 0;
>> 	fbinfo->var.red.offset 		=3D 0;
>> 	fbinfo->var.red.length 		=3D fbinfo->var.bits_per_pixel;
>> 	fbinfo->var.green 		=3D fbinfo->var.red;
>> 	fbinfo->var.blue  		=3D fbinfo->var.red;
>> 	fbinfo->var.grayscale		=3D 1;
>> 	strcpy(fbinfo->fix.id, "testfb");				/* identifier, 16 byte */
>> 	fbinfo->fix.type		=3D FB_TYPE_PACKED_PIXELS;	/* pack pixels to avoid ov=
erhead */
>> 	fbinfo->fix.visual		=3D FB_VISUAL_MONO10;		/* Monochr. 1=3DBlack 0=3DWh=
ite */
>> 	fbinfo->fix.line_length		=3D DISPLAY_WIDTH/8;		/* length of a line in b=
ytes */
>> 	fbinfo->fix.accel		=3D FB_ACCEL_NONE;		/* no hardware accelerator */
>> 	fbinfo->fix.xpanstep 		=3D 0;
>> 	fbinfo->fix.ypanstep		=3D 0;
>> 	fbinfo->fix.ywrapstep 		=3D 0;
>>
>> 	if (register_framebuffer(fbinfo) < 0) {
>> 		pr_err("testfb: registering framebuffer failed\n");
>> 		kfree((void *) fbinfo->fix.smem_start);
>> 		framebuffer_release(fbinfo);
>> 		return(-1);
>> 	}
>> 	else
>> 		pr_debug("testfb: registered framebuffer\n");
>>
>> 	platform_set_drvdata(pdev, fbinfo);
>>
>> 	return 0;
>> }
>>
>> static int testfb_remove(struct platform_device *pdev) {
>> 	struct fb_info *fbinfo =3D NULL;
>>
>> 	fbinfo =3D platform_get_drvdata(pdev);
>>
>> 	if (!fbinfo) {
>> 		pr_err("testfb: unable to get fbinfo from pdev\n");
>> 		return(-1);
>> 	}
>>
>> 	if (unregister_framebuffer(fbinfo) < 0)
>> 		pr_err("testfb: unregistering framebuffer failed\n");
>> 	else
>> 		pr_debug("testfb: unregistered framebuffer\n");
>>
>> 	kfree((void *) fbinfo->fix.smem_start);
>>
>> 	framebuffer_release(fbinfo);
>>
>> 	return 0;
>> }
>>
>> static struct platform_driver testfb_driver =3D {
>> 	.probe =3D testfb_probe,
>> 	.remove =3D testfb_remove,
>> 	.driver =3D {
>> 		.name =3D "testfb",
>> 	},
>> };
>>
>> static int __init testfb_init(void)
>> {
>> 	int ret;
>>
>> 	ret =3D platform_driver_register(&testfb_driver);
>> 	if (!ret) {
>> 		testfb_device =3D platform_device_register_simple("testfb", 0,
>> 								NULL, 0);
>>
>> 		if (IS_ERR(testfb_device)) {
>> 			platform_driver_unregister(&testfb_driver);
>> 			ret =3D PTR_ERR(testfb_device);
>> 		} else {
>> 			pr_info("testfb: platform_device registered\n");
>> 		}
>>
>> 	}
>>
>> 	pr_info("testfb: module loaded\n");
>> =09
>> 	return 0;
>> }
>>
>> static void __exit testfb_exit(void)
>> {
>> 	platform_device_unregister(testfb_device);
>> 	platform_driver_unregister(&testfb_driver);
>>
>> 	pr_info("testfb: module unloaded\n");
>> }
>>
>> module_init(testfb_init);
>> module_exit(testfb_exit);
>>
>> MODULE_LICENSE("GPL v2");
>> MODULE_ALIAS("testfb");
>> MODULE_AUTHOR("Brian Fonfara");
>> MODULE_DESCRIPTION("Ein Modul zum Test der Linux Framebuffer-Programmier=
ung");
>> MODULE_DESCRIPTION("version 0.1");
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-fbdev" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>=20
