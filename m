From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 29 Aug 2016 13:18:58 +0000
Subject: Re: [PATCH 2/5] video: ARM CLCD: fix endpoint lookup logic
Message-Id: <CACRpkdZ5W4bJfg_rWpYzN1Nrj748_ttZdju7GFJ_5ZDv0vNd_w@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20160826152546.604384-1-arnd@arndb.de> <20160826152546.604384-3-arnd@arndb.de>
In-Reply-To: <20160826152546.604384-3-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>, Colin Ian King <colin.king@canonical.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, Russell King <linux@armlinux.org.uk>, Tomi Valkeinen <tomi.valkeinen@ti.com>

On Fri, Aug 26, 2016 at 5:25 PM, Arnd Bergmann <arnd@arndb.de> wrote:

[I don't see why Torvalds was CC'ed on this patch? Was there
some specific complaint from his side that I screw things up
or just the wrong Linus?]

> The addition of the Nomadik support in this driver introduced
> a bug in clcdfb_of_init_display(), which now calls init_panel
> with an uninitialized 'endpoint' pointer, as "gcc -Wmaybe-uninitialized"
> warns:
>
> drivers/video/fbdev/amba-clcd.c: In function 'clcdfb_of_init_display':
> drivers/video/fbdev/amba-clcd.c:785:5: error: 'endpoint' may be used uninitialized in this function [-Werror=maybe-uninitialized]
>
> This reverts the broken part of the function to what it was before
> the patch, which is the best guess I have to what it should be.
> I assume this was left over from an attempted rework of the
> code that was partially backed out.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 046ad6cdeb3f ("video: ARM CLCD: support Nomadik variant")
> Cc: Linus Walleij <linus.walleij@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Tomi: I think this bug was also reported by Ian King, so suggest
adding his
Reported-by: Colin Ian King <colin.king@canonical.com>

When applying.

Yours,
Linus Walleij
