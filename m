From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: Choosing the correct framebuffer configuration
Date: Sun, 7 Aug 2005 11:33:17 -0400
Message-ID: <9e473391050807083327b190f9@mail.gmail.com>
References: <9e473391050805184756f055ea@mail.gmail.com>
	 <Pine.LNX.4.62.0508071145100.31010@gorilla.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E1n9u-0001PF-HS
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 07 Aug 2005 08:33:54 -0700
Received: from wproxy.gmail.com ([64.233.184.192])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1E1n9Q-0000gf-5L
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 07 Aug 2005 08:33:54 -0700
Received: by wproxy.gmail.com with SMTP id i11so627235wra
        for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 07 Aug 2005 08:33:17 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.62.0508071145100.31010@gorilla.sonytel.be>
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
To: linux-fbdev-devel@lists.sourceforge.net, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>

On 8/7/05, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Fri, 5 Aug 2005, Jon Smirl wrote:
> > The chips actually allow nine configs (maybe more when I get a look at
> > the R300 doc). It is ambiguous to set these configs based on BPP since
> > there are multiple configs for various BPP. These configs should
> > instead be set with the transp/red/blue/green fields.
> >
> > 4bpp Index =3D /4
> > 8bpp Index =3D /8
> > 16bpp aRGB 1555 =3D 1/5/5/5
> > 16bpp RGB 565 =3D /5/6/5
> > 16bpp aRGB 4444 =3D 4/4/4/4
> > 16bpp aIndex 88 =3D 8/8
> > 24bpp RGB 888 =3D /8/8/8
> > 32bpp aRGB 8888 =3D 8/8/8/8
> > 32bpp aRGB 2:10:10:10 =3D 2/10/10/10
> >
> > What is the best way to fix this?
>=20
> Just follow the FBIOPUT_VSCREENINFO rules:
>   - If a value doesn't fit, round it up.
>   - If rounding is impossible, return an error.
>=20
> So if a user asks for e.g. bpp 16, transp.length =3D 1,
> {red,green,blue}.length =3D 0, you can give him 1555 if your hardware sup=
ports
> it. Or 4444 if your hardware doesn't support anything in between 1000 and=
 4444
> (w.r.t. rounding). But you must not give him 565, since this implies you
> rounded down transp.length.
>=20
> > The interesting hidden config is 30b color.
>=20
> Piece of cake!
>=20
>     bpp =3D 32
>     transp.length =3D 2, {red,green,blue}.length =3D 10

The problem is that the radeonfb driver sees bpp =3D 32 and then sets
rgbt =3D 8/8/8/8. It stomps rgbt without looking at it.

Is this a general problem? Do a lot of drivers look at bpp and then
overwrite rgbt? If so I can look at putting better fixup code in base
fbdev and then remove the code that converts from bpp to rgbt in the
various drivers.

The basic problem is what happens if bpp and rgbt are set in
conflicting ways. For example bpp =3D 16 and rgbt =3D 8/8/8/8. Which one
should win? I think the config should always be controlled by rgbt and
bpp is read only and computed from rgbt. But fixing everything to work
that way may break some apps. radeonfb is definitely not working in
this manner.

Best fix would be for the core fbdev to zero out bpp before handing it
to check_par. That would force the chip drivers to compute it from
rgbt. Some of the chip drivers will probably need their code adjusted.
This may also break some apps since they are not setting rgbt.

So I guess the fallback position is leave this driver dependent. So
for the radeonfb case if you set bpp it will work like it always has.
I'll then fix radeonfb to look at rgbt if bpp =3D 0. rgbt with bpp=3D0
will then be able to select the other configs.

It would also be nice to build a string with the list of legal configs
into each driver. For radeon the string would contain: /4, /8,
1/5/5/5, /5/6/5, 4/4/4/4, 8/8, /8/8/8, 8/8/8/8, 2/10/10/10. This would
let me display the list of legal configs in sysfs.

--=20
Jon Smirl
jonsmirl@gmail.com


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
