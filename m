From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Subject: Re: Choosing the correct framebuffer
	configuration
Date: Sun, 07 Aug 2005 12:00:35 -0400
Message-ID: <1123430435.3848.332.camel@localhost>
References: <9e473391050805184756f055ea@mail.gmail.com>
	 <Pine.LNX.4.62.0508071145100.31010@gorilla.sonytel.be>
	 <9e473391050807083327b190f9@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E1naN-0002gC-Kx
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 07 Aug 2005 09:01:15 -0700
Received: from darkcity.gna.ch ([195.226.6.9])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1E1naL-0008Sq-6P
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 07 Aug 2005 09:01:15 -0700
In-Reply-To: <9e473391050807083327b190f9@mail.gmail.com>
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>

On Sun, 2005-08-07 at 11:33 -0400, Jon Smirl wrote:
> On 8/7/05, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Fri, 5 Aug 2005, Jon Smirl wrote:
> > > The chips actually allow nine configs (maybe more when I get a look a=
t
> > > the R300 doc). It is ambiguous to set these configs based on BPP sinc=
e
> > > there are multiple configs for various BPP. These configs should
> > > instead be set with the transp/red/blue/green fields.
> > >
> > > 4bpp Index =3D /4
> > > 8bpp Index =3D /8
> > > 16bpp aRGB 1555 =3D 1/5/5/5
> > > 16bpp RGB 565 =3D /5/6/5
> > > 16bpp aRGB 4444 =3D 4/4/4/4
> > > 16bpp aIndex 88 =3D 8/8
> > > 24bpp RGB 888 =3D /8/8/8
> > > 32bpp aRGB 8888 =3D 8/8/8/8
> > > 32bpp aRGB 2:10:10:10 =3D 2/10/10/10
> > >
> > > What is the best way to fix this?
> >=20
> > Just follow the FBIOPUT_VSCREENINFO rules:
> >   - If a value doesn't fit, round it up.
> >   - If rounding is impossible, return an error.
> >=20
> > So if a user asks for e.g. bpp 16, transp.length =3D 1,
> > {red,green,blue}.length =3D 0, you can give him 1555 if your hardware s=
upports
> > it. Or 4444 if your hardware doesn't support anything in between 1000 a=
nd 4444
> > (w.r.t. rounding). But you must not give him 565, since this implies yo=
u
> > rounded down transp.length.
> >=20
> > > The interesting hidden config is 30b color.
> >=20
> > Piece of cake!
> >=20
> >     bpp =3D 32
> >     transp.length =3D 2, {red,green,blue}.length =3D 10
>=20
> The problem is that the radeonfb driver sees bpp =3D 32 and then sets
> rgbt =3D 8/8/8/8. It stomps rgbt without looking at it.

Looks like a radeonfb bug.


> The basic problem is what happens if bpp and rgbt are set in
> conflicting ways. For example bpp =3D 16 and rgbt =3D 8/8/8/8. Which one
> should win?

Read what you quoted from Geert above.


--=20
Earthling Michel D=C3=A4nzer      |     Debian (powerpc), X and DRI develop=
er
Libre software enthusiast    |   http://svcs.affero.net/rm.php?r=3Ddaenzer


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
