From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: [PATCH] uvesafb: fix color component length for pseudocolor
 modes
Date: Wed, 1 Apr 2009 18:54:48 +0200
Message-ID: <20090401185448.03c5260a.krzysztof.h1@poczta.fm>
References: <20090330220246.GA6894@spock.one.pl>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932945AbZDARxn@vger.kernel.org>
In-Reply-To: <20090330220246.GA6894@spock.one.pl>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="iso-8859-1"
To: spock@gentoo.org
Cc: linux-kernel@vger.kernel.org, Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>, Geert Uytterhoeven <geert.uytterhoeven@gmail.com>, linux-fbdev-devel@lists.sourceforge.net

On Tue, 31 Mar 2009 00:02:46 +0200
Michal Januszewski <spock@gentoo.org> wrote:

> uvesafb incorrectly sets the length of the color fields to 6 bits
> for PSEUDOCOLOR modes, even though 8 bits are always used per pixel.
> Fix this by setting the length to 8.
>=20
> The switch of the DAC width from the default 6 bits to 8 bits is
> retained and tracked internally in the driver, but never exposed
> to userspace.
>=20
> Signed-off-by: Michal Januszewski <spock@gentoo.org>
> Cc: Krzysztof Helt <krzysztof.h1@poczta.fm>
> Cc: Ville Syrj=E4l=E4 <syrjala@sci.fi>
> Cc: Geert Uytterhoeven <geert.uytterhoeven@gmail.com>
> ---

Acked-by: Krzysztof Helt <krzysztof.h1@wp.pl>


 =09
----------------------------------------------------------------------
Internetowe dowcipy na 1 kwietnia! Sprawdz! ;)=20
http://link.interia.pl/f20f4
