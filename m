From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: [PATCH v2] fbdev: fix fillrect for 24bpp modes
Date: Tue, 21 Apr 2009 07:10:03 +0200
Message-ID: <20090421071003.ded2ae3f.krzysztof.h1@poczta.fm>
References: <20090413170954.GA8403@tria>
	<20090417183617.ed7553cd.krzysztof.h1@poczta.fm>
	<20090417115048.0c5ca35d.akpm@linux-foundation.org>
	<20090418185234.GA17853@tria>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752417AbZDUFHX@vger.kernel.org>
In-Reply-To: <20090418185234.GA17853@tria>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="iso-8859-1"
To: spock@gentoo.org
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

On Sat, 18 Apr 2009 20:52:34 +0200
Michal Januszewski <spock@gentoo.org> wrote:

> The software fillrect routines do not work properly when the number o=
f
> pixels per machine word is not an integer.  To see that, run the foll=
owing
> command on a fbdev console with a 24bpp video mode, using a non-accel=
erated
> driver such as (u)vesafb:
>=20
>   reset ; echo -e '\e[41mtest\e[K'
>=20
> The expected result is 'test' displayed on a line with red background=
=2E
> Instead of that, 'test' has a red background, but the rest of the lin=
e
> (rendered using fillrect()) contains a distored colorful pattern.
>=20
> This patch fixes the problem by correctly computing rotation shifts.
> It has been tested in a 24bpp mode on 32- and 64-bit little-endian
> machines.
>=20
> Signed-off-by: Micha=B3 Januszewski <spock@gentoo.org>
> ---

I have tested the patch and it has worked with padded lines.

Acked-by: Krzysztof Helt <krzysztof.h1@wp.pl>

However, there is  a comment from Andrew Morton.

Regards,
Krzysztof

----------------------------------------------------------------------
Gotowka na koncie. Otworz konto direct i wez podwojny limit.
http://link.interia.pl/f2115
