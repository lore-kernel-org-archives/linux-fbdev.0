From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: fixing fbdev for various framebuffer configs
Date: Fri, 29 Jul 2005 07:52:50 -0400
Message-ID: <9e47339105072904523afe0b9f@mail.gmail.com>
References: <9e473391050729035370d76cc5@mail.gmail.com>
	 <42EA16A4.2050709@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DyTQC-00026F-GP
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 29 Jul 2005 04:53:00 -0700
Received: from wproxy.gmail.com ([64.233.184.197])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1DyTQC-0001ii-7F
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 29 Jul 2005 04:53:00 -0700
Received: by wproxy.gmail.com with SMTP id 36so590572wra
        for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 29 Jul 2005 04:52:50 -0700 (PDT)
In-Reply-To: <42EA16A4.2050709@gmail.com>
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
Cc: "Antonino A. Daplas" <adaplas@hotpop.com>, Geert Uytterhoeven <geert@linux-m68k.org>, James Simmons <jsimmons@infradead.org>

On 7/29/05, Antonino A. Daplas <adaplas@gmail.com> wrote:
> Jon Smirl wrote:
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
> > 48   GL_FLOAT_RGB16
> > 64   GL_RGBA16
> > 64   GL_FLOAT_RGBA16
> > 96   GL_FLOAT_RGB32
> > 128 GL_FLOAT_RGBA32
> >
> > We need to be able to set any of these through the fbdev interface. We
> > also need to allow for possible future expansion.
>=20
> To set for example, RGBA16, set {transp|green|red|blue}.len to 16, the
> offsets to 0, 16, 32, 48, and bits_per_pixel to 64.  Then let the driver
> sort it out.  I don't know what we can do about the FLOAT formats...
>=20
> >
> > Ideas on how to adjust the fbdev interface?
>=20
> Well, no need to adjust the interface.  But it is limited though to
> 16 bits per channel.  Redefining them to 32 will break a lot of apps.

We can change fb_info since the only thing that sees it is fbconsole.
That will let me set the 32bit modes via sysfs. We leave the ioctl's
alone at 16 bits so that the old apps don't notice.

My current idea is to get rid of the bit_per_pixel attribute and
replace it with config. Config would take strings like 8,8,8 or
5,5,5,1 or 32.,32.,32.


>=20
> >
> > What is the effect of alpha bits on the scanout buffer, do they do anyt=
hing?
> >
>=20
> I think if there is another layer such as an overlay, the alpha bits can
> control the transparency between the framebuffer and the overlay. If only
> the framebuffer is active,  I don't believe it has any effects.
>=20
> Tony
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
