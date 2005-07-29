From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: fixing fbdev for various framebuffer configs
Date: Fri, 29 Jul 2005 07:30:56 -0400
Message-ID: <9e473391050729043010d54af7@mail.gmail.com>
References: <9e473391050729035370d76cc5@mail.gmail.com>
	 <Pine.LNX.4.62.0507291317080.5335@numbat.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DyT53-00018i-FS
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 29 Jul 2005 04:31:09 -0700
Received: from wproxy.gmail.com ([64.233.184.200])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1DyT50-0004W0-7Y
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 29 Jul 2005 04:31:09 -0700
Received: by wproxy.gmail.com with SMTP id 36so588029wra
        for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 29 Jul 2005 04:30:56 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.62.0507291317080.5335@numbat.sonytel.be>
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
Cc: fbdev <linux-fbdev-devel@lists.sourceforge.net>, "Antonino A. Daplas" <adaplas@hotpop.com>, James Simmons <jsimmons@infradead.org>

On 7/29/05, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Fri, 29 Jul 2005, Jon Smirl wrote:
> > It has been determined that bits per pixel is insuffucient to
> > enumerate all the needed fbconfigs. Here are the possible fgconfigs
> > from the OpenGL headers:
> >
> > total bits
> > 8     GL_R3_G3_B2
> > 8     GL_RGBA2
> > 12   GL_RGB4
> > 15   GL_RGB5
> > 16   GL_R5_G6_B5
> > 16   GL_RGBA4
> > 16   GL_RGB5_A1
> > 24   GL_RGB8
> > 30   GL_RGB10
> > 32   GL_RGBA8
> > 32   GL_RGB10_A2
> > 36   GL_RGB12
> > 48   GL_RGB16
> > 48   GL_RGBA12
> > 64   GL_RGBA16
>=20
> All above (and many more) can be handled fine, cfr.
> fb_var_screeninfo.{red,green,blue,transp}.
>=20
> > 48   GL_FLOAT_RGB16
> > 64   GL_FLOAT_RGBA16
> > 96   GL_FLOAT_RGB32
> > 128 GL_FLOAT_RGBA32
> >
> > We need to be able to set any of these through the fbdev interface. We
> > also need to allow for possible future expansion.
> >
> > Ideas on how to adjust the fbdev interface?
>=20
> Floating point pixel values could be handled by a new nonstd flag:

Why non-standard? All of the current higher end ATI/Nvidia cards support it=
.

>=20
>     #define FB_NONSTD_FLOAT     2
>     fb_var_screeninfo.nonstd |=3D FB_NONSTD_FLOAT
>=20
> > What is the effect of alpha bits on the scanout buffer, do they do anyt=
hing?
>=20
> They determine the transparency of the pixel w.r.t. to the underlying pla=
ne, if
> the hardware supports it.
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


--=20
Jon Smirl
jonsmirl@gmail.com


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO September
19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
