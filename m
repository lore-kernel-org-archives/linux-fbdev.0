From: =?utf-8?q?Pawe=C5=82_Sikora?= <pluto@pld-linux.org>
Subject: Re: [linux-2.6.10] radeonfb / oops
Date: Sun, 13 Feb 2005 10:53:59 +0100
Message-ID: <200502131053.59562.pluto@pld-linux.org>
References: <200502121639.14542.pluto@pld-linux.org> <20050212173459.GA8195@dreamland.darkstar.lan> <200502122159.10425.pluto@pld-linux.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D0GSC-0006pG-93
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 13 Feb 2005 01:54:12 -0800
Received: from chello081018222206.chello.pl ([81.18.222.206] helo=plus.ds14.agh.edu.pl)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1D0GSA-0006cg-Od
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 13 Feb 2005 01:54:12 -0800
Received: from localhost ([127.0.0.1])
	by plus.ds14.agh.edu.pl with esmtp (Exim 4.42)
	id 1D0GS1-0000J3-7c
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 13 Feb 2005 10:54:01 +0100
In-Reply-To: <200502122159.10425.pluto@pld-linux.org>
Content-Disposition: inline
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="windows-1252"
To: linux-fbdev-devel@lists.sourceforge.net

On Saturday 12 of February 2005 21:59, Pawe=C5=82 Sikora wrote:
> On Saturday 12 of February 2005 18:34, Kronos wrote:
> > It looks like this (in fbsplash_init):
> >
> >                 vc->vc_splash.theme =3D kmalloc((strlen(fbsplash_theme)=
+1)
> > * sizeof(char), GFP_KERNEL); strcpy(vc->vc_splash.theme, fbsplash_theme=
);
> >
> > IMHO kmalloc failed and strcpy used the NULL pointer. Try to change the
> > code in this way:
> >
> > vc->vc_splash.theme =3D kmalloc((strlen(fbsplash_theme)+1), GFP_KERNEL);
> > if (!vc->vc_splash.theme) {
> >         misc_deregister(&splash_dev);
> >         printk(KERN_ERR "fbsplash_init: ZOMG!!! Out of mem!\n");
> >         return -ENOMEM;
> > }
> > strcpy(vc->vc_splash.theme, fbsplash_theme);
>
> You're right.
>
> (...)
> pldworkstation Console: switching to colour frame buffer device 80x30
> pldworkstation fbsplash_init: ZOMG!!! Out of mem!
> (...)
>
> btw).
>
> Bellows fix (from Spock) should help for kmalloc.
> I'll test it tomorrow...
>
> --- a/drivers/video/fbsplash.c.orig  2005-02-12 21:14:47.000000000 +0100
> +++ b/drivers/video/fbsplash.c       2005-02-12 21:15:34.272313976 +0100
> @@ -59,7 +59,7 @@
>
> int fbsplash_mode =3D 0;
> char fbsplash_path[KMOD_PATH_LEN] =3D "/sbin/splash_helper";
> -static char fbsplash_theme[FB_SPLASH_THEME_LEN] __initdata =3D "default";
> +static char fbsplash_theme[FB_SPLASH_THEME_LEN] =3D "default";
>
> int fbsplash_call_helper(char* cmd, unsigned short vc)
> {

It helped. Case closed :-)

=2D-=20
/* Copyright (C) 2003, SCO, Inc. This is valuable Intellectual Property. */

                           #define say(x) lie(x)


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
