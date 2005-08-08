From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [Linux-fbdev-devel] CRTC scanout buffer types
Date: Mon, 8 Aug 2005 09:14:45 -0400
Message-ID: <9e47339105080806147e1edbc1@mail.gmail.com>
References: <9e47339105080513195dee0804@mail.gmail.com>
	 <Pine.LNX.4.62.0508071135450.31010@gorilla.sonytel.be>
	 <9e47339105080706414faf1e40@mail.gmail.com>
	 <42F67719.9050805@us.ibm.com> <42F68105.1080207@pol.net>
	 <Pine.LNX.4.62.0508071830270.11306@node2.an-vo.com>
	 <42F6B21E.1070405@gmail.com> <9e47339105080719338b78aa@mail.gmail.com>
	 <Pine.LNX.4.62.0508081038500.3826@numbat.sonytel.be>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <dri-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.62.0508081038500.3826@numbat.sonytel.be>
Content-Disposition: inline
Sender: dri-devel-admin@lists.sourceforge.net
Errors-To: dri-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/dri-devel>,
	<mailto:dri-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:dri-devel@lists.sourceforge.net>
List-Help: <mailto:dri-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/dri-devel>,
	<mailto:dri-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=dri-devel>
Content-Type: text/plain; charset="us-ascii"
To: linux-fbdev-devel@lists.sourceforge.net
Cc: "Antonino A. Daplas" <adaplas@gmail.com>, Vladimir Dergachev <volodya@mindspring.com>, Ian Romanick <idr@us.ibm.com>, DRI developer's list <dri-devel@lists.sourceforge.net>

On 8/8/05, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Sun, 7 Aug 2005, Jon Smirl wrote:
> > On 8/7/05, Antonino A. Daplas <adaplas@gmail.com> wrote:
> > > Vladimir Dergachev wrote:
> > > >> I agree that something like the above is acceptable, exept that we=
 need
> > > >> an extra field for offset and another if indexed color or not. So
> > > >> something like:
> > > >>
> > > >> A:2/0/R:10/2/G:10/12/B:10/22//I
> >
> > The offsets are not needed as part of the input, they should be part
> > of the output display. It is the chip driver that will determine the
> > offsets, not the user.
>=20
> So you cannot select between RGB and BGR on hardware that allows to selec=
t
> that?

If you need that fine of control use the ioctl instead of sysfs.

> > The only exception I can think of is that the radeon hardware can
> > control which nibble is used in 4bpp. I'd say if you need that kind of
>=20
> This is something completely different, since each nibble is a different =
pixel.
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
>=20
>=20
> -------------------------------------------------------
> SF.Net email is Sponsored by the Better Software Conference & EXPO
> September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practic=
es
> Agile & Plan-Driven Development * Managing Projects & Teams * Testing & Q=
A
> Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
> _______________________________________________
> Linux-fbdev-devel mailing list
> Linux-fbdev-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel
>=20


--=20
Jon Smirl
jonsmirl@gmail.com


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
--
