From: Martin Michlmayr <tbm@cyrius.com>
Subject: Compiler error in =?utf-8?Q?drivers=2Fvide?=
	=?utf-8?Q?o=2Fcirrusfb=2Ec=3A_syntax_error_before_=E2=80=98volatile?=
	=?utf-8?B?4oCZ?=
Date: Tue, 24 Jan 2006 02:51:30 +0000
Message-ID: <20060124025130.GA8418@deprecation.cyrius.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mips-bounce@linux-mips.org>
Content-Disposition: inline
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="utf-8"
To: linux-fbdev-devel@lists.sourceforge.net, jgarzik@pobox.com
Cc: linux-mips@linux-mips.org

I get the following compiler error for drivers/video/cirrusfb.c on
mips:

  CC      drivers/video/cirrusfb.o
In file included from include/video/vga.h:25,
                 from drivers/video/cirrusfb.c:70:
include/asm/vga.h:29: error: syntax error before =E2=80=98volatile=E2=80=
=99
include/asm/vga.h:34: error: syntax error before =E2=80=98volatile=E2=80=
=99
make[2]: *** [drivers/video/cirrusfb.o] Error 1

These lines define scr_writew() and scr_readw():

29:static inline void scr_writew(u16 val, volatile u16 *addr)
34:static inline u16 scr_readw(volatile const u16 *addr)

Note that some other arches (powerpc, alpha) have the same
definitions in vga.h.

This is with 2.6.15.
--=20
Martin Michlmayr
http://www.cyrius.com/
