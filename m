From: Antonino Daplas <adaplas@gmail.com>
Subject: Re: Get the line length from sysfs.
Date: Thu, 22 Sep 2005 18:19:43 +0800
Message-ID: <b00ca3bd05092203193d60c612@mail.gmail.com>
References: <Pine.LNX.4.56.0509212202030.10847@pentafluge.infradead.org>
	 <Pine.LNX.4.62.0509221137530.18908@numbat.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EIOBB-0007f0-Uw
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 22 Sep 2005 03:19:49 -0700
Received: from zproxy.gmail.com ([64.233.162.207])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EIOBB-00030S-L0
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 22 Sep 2005 03:19:49 -0700
Received: by zproxy.gmail.com with SMTP id 14so148947nzn
        for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 22 Sep 2005 03:19:43 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.62.0509221137530.18908@numbat.sonytel.be>
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
Content-Type: text/plain; charset="us-ascii"
To: linux-fbdev-devel@lists.sourceforge.net

On 9/22/05, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Wed, 21 Sep 2005, James Simmons wrote:
> > Let me know if this is acceptable. Some people might not like the name.
> >
> >
> > --- linus-2.6/drivers/video/fbsysfs.c 2005-07-31 15:45:22.000000000 -07=
00
> > +++ fbdev-2.6/drivers/video/fbsysfs.c 2005-09-21 13:54:02.000000000 -07=
00
> > @@ -242,6 +242,13 @@
> >                       fb_info->var.yres_virtual);
> >  }
> >
> > +static ssize_t show_stride(struct class_device *class_device, char *bu=
f)
> > +{
> > +     struct fb_info *fb_info =3D
> > +             (struct fb_info *)class_get_devdata(class_device);
> > +     return snprintf(buf, PAGE_SIZE, "%d\n", fb_info->fix.line_length)=
;
>
> Do all drivers set fix.line_length these days?
>

They have to, if they want to use any of the cfb_* drawing functions.

Tony


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
