From: Rodolfo Giometti <giometti@linux.it>
Subject: Framebuffer console & Tux
Date: Fri, 17 Dec 2004 15:40:30 +0100
Message-ID: <20041217144029.GC16510@enneenne.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CfJHl-0003tp-Vy
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 17 Dec 2004 06:40:49 -0800
Received: from adsl-72-19.38-151.net24.it ([151.38.19.72] helo=zaigor.enneenne.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CfJHl-0007SS-08
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 17 Dec 2004 06:40:49 -0800
Received: from giometti by zaigor.enneenne.com with local (Exim 3.36 #1 (Debian))
	id 1CfJHS-0000v1-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 17 Dec 2004 15:40:30 +0100
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
Content-Type: text/plain; charset="iso-8859-1"
To: linux-fbdev-devel@lists.sourceforge.net

Hello!

I'm just writing a new frame buffer driver (for a MPC8xx based system)
and I have a strange problem... I init the driver structs as follows:

   strcpy(fb_info.gen.info.modename, "e13505fb");
   /* strcpy(fb_info.gen.info.fontname, default_fontname); */
   fb_info.gen.info.changevar =3D NULL;
   fb_info.gen.info.node =3D -1;
   fb_info.gen.info.fbops =3D &e13505fb_ops;
   fb_info.gen.info.disp =3D &fb_info.disp;
   fb_info.gen.info.switch_con =3D &fbgen_switch;
   fb_info.gen.info.updatevar =3D &fbgen_update_var;
   fb_info.gen.info.blank =3D &fbgen_blank;
   fb_info.gen.parsize =3D sizeof(struct e13505fb_par);
   fb_info.gen.info.flags =3D FBINFO_FLAG_DEFAULT;
   fb_info.disp.var.activate =3D FB_ACTIVATE_NOW;

   /* This should give a reasonable default video mode */
   fbgen_get_var(&fb_info.disp.var, -1, &fb_info.gen.info);
   fbgen_do_set_var(&fb_info.disp.var, 1, &fb_info.gen);
   fbgen_set_disp(-1, &fb_info.gen);
   fbgen_install_cmap(0, &fb_info.gen);

   /* Register the new frame buffer */
   ret =3D register_framebuffer(&fb_info.gen.info);
   if (ret < 0)
      goto fb_register;

and at boot I get:

   Console: switching to frame buffer device

But I can't see Tux in my LCD nor the usual console messages! Can
anyone help me?

Thanks in advance,

Rodolfo

P.S. I use the linux kernel parameter =ABconsole=3Dtty0=BB.

--=20

GNU/Linux Solutions                  e-mail:    giometti@linux.it
Linux Device Driver                             giometti@enneenne.com
Embedded Systems                     home page: giometti.enneenne.com
UNIX programming                     phone:     +39 349 2432127


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.=20
http://productguide.itmanagersjournal.com/
