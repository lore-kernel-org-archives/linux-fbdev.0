From: "Mukund JB." <mukundjb@esntechnologies.co.in>
Subject: NEWBIE Help please.
Date: Mon, 13 Sep 2004 12:39:28 +0530
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <4EE0CBA31942E547B99B3D4BFAB3481110764D@mail.esn.co.in>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C6kzg-0004fl-4A
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 13 Sep 2004 00:11:20 -0700
Received: from [202.125.86.130] (helo=ns2.astrainfonets.net)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1C6kze-0004lx-RQ
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 13 Sep 2004 00:11:20 -0700
Received: from mail.esn.co.in ([202.125.80.34])
	by ns2.astrainfonets.net (8.12.8p1/8.12.8) with ESMTP id i8D76hUE013849
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 13 Sep 2004 07:06:44 GMT
Content-class: urn:content-classes:message
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: linux-fbdev-devel@lists.sourceforge.net


Hello all,

=20

I am having a basic problem of understanding how does the FRAMEBUFFER
driver really goes.

=20

I have just written a sample framebuffer driver, I am attaching the code
here to this mail.

I have the following doubts. I went through the complete mail list where
in found no answers for these questions Probably I am asking silly ones,
please help this newbie.

=20

QUESTION 1 :

is the framebuffer driver restricted to just graphical applications?

Is there a different framebuffer driver for console(ALT+CTRL+F1)? Is
framebuffer mechaninism used on the console too?

=20

=20

QUESTION 2 :

When I have a framebuffer driver already on my system, I know I can I
always insert another framebuffer driver which will be given a minor
number of '1' and is integrated into the kernel on insertion. But, my
question is : what is the active framebuffer driver now?

Is the active framebuffer driver the new one or the old one?=20

=20

I read from a site that setting the global variable "FRAMEBUFFER" as
"/dev/fb1" will activate my driver? please explain how it goes, if this
is true.

=20

QUESTION 3 :

Can u please explain briefly what functionality I need to implement
regarding the follong function which exists in "fb_ops" structure.

fb_get_fix=20

fb_get_var

fb_set_var

fb_get_cmap

fb_set_cmap

fb_pan_display

fb_ioctl

=20

Please provide me a link where in I can get a detailed description of
the above.

=20

Here is the code I want to insert as a framebuffer module.=20

=20

    /*

     *  Initialization

     */

=20

int __init xxxfb_init(void)

{

    fb_info.gen.fbhw =3D &xxx_switch;

    fb_info.gen.fbhw->detect();

    strcpy(fb_info.gen.info.modename, "XXX");

    fb_info.gen.info.changevar =3D NULL;

    fb_info.gen.info.node =3D -1;

    fb_info.gen.info.fbops =3D &xxxfb_ops;

    fb_info.gen.info.disp =3D &disp;

    fb_info.gen.info.switch_con =3D &xxxfb_switch;

    fb_info.gen.info.updatevar =3D &xxxfb_update_var;

    fb_info.gen.info.blank =3D &xxxfb_blank;

    fb_info.gen.info.flags =3D FBINFO_FLAG_DEFAULT;

=20

    /* This should give a reasonable default video mode */

//  fbgen_get_var(&disp.var, -1, &fb_info.gen.info);

//  fbgen_do_set_var(&disp.var, 1, &fb_info.gen);

//  fbgen_set_disp(-1, &fb_info.gen);

//  fbgen_install_cmap(0, &fb_info.gen);

 =20

  if (register_framebuffer(&fb_info.gen.info) < 0)

            return -EINVAL;

    printk(KERN_INFO "fb%d: %s frame buffer device\n",
GET_FB_IDX(fb_info.gen.info.node),

               fb_info.gen.info.modename);

=20

    /* uncomment this if your driver cannot be unloaded */

    /* MOD_INC_USE_COUNT; */

    return 0;

}

=20

=20

    /*

     *  Cleanup

     */

=20

void xxxfb_cleanup(struct fb_info *info)

{

    /*

     *  If your driver supports multiple boards, you should unregister
and

     *  clean up all instances.

     */

=20

    unregister_framebuffer(info);

    /* ... */

}

=20

=20

    /*

     *  Setup

     */

=20

/*
------------------------------------------------------------------------
- */

=20

=20

    /*

     *  Frame buffer operations

     */

=20

/* If all you need is that - just don't define ->fb_open */

static int xxxfb_open(const struct fb_info *info, int user)

{

    return 0;

}

=20

/* If all you need is that - just don't define ->fb_release */

static int xxxfb_release(const struct fb_info *info, int user)

{

    return 0;

}

=20

=20

    /*

     *  In most cases the `generic' routines (fbgen_*) should be
satisfactory.

     *  However, you're free to fill in your own replacements.

     */

=20

static struct fb_ops xxxfb_ops =3D {

            owner:               THIS_MODULE,

            fb_open:            xxxfb_open,    /* only if you need it to
do something */

            fb_release:        xxxfb_release, /* only if you need it to
do something */

//          fb_get_fix:         fbgen_get_fix,=20

//          fb_get_var:         fbgen_get_var,

//          fb_set_var:         fbgen_set_var,

//          fb_get_cmap:     fbgen_get_cmap,

//          fb_set_cmap:     fbgen_set_cmap,

//          fb_pan_display:  fbgen_pan_display,

//          fb_ioctl: xxxfb_ioctl,   /* optional */

};

=20

=20

/*
------------------------------------------------------------------------
- */

=20

=20

    /*

     *  Modularization

     */

=20

#ifdef MODULE

MODULE_LICENSE("GPL");

int init_module(void)

{

    return xxxfb_init();

}

=20

void cleanup_module(void)

{

    xxxfb_cleanup(void);

}

#endif /* MODULE */

=20

=20

regards & and thanks for the help,

Mukund jampala


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
