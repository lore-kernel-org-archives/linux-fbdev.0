From: Amit Pundir <amit.pundir@linaro.org>
Date: Sat, 22 Oct 2016 03:44:31 +0000
Subject: Re: [PATCH] video: ARM CLCD: fix Vexpress regression
Message-Id: <CAMi1Hd0VfDKW363+XMd+mwWT1xcaWX_y+b=+9yHdsZB3LaJbgA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1476945992-5164-1-git-send-email-linus.walleij@linaro.org>
In-Reply-To: <1476945992-5164-1-git-send-email-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 20 October 2016 at 14:46, Linus Walleij <linus.walleij@linaro.org> wrote:
> The CLCD does not come up on Versatile Express as it does not
> (currently) have a syscon node for controlling the block apart
> from the CLCD itself. Make sure the .init() function can bail
> out without an error making it probe again.
>
> Reported-by: Amit Pundir <amit.pundir@linaro.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/video/fbdev/amba-clcd-versatile.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/video/fbdev/amba-clcd-versatile.c b/drivers/video/fbdev/amba-clcd-versatile.c
> index 19ad8645d93c..d909b7dda14d 100644
> --- a/drivers/video/fbdev/amba-clcd-versatile.c
> +++ b/drivers/video/fbdev/amba-clcd-versatile.c
> @@ -527,7 +527,8 @@ int versatile_clcd_init_panel(struct clcd_fb *fb,
>                                              &clcd_id);
>         if (!np) {
>                 dev_err(dev, "no Versatile syscon node\n");
> -               return -ENODEV;
> +               /* Vexpress does not have this */
> +               return 0;
>         }
>         versatile_clcd_type = (enum versatile_clcd)clcd_id->data;

Thanks. Works on my Qemu + Android setup.

Tested-by: Amit Pundir <amit.pundir@linaro.org>

>
> --
> 2.7.4
>
