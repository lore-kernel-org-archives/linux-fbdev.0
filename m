From: Alexander Kern <alex.kern@gmx.de>
Subject: Re: Fwd: [PATCH 2.5.59] fix for fbcon.c
Date: Wed, 22 Jan 2003 18:45:16 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200301221845.16983.alex.kern@gmx.de>
References: <200301191956.33826.alex.kern@gmx.de> <1043052322.3282.41.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from imap.gmx.net ([213.165.64.20] helo=mail.gmx.net)
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18bOwO-0003sF-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 22 Jan 2003 09:45:32 -0800
In-Reply-To: <1043052322.3282.41.camel@localhost.localdomain>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Antonino Daplas <adaplas@pol.net>
Cc: fbdev <linux-fbdev-devel@lists.sourceforge.net>

Hello,=20

thanks, it look good for me.

Regards

Alex Kern
Am Montag, 20. Januar 2003 09:45 schrieb Antonino Daplas:
> On Mon, 2003-01-20 at 02:56, Alexander Kern wrote:
> [...]
>
> > --- linux-2.5.orig/drivers/video/console/fbcon.c=092003-01-17
> > 16:13:53.000000000 +0100 +++
> > linux/drivers/video/console/fbcon.c=092003-01-19 19:17:23.000000000 +=
0100
> > @@ -1876,17 +1876,23 @@
> >  =09struct display *p =3D &fb_display[vc->vc_num];
> >  =09struct fb_info *info =3D p->fb_info;
> >  =09struct fb_var_screeninfo var =3D info->var;
> > -=09int err;
> > +=09int err; int x_diff, y_diff;
> >
> >  =09var.xres =3D width * vc->vc_font.width;
> >  =09var.yres =3D height * vc->vc_font.height;
> >  =09var.activate =3D FB_ACTIVATE_NOW;
> > -
> > +=09x_diff =3D info->var.xres - var.xres;
> > +=09y_diff =3D info->var.yres - var.yres;
> > +=09if(x_diff < 0 || x_diff > vc->vc_font.width ||
> > +=09  (y_diff < 0 || y_diff > vc->vc_font.height)) {
> > +=09=09DPRINTK("resize now %ix%i\n", var.xres, var.yres);
> >  =09err =3D fb_set_var(&var, info);
> >  =09return  (err || var.xres !=3D info->var.xres ||
> > -=09=09 var.yres !=3D info->var.yres) ?
> > -=09=09-EINVAL : 0;
> > -
> > +=09=09=09var.yres !=3D info->var.yres) ? -EINVAL : 0;
> > +=09} else {
> > +=09=09DPRINTK("prevent resize\n");
> > +=09=09return 0;
> > +=09}
> >  }
> >
> >  static int fbcon_switch(struct vc_data *vc)
>
> Yes, that will work, only if all your console have the same window
> size.  If the size of one of your console is different, then these test=
s
> (x_diff > vc->vc_font.width || y_diff > vc->vc_font.height) will become
> true each time you switch consoles, so you'll be back with a yres of
> 1040 instead of 1050.  The best solution is for the driver to round up
> to 1050 if 1040 is not acceptable.
>
> Still, its much better than the old one :-).  If you don't mind, I'll
> add a few things to your patch:
>
> a.  We do not need to activate the hardware immediately if there is a
> chance of failure.
>
> b.  The xres/yres returned from fb_set_var() will be acceptable as long
> as the value is within a fontwidth/fontheight. This should fix hardware
> that only has a limited set of video modes.
>
> BTW, I'm also attaching a diff to fix vc_resize() in vt.c. In
> vc_resize(), if con_resize() exits with an error, the new console
> dimensions are not reset to the original, and memory from kmalloc() is
> not freed.
>
> Tony
>
> PATCH 1: fbcon_resize
> << begin >>
>
> diff -Naur linux-2.5.59/drivers/video/console/fbcon.c
> linux/drivers/video/console/fbcon.c ---
> linux-2.5.59/drivers/video/console/fbcon.c=092003-01-20 08:19:50.000000=
000
> +0000 +++ linux/drivers/video/console/fbcon.c=092003-01-20 08:37:06.000=
000000
> +0000 @@ -1870,23 +1870,35 @@
>  }
>
>
> -static int fbcon_resize(struct vc_data *vc, unsigned int width,
> -=09=09=09unsigned int height)
> + static int fbcon_resize(struct vc_data *vc, unsigned int width,
> +=09=09=09 unsigned int height)
>  {
>  =09struct display *p =3D &fb_display[vc->vc_num];
>  =09struct fb_info *info =3D p->fb_info;
>  =09struct fb_var_screeninfo var =3D info->var;
> -=09int err;
> -
> -=09var.xres =3D width * vc->vc_font.width;
> -=09var.yres =3D height * vc->vc_font.height;
> -=09var.activate =3D FB_ACTIVATE_NOW;
> -
> -=09err =3D fb_set_var(&var, info);
> -=09return  (err || var.xres !=3D info->var.xres ||
> -=09=09 var.yres !=3D info->var.yres) ?
> -=09=09-EINVAL : 0;
> -
> +=09int err; int x_diff, y_diff;
> +=09int fw =3D vc->vc_font.width;
> +=09int fh =3D vc->vc_font.height;
> +
> +=09var.xres =3D width * fw;
> +=09var.yres =3D height * fh;
> +=09x_diff =3D info->var.xres - var.xres;
> +=09y_diff =3D info->var.yres - var.yres;
> +=09if (x_diff < 0 || x_diff > fw ||
> +=09    (y_diff < 0 || y_diff > fh)) {
> +=09=09var.activate =3D FB_ACTIVATE_TEST;
> +=09=09err =3D fb_set_var(&var, info);
> +=09=09if (err || width !=3D var.xres/fw ||
> +=09=09    height !=3D var.yres/fh)
> +=09=09=09return -EINVAL;
> +=09=09DPRINTK("resize now %ix%i\n", var.xres, var.yres);
> +=09=09var.activate =3D FB_ACTIVATE_NOW;
> +=09=09fb_set_var(&var, info);
> +=09=09p->vrows =3D info->var.yres_virtual/fh;
> +=09} else {
> +=09=09DPRINTK("prevent resize\n");
> +=09}
> +=09return 0;
>  }
>
>  static int fbcon_switch(struct vc_data *vc)
> << end >>
>
> PATCH 2: vc_resize
>
> << begin >>
>
> diff -Naur linux-2.5.59/drivers/char/vt.c linux/drivers/char/vt.c
> --- linux-2.5.59/drivers/char/vt.c=092003-01-20 08:18:11.000000000 +000=
0
> +++ linux/drivers/char/vt.c=092003-01-20 08:17:37.000000000 +0000
> @@ -732,6 +732,10 @@
>  =09if (new_cols =3D=3D video_num_columns && new_rows =3D=3D video_num_=
lines)
>  =09=09return 0;
>
> +=09err =3D resize_screen(currcons, new_cols, new_rows);
> +=09if (err)
> +=09=09return err;
> +
>  =09newscreen =3D (unsigned short *) kmalloc(new_screen_size, GFP_USER)=
;
>  =09if (!newscreen)
>  =09=09return -ENOMEM;
> @@ -746,9 +750,6 @@
>  =09video_size_row =3D new_row_size;
>  =09screenbuf_size =3D new_screen_size;
>
> -=09err =3D resize_screen(currcons, new_cols, new_rows);
> -=09if (err)
> -=09=09return err;
>
>  =09rlth =3D min(old_row_size, new_row_size);
>  =09rrem =3D new_row_size - rlth;
> << end >>
>
>
>
> -------------------------------------------------------
> This SF.NET email is sponsored by: FREE  SSL Guide from Thawte
> are you planning your Web Server Security? Click here to get a FREE
> Thawte SSL guide and find the answers to all your  SSL security issues.
> http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0026en
> _______________________________________________
> Linux-fbdev-devel mailing list
> Linux-fbdev-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel



-------------------------------------------------------
This SF.net email is sponsored by: Scholarships for Techies!
Can't afford IT training? All 2003 ictp students receive scholarships.
Get hands-on training in Microsoft, Cisco, Sun, Linux/UNIX, and more.
www.ictp.com/training/sourceforge.asp
