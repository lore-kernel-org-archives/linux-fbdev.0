From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Date: Thu, 23 Jun 2016 17:35:14 +0000
Subject: Re: [PATCH] fbdev: atyfb: fix array overflow
Message-Id: <20160623173514.GA15627@sci.fi>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20160622123822.1262383-1-arnd@arndb.de>
 <CAMuHMdUrrsVe_H0DwaRoJepYcMm50Yb4d500dia4Ou8kEaBioA@mail.gmail.com>
 <4371798.3NSA9GRDBu@wuerfel>
In-Reply-To: <4371798.3NSA9GRDBu@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Arnd Bergmann <arnd@arndb.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Ingo Molnar <mingo@kernel.org>, "Luis R. Rodriguez" <mcgrof@suse.com>, Borislav Petkov <bp@suse.de>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Thu, Jun 23, 2016 at 11:22:20AM +0200, Arnd Bergmann wrote:
> On Thursday, June 23, 2016 10:50:04 AM CEST Geert Uytterhoeven wrote:
> > Hi Arnd,
> >=20
> > On Wed, Jun 22, 2016 at 2:37 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > > When building with CONFIG_UBSAN_SANITIZE_ALL on ARM, I get this
> > > gcc warning for atyfb:
> > >
> > > drivers/video/fbdev/aty/atyfb_base.c: In function 'aty_bl_update_stat=
us':
> > > drivers/video/fbdev/aty/atyfb_base.c:167:33: warning: array subscript=
 is above array bounds [-Warray-bounds]
> > > drivers/video/fbdev/aty/atyfb_base.c:152:26: warning: array subscript=
 is above array bounds [-Warray-bounds]
> > >
> > > Apparently the warning is correct and there is indeed an overflow,
> > > which was never caught. I could only reproduce this on ARM and
> > > have opened a bug against the compiler for the lack of warning.
> > >
> > > This patch makes the array larger, so we cover all possible
> > > registers in the LCD controller without an overflow.
> > >
> > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > > Link: https://bugs.linaro.org/show_bug.cgi?id#49
> > > ---
> > >  drivers/video/fbdev/aty/atyfb_base.c | 2 +-
> > >  include/video/mach64.h               | 1 +
> > >  2 files changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/video/fbdev/aty/atyfb_base.c b/drivers/video/fbd=
ev/aty/atyfb_base.c
> > > index 001d3d871800..36ffba152eab 100644
> > > --- a/drivers/video/fbdev/aty/atyfb_base.c
> > > +++ b/drivers/video/fbdev/aty/atyfb_base.c
> > > @@ -134,7 +134,7 @@
> > >
> > >  #if defined(CONFIG_PM) || defined(CONFIG_PMAC_BACKLIGHT) || \
> > >  defined (CONFIG_FB_ATY_GENERIC_LCD) || defined(CONFIG_FB_ATY_BACKLIG=
HT)
> > > -static const u32 lt_lcd_regs[] =3D {
> > > +static const u32 lt_lcd_regs[LCD_REG_NUM] =3D {
> > >         CNFG_PANEL_LG,
> > >         LCD_GEN_CNTL_LG,
> > >         DSTN_CONTROL_LG,
> > > diff --git a/include/video/mach64.h b/include/video/mach64.h
> > > index 89e91c0cb737..9f74e9e0aeb8 100644
> > > --- a/include/video/mach64.h
> > > +++ b/include/video/mach64.h
> > > @@ -1299,6 +1299,7 @@
> > >  #define APC_LUT_KL             0x38
> > >  #define APC_LUT_MN             0x39
> > >  #define APC_LUT_OP             0x3A
> > > +#define LCD_REG_NUM            0x3B /* total number */
> > >
> > >  /* Values in LCD_GEN_CTRL */
> > >  #define CRT_ON                          0x00000001ul
> >=20
> > This doesn't look like the right fix to me.
> >=20
> > Before, aty_st_lcd(LCD_MISC_CNTL, reg, par) in aty_bl_update_status()
> > wrote into an arbitrary register.
> > With your fix, it will write to register 0, which is IMHO also not OK.
>=20
> Ok, I see now. I thought it array was for initializing the registers and
> caching the contents as some other drivers do it, but it's really used
> for some indirect addressing method.
>=20
> > I think aty_st_lcd() and aty_ld_lcd() should check whether the index is
> > out of range, perhaps even with a WARN_ON()?
>=20
> Just guessing what the right behavior would be, maybe something like
> this? That would assume that the LCD_MISC_CNTL is accessible
> through LCD_INDEX/LCD_DATA but not through a direct register.
>=20
> 	Arnd
>=20
> diff --git a/drivers/video/fbdev/aty/atyfb_base.c b/drivers/video/fbdev/a=
ty/atyfb_base.c
> index 36ffba152eab..c67d4b767e9a 100644
> --- a/drivers/video/fbdev/aty/atyfb_base.c
> +++ b/drivers/video/fbdev/aty/atyfb_base.c
> @@ -148,7 +148,7 @@ static const u32 lt_lcd_regs[LCD_REG_NUM] =3D {
> =20
>  void aty_st_lcd(int index, u32 val, const struct atyfb_par *par)
>  {
> -	if (M64_HAS(LT_LCD_REGS)) {
> +	if (M64_HAS(LT_LCD_REGS) && index < ARRAY_SIZE(lt_lcd_regs)) {
>  		aty_st_le32(lt_lcd_regs[index], val, par);
>  	} else {
>  		unsigned long temp;

We don't want to take the 'else' branch ever, so this isn't any safer
than the original code. So maybe something like this:

if (M64_HAS(LT_LCD_REGS)) {
	if (WARN_ON(index >=3D ARRAY_SIZE(lt_lcd_regs)))
		return;
	...
} else {
	...
}

But aty_ld_lcd() still needs to return something even if the index
is bogus. Either all ones or all zeroes I guess. Which one is
better? I don't know. Not sure what the hardware gives you when trying
to read an invalid register.

> @@ -163,7 +163,7 @@ void aty_st_lcd(int index, u32 val, const struct atyf=
b_par *par)
> =20
>  u32 aty_ld_lcd(int index, const struct atyfb_par *par)
>  {
> -	if (M64_HAS(LT_LCD_REGS)) {
> +	if (M64_HAS(LT_LCD_REGS) && index < ARRAY_SIZE(lt_lcd_regs)) {
>  		return aty_ld_le32(lt_lcd_regs[index], par);
>  	} else {
>  		unsigned long temp;
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-fbdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/
