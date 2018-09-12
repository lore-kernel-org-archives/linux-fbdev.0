From: Kees Cook <keescook@chromium.org>
Date: Wed, 12 Sep 2018 17:32:54 +0000
Subject: Re: [PATCH] fbdev/omapfb: fix omapfb_memory_read infoleak
Message-Id: <CAGXu5jKnHoFb7KK3uWwL_q7_+7SfoXJf9o30+WuFxE0KvH8+dg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180912073046.26475-1-tomi.valkeinen@ti.com>
In-Reply-To: <20180912073046.26475-1-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, "# 3.4.x" <stable@vger.kernel.org>, Security Officers <security@kernel.org>, Will Deacon <will.deacon@arm.com>, Jann Horn <jannh@google.com>, Tony Lindgren <tony@atomide.com>

On Wed, Sep 12, 2018 at 12:30 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> OMAPFB_MEMORY_READ ioctl reads pixels from the LCD's memory and copies
> them to a userspace buffer. The code has two issues:
>
> - The user provided width and height could be large enough to overflow
>   the calculations
> - The copy_to_user() can copy uninitialized memory to the userspace,
>   which might contain sensitive kernel information.
>
> Fix these by limiting the width & height parameters, and only copying
> the amount of data that we actually received from the LCD.
>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Reported-by: Jann Horn <jannh@google.com>
> Cc: stable@vger.kernel.org
> Cc: security@kernel.org
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Jann Horn <jannh@google.com>
> Cc: Tony Lindgren <tony@atomide.com>
> ---
>  drivers/video/fbdev/omap2/omapfb/omapfb-ioctl.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/video/fbdev/omap2/omapfb/omapfb-ioctl.c b/drivers/video/fbdev/omap2/omapfb/omapfb-ioctl.c
> index ef69273074ba..a3edb20ea4c3 100644
> --- a/drivers/video/fbdev/omap2/omapfb/omapfb-ioctl.c
> +++ b/drivers/video/fbdev/omap2/omapfb/omapfb-ioctl.c
> @@ -496,6 +496,9 @@ static int omapfb_memory_read(struct fb_info *fbi,
>         if (!access_ok(VERIFY_WRITE, mr->buffer, mr->buffer_size))
>                 return -EFAULT;
>
> +       if (mr->w > 4096 || mr->h > 4096)
> +               return -EINVAL;
> +
>         if (mr->w * mr->h * 3 > mr->buffer_size)
>                 return -EINVAL;

alternatively, replace the above two tests with:

alloc_size = array3_size(mr->w, mr->h, 3);
if (alloc_size > mr->buffer_size)
    return -EINVAL;

buf = vmalloc(alloc_size);
...

>
> @@ -509,7 +512,7 @@ static int omapfb_memory_read(struct fb_info *fbi,
>                         mr->x, mr->y, mr->w, mr->h);
>
>         if (r > 0) {
> -               if (copy_to_user(mr->buffer, buf, mr->buffer_size))
> +               if (copy_to_user(mr->buffer, buf, r))

But yes, this seems correct regardless: userspace was being
overwritten beyond "r", potentially.

-Kees

>                         r = -EFAULT;
>         }
>
> --
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
>



-- 
Kees Cook
Pixel Security
