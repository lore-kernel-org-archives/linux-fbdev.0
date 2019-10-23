From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 23 Oct 2019 13:35:49 +0000
Subject: Re: [PATCH 28/36] fbdev: s3c2410fb: remove mach header dependency
Message-Id: <CAK8P3a03JtFrCYFUQAFnSENghrXSCDBQXB-QfiDG3yTxXxdpaw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20191010202802.1132272-1-arnd@arndb.de> <20191010203043.1241612-1-arnd@arndb.de>
 <20191010203043.1241612-28-arnd@arndb.de> <20191023131321.GH11048@pi3>
In-Reply-To: <20191023131321.GH11048@pi3>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>, "moderated list:ARM/SAMSUNG EXYNOS ARM ARCHITECTURES" <linux-samsung-soc@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Linus Walleij <linus.walleij@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, Kukjin Kim <kgene@kernel.org>, linux-stm32@st-md-mailman.stormreply.com, Linux ARM <linux-arm-kernel@lists.infradead.org>

On Wed, Oct 23, 2019 at 3:13 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> On Thu, Oct 10, 2019 at 10:30:12PM +0200, Arnd Bergmann wrote:

> > @@ -321,6 +320,7 @@ static struct s3c2410fb_mach_info jive_lcd_config = {
> >        * data. */
> >
> >       .gpcup          = (0xf << 1) | (0x3f << 10),
> > +     .gpcup_reg =    S3C2410_GPCUP,
>
> Nits: indentation before/after '=' looks wrong. Tab should be
> before '=', one space after.

Ok, fixed now for the four boards that had inconsistent indentation --
jive, mini2440, smdk2440, and rx1950. Unfortunately each board
seemed to have its own way of doing this.

      Arnd
