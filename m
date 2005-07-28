From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: Re: [PATCH] fbdev: colormap fixes
Date: Thu, 28 Jul 2005 12:29:21 -0400
Message-ID: <9e473391050728092936794718@mail.gmail.com>
References: <200507280031.j6S0V3L3016861@hera.kernel.org>
	 <Pine.LNX.4.62.0507280952140.24391@numbat.sonytel.be>
	 <9e473391050728060741040424@mail.gmail.com>
	 <42E8F0CD.6070500@gmail.com>
	 <Pine.LNX.4.62.0507281758080.24391@numbat.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DyBGI-0000Il-W8
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 28 Jul 2005 09:29:34 -0700
Received: from wproxy.gmail.com ([64.233.184.205])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1DyBGG-0000Ym-KD
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 28 Jul 2005 09:29:35 -0700
Received: by wproxy.gmail.com with SMTP id i3so451923wra
        for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 28 Jul 2005 09:29:21 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.62.0507281758080.24391@numbat.sonytel.be>
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
Cc: "Antonino A. Daplas" <adaplas@gmail.com>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>, Linux Kernel Development <linux-kernel@vger.kernel.org>

On 7/28/05, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Thu, 28 Jul 2005, Antonino A. Daplas wrote:
> > Jon Smirl wrote:
> > > On 7/28/05, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > > On Wed, 27 Jul 2005, Linux Kernel Mailing List wrote:
> > >
> > > There are a couple of ways to fix this.
> > > 1) Add a check to limit use of the sysfs attributes to 256 entries. I=
f
> > > you want more you have to use /dev/fb0 and the ioctl. More is an
> > > uncommon case.
> > > 2) Switch this to a binary parameter. Now you have to use tools like
> > > hexdump instead of cat to work with the data. It was nice to be able
> > > to use cat to see the current map.
> > >
> > > Does anyone have preferences for which way to fix it?
> >
> > Or...
> >
> >  3) Add another file in sysfs which specifies at what index and how man=
y
> > entries will be read or written from or to the cmap. With this addition=
al
> > sysfs file, it should be able to handle any reasonable cmap length, but
> > it will take more than one reading of the color_map file. Another
> > advantage is that the entire color map need not be read or written if
> > only one field needs to be changed.
> >
> > I've attached a test patch.  Let me know what you think.
>=20
> I like it! ... But, a disadvantages is that it needs to store state betwe=
en two
> non-atomic operations. E.g. imagine two processes doing this at the same =
time.

Two attributes is a big problem with atomicity. If you want access to
the full cmap I would switch to a binary attribute or use the existing
IOCTL.

Note that you can set the entire map with the new patch, you just
can't read it. You can store 1-N entries at any base you want.

>=20
> Gr{oetje,eeting}s,
>=20
>                                                 Geert
>=20
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org
>=20
> In personal conversations with technical people, I call myself a hacker. =
But
> when I'm talking to journalists I just say "programmer" or something like=
 that.
>                                                             -- Linus Torv=
alds
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>=20


--=20
Jon Smirl
jonsmirl@gmail.com


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO September
19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
