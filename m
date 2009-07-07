From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Subject: Re: 
 [linux-fbdev-devel][PATCH]fb_pan_display:add x/yoffset check
Date: Tue, 07 Jul 2009 06:01:10 +0200
Message-ID: <4A52C886.4090605@gmx.de>
References: <4A4839CB.8020801@freescale.com>	<20090629103936.GJ9980@sci.fi>	<4A4985C0.2040800@freescale.com>	<20090703153029.GK9980@sci.fi>
	<4A4E2DCE.1060706@gmx.de>	<4A5168D3.3050502@freescale.com>
	<4A520662.1030504@gmx.de> <4A52B63D.2050000@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <FlorianSchandinat@gmx.de>) id 1MO1wd-0001DK-2s
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 07 Jul 2009 04:06:15 +0000
Received: from mail.gmx.net ([213.165.64.20])
	by 1b2kzd1.ch3.sourceforge.com with smtp (Exim 4.69)
	id 1MO1wP-0005Cm-To for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 07 Jul 2009 04:06:10 +0000
In-Reply-To: <4A52B63D.2050000@freescale.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Kai Jiang <b18973@freescale.com>
Cc: linux-fbdev-devel@lists.sourceforge.net

Kai Jiang schrieb:
> While, I suppose when the patch is applied, it should avoid what you =

> mentioned. Following is the code applied patch.
> (And the x/yres and x/yres_virtual have fix value which are defined and =

> checked in the driver.)

That's true as my explanation described the problem with the current =

code you encountered.
I also think that your patch will fix it:

> fb_pan_display(struct fb_info *info, struct fb_var_screeninfo *var)
> {      ......
>         int xoffset =3D var->xoffset;                 // here transfer =

> x/yoffset to "int" type for comparison
>         int yoffset =3D var->yoffset;
>        ......
>         if (err || !info->fbops->fb_pan_display ||
>             var->yoffset + yres > info->var.yres_virtual ||        =

>             var->xoffset + info->var.xres > info->var.xres_virtual ||    =

>             xoffset < 0 || yoffset < 0)             // insure the =

> x/yoffset is large than 0. I think this line can avoid what you concerned.
>                 return -EINVAL;
>        ......
> }

I only wanted to highlight, that as far as I can see the same behavior =

you want to archive can be archived by changing the current code to:

fb_pan_display(struct fb_info *info, struct fb_var_screeninfo *var)
{
        ......
         if (err || !info->fbops->fb_pan_display ||
             var->yoffset > info->var.yres_virtual - yres ||
             var->xoffset > info->var.xres_virtual - info->var.xres)
                 return -EINVAL;
        ......
}

> Do you think so? I am happy to know your comments.

I think your patch is fine as it fixes the accepted invalid value.
There are only a few small disadvantages:
- its a bit odd to convert unsigned to signed value to check its validity
- it adds 2 extra compares
- although not practically relevant, as virtual resolutions>2^31 would =

require an enormous amount of video memory, it would be too strict on =

this side (by checking for signedness in u32 you half the range of =

allowed numbers)

I first got Ville Syrj=E4l=E4 second email a bit wrong (sorry for that). He =

suggests to change your check to an overflow check:

fb_pan_display(struct fb_info *info, struct fb_var_screeninfo *var)
{
        ......
         if (err || !info->fbops->fb_pan_display ||
             var->yoffset + yres > info->var.yres_virtual ||
             var->xoffset + info->var.xres > info->var.xres_virtual ||
             var->yoffset + yres < yres ||
             var->xoffset + info->var.xres < info->var.xres)
                 return -EINVAL;
      ......
}

while my approach is to prevent the overflow.
I hope that after my last e-mail you understand, that all 3 suggested =

approaches (yours, mine, Ville Syrj=E4l=E4) should fix (at least in my =

opinion) your problem. (as negative values don't exist in unsigned types =

or are actually very large positive integers)


Greetings,

Florian Tobias Schandinat

---------------------------------------------------------------------------=
---
Enter the BlackBerry Developer Challenge  =

This is your chance to win up to $100,000 in prizes! For a limited time, =

vendors submitting new applications to BlackBerry App World(TM) will have =

the opportunity to enter the BlackBerry Developer Challenge. See full prize =

details at: http://p.sf.net/sfu/blackberry
