From: Shubhrajyoti Datta <omaplinuxkernel@gmail.com>
Date: Tue, 25 Sep 2012 04:06:46 +0000
Subject: Re: [PATCH] matroxfb: Convert struct i2c_msg initialization to C99 format
Message-Id: <CAM=Q2cv8ewLvKafU_iaxM4cq+G54K2rDu4Hd6Cj5cEtpZVf1qw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1347897325-20684-1-git-send-email-shubhrajyoti@ti.com>
In-Reply-To: <1347897325-20684-1-git-send-email-shubhrajyoti@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Shubhrajyoti D <shubhrajyoti@ti.com>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, julia.lawall@lip6.fr

On Mon, Sep 17, 2012 at 9:25 PM, Shubhrajyoti D <shubhrajyoti@ti.com> wrote:
> Convert the struct i2c_msg initialization to C99 format. This makes
> maintaining and editing the code simpler. Also helps once other fields
> like transferred are added in future.
>
> Thanks to Julia Lawall <julia.lawall@lip6.fr>  for automating the conversion

ping.

>
> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
> ---
> the cocci file was posted
> http://www.mail-archive.com/cocci@diku.dk/msg02753.html
>
>  drivers/video/matrox/matroxfb_maven.c |   15 +++++++++++++--
>  1 files changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/video/matrox/matroxfb_maven.c b/drivers/video/matrox/matroxfb_maven.c
> index 217678e..fb5c123 100644
> --- a/drivers/video/matrox/matroxfb_maven.c
> +++ b/drivers/video/matrox/matroxfb_maven.c
> @@ -137,8 +137,19 @@ static int* get_ctrl_ptr(struct maven_data* md, int idx) {
>
>  static int maven_get_reg(struct i2c_client* c, char reg) {
>         char dst;
> -       struct i2c_msg msgs[] = {{ c->addr, I2C_M_REV_DIR_ADDR, sizeof(reg), &reg },
> -                                { c->addr, I2C_M_RD | I2C_M_NOSTART, sizeof(dst), &dst }};
> +       struct i2c_msg msgs[] = {{
> +                                       .addr = c->addr,
> +                                       .flags = I2C_M_REV_DIR_ADDR,
> +                                       .len = sizeof(reg),
> +                                       .buf = &reg
> +                               },
> +                               {
> +                                       .addr = c->addr,
> +                                       .flags = I2C_M_RD | I2C_M_NOSTART,
> +                                       .len = sizeof(dst),
> +                                       .buf = &dst
> +                               }
> +       };
>         s32 err;
>
>         err = i2c_transfer(c->adapter, msgs, 2);
> --
> 1.7.5.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
