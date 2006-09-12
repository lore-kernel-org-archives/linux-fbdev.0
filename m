From: "Jorge Luis Zapata Muga" <jorgeluis.zapata@gmail.com>
Subject: Re: overlay support
Date: Tue, 12 Sep 2006 15:55:50 +0200
Message-ID: <eb77d7060609120655l4df86d3cy8b3fc802b51ab48f@mail.gmail.com>
References: <eb77d7060609120627x2466d68fle0912cbee96f223e@mail.gmail.com>
	<Pine.LNX.4.62.0609121531120.27586@pademelon.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GN8jx-0000X6-Ur for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 12 Sep 2006 06:55:54 -0700
Received: from wx-out-0506.google.com ([66.249.82.238])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1GN8jx-0005wI-Kk
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 12 Sep 2006 06:55:53 -0700
Received: by wx-out-0506.google.com with SMTP id r21so2258454wxc
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Tue, 12 Sep 2006 06:55:51 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.62.0609121531120.27586@pademelon.sonytel.be>
Content-Disposition: inline
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

On 9/12/06, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Tue, 12 Sep 2006, Jorge Luis Zapata Muga wrote:
> > i coded a while ago a framebuffer driver for an old video card i have
> > (a SiS 6326, just for learning) but now i would like to support its
> > video extension (overlay support, this card can also capture from an
> > external input, but my version doesnt has the input connectors). ive
> > read on the mailing list and on external projects about how to support
> > overlay on the fb device, but i still dont find a good way to do it,
> > maybe you can help me out.
> >
> > one way is to add another fb device, but it is good only if the device
> > has a different memory space assigned to it, if you only have a chunk
> > of memory for both layers (the overlay and the normal rgb which is
> > this case) there should be a way to resize the memory space assigned
> > to each of them. i dont like this way because is adding a policy on
> > kernel space to manage the memory. am i correct with this assumptions?
>
> If there are just 2 users of the memory (i.e. 2 frame buffers), you can avoid
> adding a policy to the kernel by making the split dynamic.
> Let the first frame buffer `allocate' (based on xres_virtual, yres_virtual, and
> bits_per_pixel) from the bottom of memory, and the second frame buffer from the
> top of memory. Each frame buffer can shrink whatever it wants, or grow, as long
> as it doesn't conflict with the memory size of the other.

indeed, this is another solution, but what happens if the requested
size of the framebuffer will overlap the other framebuffer memory
space? wouldnt be better to manage the framebuffer memory from
userspace and use the v4l interface for the overlay?

>
> Gr{oetje,eeting}s,
>
>                                                 Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                                             -- Linus Torvalds
>
> -------------------------------------------------------------------------
> Using Tomcat but need to do more? Need to support web services, security?
> Get stuff done quickly with pre-integrated technology to make your job easier
> Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
> _______________________________________________
> Linux-fbdev-devel mailing list
> Linux-fbdev-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel
>

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
