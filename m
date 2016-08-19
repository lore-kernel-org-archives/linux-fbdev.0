From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 19 Aug 2016 09:07:03 +0000
Subject: Re: [PATCH -next] video: ARM CLCD: fix return value check in versatile_clcd_init_panel()
Message-Id: <CACRpkdbUvH_3ZusJWc3ke0WSVXnOnMiQ_5VHs0gD041gTmHiDA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1471051586-26189-1-git-send-email-weiyj.lk@gmail.com>
In-Reply-To: <1471051586-26189-1-git-send-email-weiyj.lk@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Sat, Aug 13, 2016 at 3:26 AM, Wei Yongjun <weiyj.lk@gmail.com> wrote:

> In case of error, the function syscon_node_to_regmap() returns ERR_PTR()
> and never returns NULL. The NULL test in the return value check should
> be replaced with IS_ERR().
>
> Fixes: 25348160e9a4 ("video: ARM CLCD: add special panel hook for Versatiles")
> Signed-off-by: Wei Yongjun <weiyj.lk@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Thanks for fixing my stupid mistake Wei!

Yours,
Linus Walleij
