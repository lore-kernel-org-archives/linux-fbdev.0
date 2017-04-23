From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sun, 23 Apr 2017 19:58:31 +0000
Subject: Re: [PATCH] video: fbdev: udlfb: Fix buffer on stack
Message-Id: <CAMuHMdV2FR9f3=V3RcSsoJxikNESVb4mxu8mJfFnhPP61_2DJw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170422164922.9472-1-maksim.salau@gmail.com>
In-Reply-To: <20170422164922.9472-1-maksim.salau@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Sat, Apr 22, 2017 at 6:49 PM, Maksim Salau <maksim.salau@gmail.com> wrote:
> Allocate buffers on HEAP instead of STACK for local array
> that is to be sent using usb_control_msg().
>
> Signed-off-by: Maksim Salau <maksim.salau@gmail.com>
> ---
>  drivers/video/fbdev/udlfb.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/video/fbdev/udlfb.c b/drivers/video/fbdev/udlfb.c
> index e9c2f7b..1e83e19 100644
> --- a/drivers/video/fbdev/udlfb.c
> +++ b/drivers/video/fbdev/udlfb.c
> @@ -1487,15 +1487,27 @@ static struct device_attribute fb_device_attrs[] = {
>  static int dlfb_select_std_channel(struct dlfb_data *dev)
>  {
>         int ret;
> -       u8 set_def_chn[] = {       0x57, 0xCD, 0xDC, 0xA7,
> +       void *buf = NULL;
> +       const u8 set_def_chn[] = {

Please make this static, else it will be copied once more by the compiler.

> +                               0x57, 0xCD, 0xDC, 0xA7,
>                                 0x1C, 0x88, 0x5E, 0x15,
>                                 0x60, 0xFE, 0xC6, 0x97,
>                                 0x16, 0x3D, 0x47, 0xF2  };
>
> +       buf = kmalloc(sizeof(set_def_chn), GFP_KERNEL);
> +
> +       if (!buf)
> +               return -ENOMEM;
> +
> +       memcpy(buf, set_def_chn, sizeof(set_def_chn));

kmalloc() + memcpy() => kmemdup().

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
