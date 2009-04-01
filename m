From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: [PATCH] fbdev: fix color component field length documentation
Date: Wed, 1 Apr 2009 18:50:40 +0200
Message-ID: <20090401185040.6b77143b.krzysztof.h1@poczta.fm>
References: <20090330220007.GC6540@spock.one.pl>
	<10f740e80903310018v7e12de88m696f07e40dc617e3@mail.gmail.com>
	<20090331222835.GA8482@tria>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932586AbZDARt1@vger.kernel.org>
In-Reply-To: <20090331222835.GA8482@tria>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="iso-8859-1"
To: spock@gentoo.org
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, linux-kernel@vger.kernel.org, Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>, linux-fbdev-devel@lists.sourceforge.net

On Wed, 1 Apr 2009 00:28:35 +0200
Michal Januszewski <spock@gentoo.org> wrote:

> The documentation about the meaning of the color component bitfield l=
engths
> in pseudocolor modes is inconsistent.  Fix it, so that it indicates t=
he
> correct interpretation everywhere, i.e. that 1 << length is the numbe=
r
> of palette entries.
>=20
> Signed-off-by: Michal Januszewski <spock@gentoo.org>
> Cc: Krzysztof Helt <krzysztof.h1@poczta.fm>
> Cc: Ville Syrj=E4l=E4 <syrjala@sci.fi>
> Cc: Geert Uytterhoeven <geert.uytterhoeven@gmail.com>
> ---
> This version of the patch incorporates Geert's comments about the
> meaning of the offset field for pseudocolor modes.
>=20

Acked-by: Krzysztof Helt <krzysztof.h1@wp.pl>



----------------------------------------------------------------------
Twoj znajomy na stronie glownej portalu? Wkrec go! ;)=20
Sprawdz >>> http://link.interia.pl/f20f2
