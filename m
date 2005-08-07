From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: Choosing the correct framebuffer configuration
Date: Sun, 7 Aug 2005 12:15:01 -0400
Message-ID: <9e47339105080709153b7798ad@mail.gmail.com>
References: <9e473391050805184756f055ea@mail.gmail.com>
	 <Pine.LNX.4.62.0508071145100.31010@gorilla.sonytel.be>
	 <9e473391050807083327b190f9@mail.gmail.com>
	 <1123430435.3848.332.camel@localhost>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E1nnv-0003Jj-Dr
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 07 Aug 2005 09:15:15 -0700
Received: from wproxy.gmail.com ([64.233.184.204])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1E1nnu-0003Ts-2G
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 07 Aug 2005 09:15:15 -0700
Received: by wproxy.gmail.com with SMTP id i4so58142wra
        for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 07 Aug 2005 09:15:01 -0700 (PDT)
In-Reply-To: <1123430435.3848.332.camel@localhost>
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
Content-Type: text/plain; charset="iso-8859-1"
To: linux-fbdev-devel@lists.sourceforge.net, =?ISO-8859-1?Q?Michel_D=E4nzer?= <michel@daenzer.net>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>

On 8/7/05, Michel D=E4nzer <michel@daenzer.net> wrote:
> On Sun, 2005-08-07 at 11:33 -0400, Jon Smirl wrote:
> > On 8/7/05, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > On Fri, 5 Aug 2005, Jon Smirl wrote:
> > > > The chips actually allow nine configs (maybe more when I get a look=
 at
> > > > the R300 doc). It is ambiguous to set these configs based on BPP si=
nce
> > > > there are multiple configs for various BPP. These configs should
> > > > instead be set with the transp/red/blue/green fields.
> > > >
> > > > 4bpp Index =3D /4
> > > > 8bpp Index =3D /8
> > > > 16bpp aRGB 1555 =3D 1/5/5/5
> > > > 16bpp RGB 565 =3D /5/6/5
> > > > 16bpp aRGB 4444 =3D 4/4/4/4
> > > > 16bpp aIndex 88 =3D 8/8
> > > > 24bpp RGB 888 =3D /8/8/8
> > > > 32bpp aRGB 8888 =3D 8/8/8/8
> > > > 32bpp aRGB 2:10:10:10 =3D 2/10/10/10
> > > >
> > > > What is the best way to fix this?
> > >
> > > Just follow the FBIOPUT_VSCREENINFO rules:
> > >   - If a value doesn't fit, round it up.
> > >   - If rounding is impossible, return an error.
> > >
> > > So if a user asks for e.g. bpp 16, transp.length =3D 1,
> > > {red,green,blue}.length =3D 0, you can give him 1555 if your hardware=
 supports
> > > it. Or 4444 if your hardware doesn't support anything in between 1000=
 and 4444
> > > (w.r.t. rounding). But you must not give him 565, since this implies =
you
> > > rounded down transp.length.
> > >
> > > > The interesting hidden config is 30b color.
> > >
> > > Piece of cake!
> > >
> > >     bpp =3D 32
> > >     transp.length =3D 2, {red,green,blue}.length =3D 10
> >
> > The problem is that the radeonfb driver sees bpp =3D 32 and then sets
> > rgbt =3D 8/8/8/8. It stomps rgbt without looking at it.
>=20
> Looks like a radeonfb bug.
>=20
>=20
> > The basic problem is what happens if bpp and rgbt are set in
> > conflicting ways. For example bpp =3D 16 and rgbt =3D 8/8/8/8. Which on=
e
> > should win?
>=20
> Read what you quoted from Geert above.

I'm just verifying everything before changing things. Sometimes there
are disagreements on what rules we should be following.

So from Geert's rules 16bpp doesn't fit with 8/8/8/8 so round it up to
32bpp. Are we sure that is what applications are expecting to happen?

--=20
Jon Smirl
jonsmirl@gmail.com


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
