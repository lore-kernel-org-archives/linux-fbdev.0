From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: vga16fb doesn't build on powerpc (vgacon_remap_base)
Date: Wed, 17 Oct 2007 10:49:04 +0200 (CEST)
Message-ID: <Pine.LNX.4.62.0710171047430.29856@pademelon.sonytel.be>
References: <20071016191403.GA5962@nineveh.local>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-584337861-2973903-1192610944=:29856"
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org>
In-Reply-To: <20071016191403.GA5962@nineveh.local>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
Errors-To: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
To: Joseph Fannin <jfannin@gmail.com>
Cc: linuxppc-dev@ozlabs.org, linux-fbdev-devel@lists.sourceforge.net

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---584337861-2973903-1192610944=:29856
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 16 Oct 2007, Joseph Fannin wrote:
> vga16fb is an available config option on powerpc, but it won't link
> with my .config:
>=20
>     ERROR: "vgacon_remap_base" [drivers/video/vga16fb.ko] undefined!
>=20
>=20
> I'm guessing this is because include/asm-powerpc/vga.h declares
> vgacon_remap_base:=20
>=20
>     extern unsigned long vgacon_remap_base;
>=20
>=20
> ...but arch/powerpc/kernel/setup_32.c wraps the definition in an #ifdef=
:
>=20
>     #ifdef CONFIG_VGA_CONSOLE
>     unsigned long vgacon_remap_base;
>     EXPORT_SYMBOL(vgacon_remap_base);
>     #endif
>=20
>=20
> So CONFIG_VGA_CONSOLE=3Dn and CONFIG_FB_VGA16=3D[y|m] won't work.
>=20
> I've also noticed that the only places in the tree that ever assign
> anything to config_remap_base are under arch/ppc.  And
> include/asm-powerpc/vga.h also does this:
>=20
>     #ifdef __powerpc64__
>     #define VGA_MAP_MEM(x,s) ((unsigned long) ioremap((x), s))
>     #else
>     #define VGA_MAP_MEM(x,s) (x + vgacon_remap_base)
>     #endif
>=20
>=20
> So VGACON probably doesn't work either on 32bit.  I'm guessing arch/pow=
erpc
> doesn't support PREP.

It's not only useful for PREP, but also for CHRP.

> How best could this be fixed up? Or should I just let the thing
> be?  This is obviously not a new thing, and I don't have any hardware
> that supports this stuff either.

I remember this problem was present when I still had a working LongTrail =
(which
is CHRP), long before arch/powerpc/ was created.

With kind regards,
=20
Geert Uytterhoeven
Software Architect

Sony Network and Software Technology Center Europe
The Corporate Village =C2=B7 Da Vincilaan 7-D1 =C2=B7 B-1935 Zaventem =C2=
=B7 Belgium
=20
Phone:    +32 (0)2 700 8453=09
Fax:      +32 (0)2 700 8622=09
E-mail:   Geert.Uytterhoeven@sonycom.com=09
Internet: http://www.sony-europe.com/
 =09
Sony Network and Software Technology Center Europe=09
A division of Sony Service Centre (Europe) N.V.=09
Registered office: Technologielaan 7 =C2=B7 B-1840 Londerzeel =C2=B7 Belg=
ium=09
VAT BE 0413.825.160 =C2=B7 RPR Brussels=09
Fortis Bank Zaventem =C2=B7 Swift GEBABEBB08A =C2=B7 IBAN BE3900138235861=
9
---584337861-2973903-1192610944=:29856
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linuxppc-dev mailing list
Linuxppc-dev@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-dev
---584337861-2973903-1192610944=:29856--
