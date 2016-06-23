From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Date: Thu, 23 Jun 2016 17:26:48 +0000
Subject: Re: [PATCH] fbdev: atyfb: fix array overflow
Message-Id: <20160623172648.GA15594@sci.fi>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20160622123822.1262383-1-arnd@arndb.de>
 <20160623002825.GA12365@sci.fi>
 <4078476.C7oJjrxxdA@wuerfel>
In-Reply-To: <4078476.C7oJjrxxdA@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Arnd Bergmann <arnd@arndb.de>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Ingo Molnar <mingo@kernel.org>, "Luis R. Rodriguez" <mcgrof@suse.com>, Borislav Petkov <bp@suse.de>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Jun 23, 2016 at 11:06:11AM +0200, Arnd Bergmann wrote:
> On Thursday, June 23, 2016 3:28:25 AM CEST Ville Syrj=E4l=E4 wrote:
> > On Wed, Jun 22, 2016 at 02:37:11PM +0200, Arnd Bergmann wrote:
> > > When building with CONFIG_UBSAN_SANITIZE_ALL on ARM, I get this
> > > gcc warning for atyfb:
> > >=20
> > > drivers/video/fbdev/aty/atyfb_base.c: In function 'aty_bl_update_stat=
us':
> > > drivers/video/fbdev/aty/atyfb_base.c:167:33: warning: array subscript=
 is above array bounds [-Warray-bounds]
> > > drivers/video/fbdev/aty/atyfb_base.c:152:26: warning: array subscript=
 is above array bounds [-Warray-bounds]
> > >=20
> > > Apparently the warning is correct and there is indeed an overflow,
> >=20
> > Nope. All the LCD register indexes on the Rage LT (the only relevant
> > chip for this code path) should stay below the table size. At least
> > I can't see any place where we'd walk past the end.
>=20
> I don't understand what you mean: the warning is about LCD_MISC_CNTL,
> which is defined as 0x14, while the array size is 9 and that is smaller.
>=20
> Is there something more subtle going on than what gcc sees?

The LCD_MISC_CNTL access is in the backlight code, and thanks to the
following piece of code

if (M64_HAS(MOBIL_BUS) && ...) {
	aty_bl_init(...);
}

we register the backlight only on Rage Mobility. Rage LT is not a Rage
Mobility, so everything is fine.

--=20
Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/
