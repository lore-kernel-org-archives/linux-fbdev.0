From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: [PATCH] fbdev: move logo externs to header file
Date: Fri, 3 Apr 2009 16:03:35 +0200 (CEST)
Message-ID: <alpine.LRH.2.00.0904031603230.32353@vixen.sonytel.be>
References: <alpine.LRH.2.00.0904031157550.32353@vixen.sonytel.be> <20090403123143.GA15598@uranus.ravnborg.org> <alpine.LRH.2.00.0904031537250.32353@vixen.sonytel.be> <20090403134540.GA16066@uranus.ravnborg.org>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1764684AbZDCODx@vger.kernel.org>
In-Reply-To: <20090403134540.GA16066@uranus.ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: TEXT/PLAIN; charset="ks_c_5601-1987"
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, Krzysztof Helt <krzysztof.h1@wp.pl>, Andrew Morton <akpm@linux-foundation.org>, James Simmons <jsimmons@infradead.org>, Linux Kernel Development <linux-kernel@vger.kernel.org>

On Fri, 3 Apr 2009, Sam Ravnborg wrote:
> On Fri, Apr 03, 2009 at 03:38:37PM +0200, Geert Uytterhoeven wrote:
> > On Fri, 3 Apr 2009, Sam Ravnborg wrote:
> > > On Fri, Apr 03, 2009 at 01:45:40PM +0200, Geert Uytterhoeven wrot=
e:
> > > > Now we have __initconst, we can finally move the external decla=
rations for the
> > > > various Linux logo structures to <linux/linux_logo.h>.
> > > >=20
> > > > Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.c=
om>
> > > > Acked-By: James Simmons <jsimmons@infradead.org>
> > > > ---
> > > > James' ack dates back to the previous submission (way to long a=
go), when the
> > > > logos were still __initdata, which caused failures on some plat=
forms with some
> > > > toolchain versions.
> > > >=20
> > > > Note: you have to remove the generated logos, as they're not au=
tomatically
> > > > regenerated if scripts/pnmtologo.c changes.
> > >=20
> > > Something like this to fix that bug?
> >=20
> > Yep, after s/pnmtlogo/pnmtologo/g
> > (it cannot work as-is, as there's one place where you did spell `pn=
mtologo'
> >  correctly ;-)
> >=20
> > Acked-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
>=20
> I assume you take the patch - no?

OK, will send it to akpm ;-)

With kind regards,

Geert Uytterhoeven
Software Architect

Sony Techsoft Centre Europe
The Corporate Village =B7 Da Vincilaan 7-D1 =B7 B-1935 Zaventem =B7 Bel=
gium

Phone:    +32 (0)2 700 8453
=46ax:      +32 (0)2 700 8622
E-mail:   Geert.Uytterhoeven@sonycom.com
Internet: http://www.sony-europe.com/

A division of Sony Europe (Belgium) N.V.
VAT BE 0413.825.160 =B7 RPR Brussels
=46ortis =B7 BIC GEBABEBB =B7 IBAN BE41293037680010
