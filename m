From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 22 Jul 2014 12:49:22 +0000
Subject: Re: PATCH] video: fix up versatile CLCD helper move
Message-Id: <CACRpkdb3hFm6+NzdY6PNh-u5JE90mxSBXrLvxA=gOrG_gYD0kw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <9561883.zqovrcBa4A@wuerfel>
In-Reply-To: <9561883.zqovrcBa4A@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tue, Jul 15, 2014 at 10:39 AM, Arnd Bergmann <arnd@arndb.de> wrote:

> commit 11c32d7b6274cb0f ("video: move Versatile CLCD helpers")
> moved files out of the plat-versatile directory but in the process
> got a few of the dependencies wrong:
>
> - If CONFIG_FB is not set, the file no longer gets built, resulting
>   in a link error
> - If CONFIG_FB or CONFIG_FB_ARMCLCD are disabled, we also get a
>   Kconfig warning for incorrect dependencies due to the symbol
>   being 'select'ed from the platform Kconfig.
> - When the file is not built, we also get a link error for missing
>   symbols.
>
> This patch should fix all three, by removing the 'select' statements,
> changing the Kconfig description of the symbol to be enabled in
> exactly the right configurations, and adding inline stub functions
> for the case when the framebuffer driver is disabled.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Excellent, thanks a lot Arnd! I struggled with this but didn't
get it right after all :-/
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
