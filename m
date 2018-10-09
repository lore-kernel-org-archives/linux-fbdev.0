From: Lee Jones <lee.jones@linaro.org>
Date: Tue, 09 Oct 2018 09:10:48 +0000
Subject: Re: [PATCH] backlight: lm3639: Unconditionally call led_classdev_unregister
Message-Id: <20181009091048.GF4939@dell>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180921202130.12480-1-natechancellor@gmail.com>
In-Reply-To: <20180921202130.12480-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Nathan Chancellor <natechancellor@gmail.com>
Cc: Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Nick Desaulniers <ndesaulniers@google.com>

On Fri, 21 Sep 2018, Nathan Chancellor wrote:

> Clang warns that the address of a pointer will always evaluated as true
> in a boolean context.
> 
> drivers/video/backlight/lm3639_bl.c:403:14: warning: address of
> 'pchip->cdev_torch' will always evaluate to 'true'
> [-Wpointer-bool-conversion]
>         if (&pchip->cdev_torch)
>         ~~   ~~~~~~~^~~~~~~~~~
> drivers/video/backlight/lm3639_bl.c:405:14: warning: address of
> 'pchip->cdev_flash' will always evaluate to 'true'
> [-Wpointer-bool-conversion]
>         if (&pchip->cdev_flash)
>         ~~   ~~~~~~~^~~~~~~~~~
> 2 warnings generated.
> 
> These statements have been present since 2012, introduced by
> commit 0f59858d5119 ("backlight: add new lm3639 backlight
> driver"). Given that they have been called unconditionally since
> then presumably without any issues, removing the always true if
> statements to fix the warnings without any real world changes.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/119
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
> 
> Alternatively, it's possible the address wasn't supposed to be taken or
> the dev in these structs should be checked instead. I don't have this
> hardware to make that call so I would appreciate some review and
> opinions on what was intended here.
> 
> Thanks!
> 
>  drivers/video/backlight/lm3639_bl.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
