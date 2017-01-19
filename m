From: Kees Cook <keescook@chromium.org>
Date: Thu, 19 Jan 2017 20:35:07 +0000
Subject: Re: [PATCH] fbdev: color map copying bounds checking
Message-Id: <CAGXu5jL-ejr1qubsTz3J1Kpw5ypKKpgwv2-kpytHuurJLnnQmg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170105224249.GA50925@beast>
In-Reply-To: <20170105224249.GA50925@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-fbdev@vger.kernel.org, Min Chong <mchong@google.com>, Dan Carpenter <dan.carpenter@oracle.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

Hi again,

It's been two weeks with no response. This fixes a kernel heap OOB
read. Andrew, can you take this into -mm?

-Kees

On Thu, Jan 5, 2017 at 2:42 PM, Kees Cook <keescook@chromium.org> wrote:
> Copying color maps to userspace doesn't check the value of to->start,
> which will cause kernel heap buffer OOB read due to signedness wraps.
>
> CVE-2016-8405
>
> Reported-by: Peter Pi (@heisecode) of Trend Micro
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  drivers/video/fbdev/core/fbcmap.c | 26 ++++++++++++++------------
>  1 file changed, 14 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/video/fbdev/core/fbcmap.c b/drivers/video/fbdev/core/fbcmap.c
> index f89245b8ba8e..68a113594808 100644
> --- a/drivers/video/fbdev/core/fbcmap.c
> +++ b/drivers/video/fbdev/core/fbcmap.c
> @@ -163,17 +163,18 @@ void fb_dealloc_cmap(struct fb_cmap *cmap)
>
>  int fb_copy_cmap(const struct fb_cmap *from, struct fb_cmap *to)
>  {
> -       int tooff = 0, fromoff = 0;
> -       int size;
> +       unsigned int tooff = 0, fromoff = 0;
> +       size_t size;
>
>         if (to->start > from->start)
>                 fromoff = to->start - from->start;
>         else
>                 tooff = from->start - to->start;
> -       size = to->len - tooff;
> -       if (size > (int) (from->len - fromoff))
> -               size = from->len - fromoff;
> -       if (size <= 0)
> +       if (fromoff >= from->len || tooff >= to->len)
> +               return -EINVAL;
> +
> +       size = min_t(size_t, to->len - tooff, from->len - fromoff);
> +       if (size = 0)
>                 return -EINVAL;
>         size *= sizeof(u16);
>
> @@ -187,17 +188,18 @@ int fb_copy_cmap(const struct fb_cmap *from, struct fb_cmap *to)
>
>  int fb_cmap_to_user(const struct fb_cmap *from, struct fb_cmap_user *to)
>  {
> -       int tooff = 0, fromoff = 0;
> -       int size;
> +       unsigned int tooff = 0, fromoff = 0;
> +       size_t size;
>
>         if (to->start > from->start)
>                 fromoff = to->start - from->start;
>         else
>                 tooff = from->start - to->start;
> -       size = to->len - tooff;
> -       if (size > (int) (from->len - fromoff))
> -               size = from->len - fromoff;
> -       if (size <= 0)
> +       if (fromoff >= from->len || tooff >= to->len)
> +               return -EINVAL;
> +
> +       size = min_t(size_t, to->len - tooff, from->len - fromoff);
> +       if (size = 0)
>                 return -EINVAL;
>         size *= sizeof(u16);
>
> --
> 2.7.4
>
>
> --
> Kees Cook
> Nexus Security



-- 
Kees Cook
Nexus Security
