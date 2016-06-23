From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 23 Jun 2016 09:06:11 +0000
Subject: Re: [PATCH] fbdev: atyfb: fix array overflow
Message-Id: <4078476.C7oJjrxxdA@wuerfel>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20160622123822.1262383-1-arnd@arndb.de> <20160623002825.GA12365@sci.fi>
In-Reply-To: <20160623002825.GA12365@sci.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Ingo Molnar <mingo@kernel.org>, "Luis R. Rodriguez" <mcgrof@suse.com>, Borislav Petkov <bp@suse.de>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Thursday, June 23, 2016 3:28:25 AM CEST Ville Syrj=E4l=E4 wrote:
> On Wed, Jun 22, 2016 at 02:37:11PM +0200, Arnd Bergmann wrote:
> > When building with CONFIG_UBSAN_SANITIZE_ALL on ARM, I get this
> > gcc warning for atyfb:
> >=20
> > drivers/video/fbdev/aty/atyfb_base.c: In function 'aty_bl_update_status=
':
> > drivers/video/fbdev/aty/atyfb_base.c:167:33: warning: array subscript i=
s above array bounds [-Warray-bounds]
> > drivers/video/fbdev/aty/atyfb_base.c:152:26: warning: array subscript i=
s above array bounds [-Warray-bounds]
> >=20
> > Apparently the warning is correct and there is indeed an overflow,
>=20
> Nope. All the LCD register indexes on the Rage LT (the only relevant
> chip for this code path) should stay below the table size. At least
> I can't see any place where we'd walk past the end.

I don't understand what you mean: the warning is about LCD_MISC_CNTL,
which is defined as 0x14, while the array size is 9 and that is smaller.

Is there something more subtle going on than what gcc sees?

	Arnd
