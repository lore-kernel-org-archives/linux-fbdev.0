From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: framebuffer ioctl
Date: Tue, 7 Sep 2004 16:26:47 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.58.0409071623550.518@waterleaf.sonytel.be>
References: <Pine.GSO.4.58.0409041304080.3434@waterleaf.sonytel.be>
 <413A3735.9E7D2F11@orpatec.ch> <413B4925.5000706@comcast.net>
 <200409060926.07163.adaplas@hotpop.com> <413CC0EA.8070709@comcast.net>
 <9e4733910409061402372095b1@mail.gmail.com> <1094505860.31465.211.camel@admin.tel.thor.asgaard.local>
 <9e47339104090707172cdc258d@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C4gvw-0002cd-5G
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 07 Sep 2004 07:26:56 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1C4gvu-000721-R5
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 07 Sep 2004 07:26:55 -0700
Received: from waterleaf.sonytel.be (mail.sonytel.be [43.221.60.197])
	by witte.sonytel.be (8.12.10/8.12.10) with ESMTP id i87EQlMp019166
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 7 Sep 2004 16:26:47 +0200 (MEST)
In-Reply-To: <9e47339104090707172cdc258d@mail.gmail.com>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="iso-8859-1"
To: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Tue, 7 Sep 2004, Jon Smirl wrote:
> The numbers compare two peices of software that exist.  Sure you could
> probably write a super optimized library for CPU based drawing in 2D
> mode that would be faster, but this library doesn't exist. No matter
> what you do using the GPU to draw is always going to beat using the
> CPU by a wide margin because of the memory bandwidth difference.
>
> Would Cairo on hardware OpenGL vs Cairo on software only OpenGL be a
> better comparison? Those ratios are even worse.

I think (but I'm not sure) Michel wants you to compare Cairo on OpenGL vs.
traditional 2D accelerated X.

I.e. while X on top of hardware accelerated OpenGL is _much_ faster than =
X on
top of software OpenGL, what we really care about is whether it's much fa=
ster
than traditional 2D accelerated X.

> Why does everyone want to write another accelerated drawing library
> when we already have a really good one that follows standards and has
> excellent documentaition? Why not help integrate DRM and fbdev
> instead.
>
> On Mon, 06 Sep 2004 17:24:20 -0400, Michel D=E4nzer <michel@daenzer.net=
> wrote:
> > On Mon, 2004-09-06 at 17:02 -0400, Jon Smirl wrote:
> > >
> > > Check out the Cairo benchmarks. The OpenGL drivers can beat the
> > > performance of 2D drivers 100:1 and some cases 400:1. OpenGL uses t=
he
> > > GPU to do the drawing instead of the main CPU.
> >
> > Please stop reiterating these bogus (optimized OpenGL vs. unoptimized
> > software-rendered Render extension) numbers, unless you think bogus
> > numbers are a good way to make a point.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org

In personal conversations with technical people, I call myself a hacker. =
But
when I'm talking to journalists I just say "programmer" or something like=
 that.
							    -- Linus Torvalds


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
