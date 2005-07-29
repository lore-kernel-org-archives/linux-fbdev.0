From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: fixing fbdev for various framebuffer configs
Date: Fri, 29 Jul 2005 08:13:17 -0400
Message-ID: <9e47339105072905133da5fabc@mail.gmail.com>
References: <9e473391050729035370d76cc5@mail.gmail.com>
	 <42EA16A4.2050709@gmail.com>
	 <9e47339105072904523afe0b9f@mail.gmail.com>
	 <Pine.LNX.4.62.0507291356060.5335@numbat.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DyTjy-00031u-Bl
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 29 Jul 2005 05:13:26 -0700
Received: from wproxy.gmail.com ([64.233.184.205])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1DyTjv-000333-Tv
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 29 Jul 2005 05:13:26 -0700
Received: by wproxy.gmail.com with SMTP id i3so622051wra
        for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 29 Jul 2005 05:13:17 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.62.0507291356060.5335@numbat.sonytel.be>
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: "Antonino A. Daplas" <adaplas@hotpop.com>, James Simmons <jsimmons@infradead.org>

On 7/29/05, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Fri, 29 Jul 2005, Jon Smirl wrote:
> > On 7/29/05, Antonino A. Daplas <adaplas@gmail.com> wrote:
> > > Jon Smirl wrote:
> > > > It has been determined that bits per pixel is insuffucient to
> > > > enumerate all the needed fbconfigs. Here are the possible fgconfigs
> > > > from the OpenGL headers:
> > > >
> > > > total bits
> > > > 8     GL_R3_G3_B2
> > > > 8     GL_RGBA2
> > > > 12   GL_RGB4
> > > > 15   GL_RGB5
> > > > 16   GL_R5_G6_B5
> > > > 16   GL_RGBA4
> > > > 16   GL_RGB5_A1
> > > > 24   GL_RGB8
> > > > 30   GL_RGB10
> > > > 32   GL_RGBA8
> > > > 32   GL_RGB10_A2
> > > > 36   GL_RGB12
> > > > 48   GL_RGB16
> > > > 48   GL_RGBA12
> > > > 48   GL_FLOAT_RGB16
> > > > 64   GL_RGBA16
> > > > 64   GL_FLOAT_RGBA16
> > > > 96   GL_FLOAT_RGB32
> > > > 128 GL_FLOAT_RGBA32
> > > >
> > > > We need to be able to set any of these through the fbdev interface.=
 We
> > > > also need to allow for possible future expansion.
> > >
> > > To set for example, RGBA16, set {transp|green|red|blue}.len to 16, th=
e
> > > offsets to 0, 16, 32, 48, and bits_per_pixel to 64.  Then let the dri=
ver
> > > sort it out.  I don't know what we can do about the FLOAT formats...
> > >
> > > >
> > > > Ideas on how to adjust the fbdev interface?
> > >
> > > Well, no need to adjust the interface.  But it is limited though to
> > > 16 bits per channel.  Redefining them to 32 will break a lot of apps.
>=20
> It's only the colormap entries that are limited to 16 bits per color comp=
onent,
> right? The color components in pixel values can be much larger (up to 2^3=
1 bits
> :-).
>=20
> > My current idea is to get rid of the bit_per_pixel attribute and
> > replace it with config. Config would take strings like 8,8,8 or
> > 5,5,5,1 or 32.,32.,32.
>=20
> That's not acceptable. How do you differentiate between RGB888 (without a=
lpha)
> using 24 or 32 bits per pixel?

Isn't that the driver's problem? You can't differentiate using OpenGL.
This does imply that I need a read only bits_per_pixel to allow apps
to caculate the stride.

> Or more general, what with hardware that has unused bits in its pixel val=
ues,
> e.g. hardware that has 8 bits per pixel but uses only 1 bit per byte in
> monochrome mode and 4 bits in 16-color mode?
>=20
> > > > What is the effect of alpha bits on the scanout buffer, do they do =
anything?
> > >
> > > I think if there is another layer such as an overlay, the alpha bits =
can
> > > control the transparency between the framebuffer and the overlay. If =
only
> > > the framebuffer is active,  I don't believe it has any effects.
>=20
> It has on e.g. Set Top Box hardware.
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
> SF.Net email is Sponsored by the Better Software Conference & EXPO Septem=
ber
> 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
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
SF.Net email is Sponsored by the Better Software Conference & EXPO September
19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
