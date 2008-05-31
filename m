From: Fabio Giovagnini <fabio.giovagnini@aurion-tech.com>
Subject: Re: [PATCH] video: SuperH Mobile LCDC Driver V2
Date: Sat, 31 May 2008 16:25:26 +0200
Message-ID: <200805311625.27018.fabio.giovagnini@aurion-tech.com>
References: <20080530110239.21680.46731.sendpatchset@rx1.opensource.se> <20080530120606.9ff1b384.akpm@linux-foundation.org> <20080530214418.f024ba0c.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20080530214418.f024ba0c.krzysztof.h1@poczta.fm>
Content-Disposition: inline
Sender: linux-sh-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="iso-8859-1"
To: Krzysztof Helt <krzysztof.h1@poczta.fm>
Cc: Andrew Morton <akpm@linux-foundation.org>, Magnus Damm <magnus.damm@gmail.com>, linux-fbdev-devel@lists.sourceforge.net, iwamatsu@nigauri.org, linux-sh@vger.kernel.org, mano@roarinelk.homelinux.net, lethal@linux-sh.org

Which differences are bteween SuperH Mobile LCDC frame buffer and SH2A =
7203=20
LCDC controller?

Thanks a lot.

Best regards


Alle 21:44, venerd=EC 30 maggio 2008, Krzysztof Helt ha scritto:
> On Fri, 30 May 2008 12:06:06 -0700
>
> Andrew Morton <akpm@linux-foundation.org> wrote:
> > On Fri, 30 May 2008 18:28:03 +0200 Krzysztof Helt <krzysztof.h1@poc=
zta.fm>=20
wrote:
> > > On Fri, 30 May 2008 20:02:39 +0900
> > >
> > > Magnus Damm <magnus.damm@gmail.com> wrote:
> > > > This is the SuperH Mobile LCDC frame buffer driver V2, adding
> > > > support for the LCDC block found in SuperH Mobile processors. T=
he
> > > > hardware supports up to two LCD panels per LCDC block, and both=
 RGB
> > > > and SYS interfaces can be used to hook up LCD panels/modules.
> > > >
> > > > The device driver is a regular platform driver, so LCD configur=
ation
> > > > and board specific hooks are passed to the driver using platfor=
m
> > > > data. LCD modules using SYS interface often require special
> > > > configuration using the SYS bus, and to solve this cleanly the =
driver
> > > > provides SYS interface operations to the board code.
> > > >
> > > > Tested on sh7723 and sh7722 processors with a SYS16A QVGA panel=
 and
> > > > WVGA panels using RGB16 and RGB18 interfaces.
> > > >
> > > > Signed-off-by: Magnus Damm <damm@igel.co.jp>
> > > > ---
> > >
> > > Acked-by: Krzysztof Helt<krzysztof.h1@wp.pl>
> > >
> > > Does anybody know which tag is better for a reviewed patch:
> > > "Acked-by" or "Reviewed-by" ?
> >
> > I consider Reviewed-by: to be much stronger that Acked-by:
>
> This driver has been really carefully checked.
>
> Reviewed-by: Krzysztof Helt<krzysztof.h1@wp.pl>
>
> Krzysztof
>
> ---------------------------------------------------------------------=
-
> Tanie rozmowy!
> Sprawdz >>> http://link.interia.pl/f1e13
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
=46abio Giovagnini

Aurion s.r.l.
via degli orti 11,
40050 Funo di Argelato (BO)
P.I e C.F.
00885711200
Tel. +39.335.8350919
=46ax +39.051.8659009

www.aurion-tech.com

account telefono VoIP skype (www.skype.com):
aurion.giovagnini
