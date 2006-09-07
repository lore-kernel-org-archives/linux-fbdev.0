From: "ankur maheshwari" <ankur_maheshwari@procsys.com>
Subject: Re: how to enable logo
Date: Thu, 7 Sep 2006 21:00:40 +0530
Message-ID: <021b01c6d292$94469670$f301a8c0@procsys>
References: <0ab101c69042$ed73d330$f301a8c0@procsys><Pine.LNX.4.62.0606151037450.19321@pademelon.sonytel.be><005601c6cb7b$bd9592b0$f301a8c0@procsys>
	<Pine.LNX.4.62.0608291700130.3907@pademelon.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GLLlk-0001I2-7Y for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 07 Sep 2006 08:26:20 -0700
Received: from [61.95.199.26] (helo=mailsvr.procsys.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1GLLlh-0004lD-7m
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 07 Sep 2006 08:26:20 -0700
Received: from ankurmaheshwari ([192.168.1.243])
	by mailsvr.procsys.com (8.12.10/8.12.10) with SMTP id k87FOaDn001496
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 7 Sep 2006 20:54:36 +0530
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net

Hi Geert,

Thanks for the reply.

Finally I found my logo on screen, but there are lots of issues in there....

After booting linux, logo takes 10 (ten) minutes to come up on the console
(by that time it console remains blank).

Also console is showing multiple logos, running horizontally and vertically.

Any hint what is going wrong.

thanks
Ankur

----- Original Message -----
From: "Geert Uytterhoeven" <geert@linux-m68k.org>
To: "Linux Frame Buffer Device Development"
<linux-fbdev-devel@lists.sourceforge.net>
Sent: Tuesday, August 29, 2006 8:33 PM
Subject: Re: [Linux-fbdev-devel] how to enable logo


> On Tue, 29 Aug 2006, ankur maheshwari wrote:
> > I have written a framebuffer driver of my own, which is base on virtual
> > framebuffer driver (vfb.c).
> > After linux boot up I can see my framebuffer in /proc/fb as device 0
> >
> > 0 myfbdriver
> >
> > I am working on 2.6.11 uclinux.
> > What I want to know is ----
> > what are the option I need to enable in menuconfig in 2.6 kernel for
> > displaying logo on bootup.
> >
> >
> > Currently I tried
> > Device Driver -> Character device -> Virtual Terminal
> > Device Driver -> Character device -> Serial Driver -> Support for
console on
> > serial device.
> > Graphic support -> Support of frame buffer devices
> > Graphic support ->Console display driver support -> Frame buffer console
> > support
> > Graphic support ->Logo configuration -> Standard 224-color Linux logo.
> > and My framebuffer driver.
> >
> >
> > After boot linux when I do cat /dev/fb0, I get a logo on my
hyperterminal.
> > But console remains blank, I copied other files (.ppm) on /dev/fb0 and
its
> > getting written on /dev/fb0 but console remains blank.
>
> So the correct image is there.
>
> Hence the memory it's writing to is not the actual frame buffer memory of
your
> graphics controller.
>
> > I observed that while boot up console gives print ....
> > Console: Dummy colour device 80x25 .....
>
> Yep, that's the dummy console, which is used if there's no real console
device
> (yet).
>
> > later when fb driver get loaded, I get following prints
> > Console: switching to frame buffer device 80x30
> >
> > I have given fix. params as 640x480 but even then it switchs to 80x30.
>
> 80x30 is the text console, so the units are character cells.
> Since the default font is VGA 8x16, the actual resolution is 80x8 = 640
times
> 30x16 = 480 pixels, which is exactly what you asked for.
>
> Gr{oetje,eeting}s,
>
> Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 --
geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker.
But
> when I'm talking to journalists I just say "programmer" or something like
that.
>     -- Linus Torvalds
>
> -------------------------------------------------------------------------
> Using Tomcat but need to do more? Need to support web services, security?
> Get stuff done quickly with pre-integrated technology to make your job
easier
> Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
> _______________________________________________
> Linux-fbdev-devel mailing list
> Linux-fbdev-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
