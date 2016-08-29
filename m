From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 29 Aug 2016 13:20:36 +0000
Subject: Re: [PATCH] video: ARM CLCD: export symbols for driver module
Message-Id: <CACRpkda8_qRPEniZ86M=AZhfsaj7M1xmx3hjf89k_Euq_jOuXw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20160826153500.768744-1-arnd@arndb.de>
In-Reply-To: <20160826153500.768744-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Russell King <linux@armlinux.org.uk>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Fri, Aug 26, 2016 at 5:34 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> The amba-clcd-versatile.c code is always built-in and has to
> be done that way because it gets called by platform code that is
> also built-in. However, it now also gets called from the
> core CLCD driver through the .init_panel callback function,
> which leads to a build error when the framebuffer is configured
> as a loadable module:
>
> ERROR: "versatile_clcd_init_panel" [drivers/video/fbdev/amba-clcd-mod.ko] undefined!
>
> The same thing happens for the nomadik driver, although that
> could be linked into the core module if we want to:
>
> ERROR: "nomadik_clcd_init_panel" [drivers/video/fbdev/amba-clcd.ko] undefined!
> ERROR: "nomadik_clcd_init_board" [drivers/video/fbdev/amba-clcd.ko] undefined!
>
> For consistency, I'm taking the same approach in both cases here
> and just export the functions to make them usable by the driver.
>
> Alternatively, we could split out the CONFIG_OF-code from amba-clcd-versatile.c
> into a new file and link those two together with the core driver as one
> module.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 1d3f0cbe0d3a ("video: ARM CLCD: add special board and panel hooks for Nomadik")
> Fixes: 25348160e9a4 ("video: ARM CLCD: add special panel hook for Versatiles")

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
