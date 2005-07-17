From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [PATCH] add NULL short circuit to fb_dealloc_cmap()
Date: Sun, 17 Jul 2005 18:32:07 -0400
Message-ID: <9e47339105071715322c558403@mail.gmail.com>
References: <200507172043.41473.jesper.juhl@gmail.com>
	 <9e473391050717132233347d25@mail.gmail.com>
	 <Pine.LNX.4.62.0507172314000.4553@numbat.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DuHgG-0005PC-2H
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 17 Jul 2005 15:32:16 -0700
Received: from wproxy.gmail.com ([64.233.184.200])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.44)
	id 1DuHgE-0003OD-Sv
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 17 Jul 2005 15:32:16 -0700
Received: by wproxy.gmail.com with SMTP id 37so915292wra
        for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 17 Jul 2005 15:32:08 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.62.0507172314000.4553@numbat.sonytel.be>
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
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Jesper Juhl <jesper.juhl@gmail.com>, Linux Kernel Development <linux-kernel@vger.kernel.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On 7/17/05, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> >
> > struct fb_super_cmap {
> >    struct fb_cmap cmap;
> >    __u16 red[255];
> >    __u16 blue[255];
> >    __u16 green[255];
> >    __u16 transp[255];
>                   ^^^
> I assume you meant 256?
>=20
> > }
> >
> > Then adjust the code as need. Have the embedded cmap struct point to
> > the fields in the super_cmap and the drivers don't have to be changed.
>=20
> What if your colormap has more than 256 entries?

I meant 256. Does any hardware exist that takes more that 256 entries?=20
They are __u16 values but I have never seen hardware that take more
that __u8 either.

--=20
Jon Smirl
jonsmirl@gmail.com


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
