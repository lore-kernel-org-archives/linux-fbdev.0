From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: Compiler error in =?utf-8?Q?drivers=2F?=
	=?utf-8?Q?video=2Fcirrusfb=2Ec=3A_syntax_error_before_=E2=80=98volatile?=
	=?utf-8?B?4oCZ?=
Date: Tue, 24 Jan 2006 13:58:53 +0000
Message-ID: <20060124135853.GE3459@linux-mips.org>
References: <20060124025130.GA8418@deprecation.cyrius.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mips-bounce@linux-mips.org>
Content-Disposition: inline
In-Reply-To: <20060124025130.GA8418@deprecation.cyrius.com>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="utf-8"
To: Martin Michlmayr <tbm@cyrius.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, jgarzik@pobox.com, linux-mips@linux-mips.org

On Tue, Jan 24, 2006 at 02:51:30AM +0000, Martin Michlmayr wrote:

> I get the following compiler error for drivers/video/cirrusfb.c on
> mips:
>=20
>   CC      drivers/video/cirrusfb.o
> In file included from include/video/vga.h:25,
>                  from drivers/video/cirrusfb.c:70:
> include/asm/vga.h:29: error: syntax error before =E2=80=98volatile=E2=
=80=99
> include/asm/vga.h:34: error: syntax error before =E2=80=98volatile=E2=
=80=99
> make[2]: *** [drivers/video/cirrusfb.o] Error 1
>=20
> These lines define scr_writew() and scr_readw():
>=20
> 29:static inline void scr_writew(u16 val, volatile u16 *addr)
> 34:static inline u16 scr_readw(volatile const u16 *addr)
>=20
> Note that some other arches (powerpc, alpha) have the same
> definitions in vga.h.
>=20
> This is with 2.6.15.

Interesting catch.  The reason is this code in <linux/vt_buffer.h>:

[...]
#if defined(CONFIG_VGA_CONSOLE) || defined(CONFIG_MDA_CONSOLE)
#include <asm/vga.h>
#endif

#ifndef VT_BUF_HAVE_RW
#define scr_writew(val, addr) (*(addr) =3D (val))
#define scr_readw(addr) (*(addr))
#define scr_memcpyw(d, s, c) memcpy(d, s, c)
[...]

But VT_BUF_HAVE_RW is defined in <asm/vga.h>, so if neither
CONFIG_VGA_CONSOLE nor CONFIG_MDA_CONSOLE is defined compilation will
blow up when <asm/vga.h> is being imported later.

  Ralf
