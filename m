From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: framebuffer ioctl
Date: Tue, 7 Sep 2004 10:17:39 -0400
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <9e47339104090707172cdc258d@mail.gmail.com>
References: <Pine.GSO.4.58.0409041304080.3434@waterleaf.sonytel.be>
	 <413A3735.9E7D2F11@orpatec.ch> <413B4925.5000706@comcast.net>
	 <200409060926.07163.adaplas@hotpop.com> <413CC0EA.8070709@comcast.net>
	 <9e4733910409061402372095b1@mail.gmail.com>
	 <1094505860.31465.211.camel@admin.tel.thor.asgaard.local>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C4gn0-0001Z4-KS
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 07 Sep 2004 07:17:42 -0700
Received: from rproxy.gmail.com ([64.233.170.202] helo=mproxy.gmail.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1C4gmy-0004k1-7M
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 07 Sep 2004 07:17:40 -0700
Received: by mproxy.gmail.com with SMTP id 77so186623rnl
        for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 07 Sep 2004 07:17:39 -0700 (PDT)
In-Reply-To: <1094505860.31465.211.camel@admin.tel.thor.asgaard.local>
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

The numbers compare two peices of software that exist.  Sure you could
probably write a super optimized library for CPU based drawing in 2D
mode that would be faster, but this library doesn't exist. No matter
what you do using the GPU to draw is always going to beat using the
CPU by a wide margin because of the memory bandwidth difference.

Would Cairo on hardware OpenGL vs Cairo on software only OpenGL be a
better comparison? Those ratios are even worse.

Why does everyone want to write another accelerated drawing library
when we already have a really good one that follows standards and has
excellent documentaition? Why not help integrate DRM and fbdev
instead.


On Mon, 06 Sep 2004 17:24:20 -0400, Michel D=E4nzer <michel@daenzer.net> wr=
ote:
> On Mon, 2004-09-06 at 17:02 -0400, Jon Smirl wrote:
> >
> > Check out the Cairo benchmarks. The OpenGL drivers can beat the
> > performance of 2D drivers 100:1 and some cases 400:1. OpenGL uses the
> > GPU to do the drawing instead of the main CPU.
>=20
> Please stop reiterating these bogus (optimized OpenGL vs. unoptimized
> software-rendered Render extension) numbers, unless you think bogus
> numbers are a good way to make a point.
>=20
> --
> Earthling Michel D=E4nzer      |     Debian (powerpc), X and DRI develope=
r
> Libre software enthusiast    |   http://svcs.affero.net/rm.php?r=3Ddaenze=
r
>=20
>=20
> -------------------------------------------------------
> This SF.Net email is sponsored by BEA Weblogic Workshop
> FREE Java Enterprise J2EE developer tools!
> Get your free copy of BEA WebLogic Workshop 8.1 today.
> http://ads.osdn.com/?ad_idP47&alloc_id=10808&opclick
>=20
>=20
> _______________________________________________
> Linux-fbdev-devel mailing list
> Linux-fbdev-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel
>=20



--=20
Jon Smirl
jonsmirl@gmail.com


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
