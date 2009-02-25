From: Geert Uytterhoeven <geert.uytterhoeven@gmail.com>
Subject: Re: [Linux-fbdev-devel] [PATCH] cirrusfb: fix compilation in Zorro 
	code
Date: Wed, 25 Feb 2009 09:56:31 +0100
Message-ID: <10f740e80902250056vd748ff1p8cd17d2a79d9c37c@mail.gmail.com>
References: <20090225070956.41fff8e6.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-m68k-owner@vger.kernel.org>
In-Reply-To: <20090225070956.41fff8e6.krzysztof.h1@poczta.fm>
Sender: linux-m68k-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: Krzysztof Helt <krzysztof.h1@poczta.fm>
Cc: Linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>, Andrew Morton <akpm@linux-foundation.org>, linux-m68k@lists.linux-m68k.org

On Wed, Feb 25, 2009 at 07:09, Krzysztof Helt <krzysztof.h1@poczta.fm> wrote:

> Where can I get m68 cross compiler for PC able
> to compile Amiga kernel?

http://people.debian.org/~smarenka/m68k/cross-compilers/ has debs for
Debian/ia32.

If you want to build your own:

    http://people.debian.org/~smarenka/m68k/cross-compilers/aaareadme.txt
    http://www.xs4all.nl/~zippel/crosscc/crosscc.README

I have debs for Ubuntu/amd64.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
