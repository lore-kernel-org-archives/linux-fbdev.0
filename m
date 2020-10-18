From: Daniel Vetter <daniel@ffwll.ch>
Date: Sun, 18 Oct 2020 20:09:06 +0000
Subject: Re: [PATCH 1/2] Fonts: Support FONT_EXTRA_WORDS macros for font_6x8
Message-Id: <CAKMK7uF9E24P=vzKt28=1_iaFTYD7obHs+tEPwwZPNMhh7DBrg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200820082137.5907-1-s.hauer@pengutronix.de>
 <926453876c92caac34cba8545716a491754d04d5.1603037079.git.yepeilin.cs@gmail.com>
In-Reply-To: <926453876c92caac34cba8545716a491754d04d5.1603037079.git.yepeilin.cs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Peilin Ye <yepeilin.cs@gmail.com>, dri-devel <dri-devel@lists.freedesktop.org>
Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sascha Hauer <s.hauer@pengutronix.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Sven Schneider <s.schneider@arkona-technologies.de>, Pengutronix Kernel Team <kernel@pengutronix.de>

Adding dri-devel too, not sure anyone is still listening on linux-fbdev.

On Sun, Oct 18, 2020 at 8:13 PM Peilin Ye <yepeilin.cs@gmail.com> wrote:
>
> Recently, in commit 6735b4632def ("Fonts: Support FONT_EXTRA_WORDS macros
> for built-in fonts"), we wrapped each of our built-in data buffers in a
> `font_data` structure, in order to use the following macros on them, see
> include/linux/font.h:
>
>         #define REFCOUNT(fd)    (((int *)(fd))[-1])
>         #define FNTSIZE(fd)     (((int *)(fd))[-2])
>         #define FNTCHARCNT(fd)  (((int *)(fd))[-3])
>         #define FNTSUM(fd)      (((int *)(fd))[-4])
>
>         #define FONT_EXTRA_WORDS 4
>
> Do the same thing to our new 6x8 font. For built-in fonts, currently we
> only use FNTSIZE(). Since this is only a temporary solution for an
> out-of-bounds issue in the framebuffer layer (see commit 5af08640795b
> ("fbcon: Fix global-out-of-bounds read in fbcon_get_font()")), all the
> three other fields are intentionally set to zero in order to discourage
> using these negative-indexing macros.
>
> Signed-off-by: Peilin Ye <yepeilin.cs@gmail.com>

Patch looks good to me, but it says 1/2 and I can't find 2/2 anywhere,
not even on lore. Did that get lost?
-Daniel

> ---
>  lib/fonts/font_6x8.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/lib/fonts/font_6x8.c b/lib/fonts/font_6x8.c
> index e06447788418..700039a9ceae 100644
> --- a/lib/fonts/font_6x8.c
> +++ b/lib/fonts/font_6x8.c
> @@ -3,8 +3,8 @@
>
>  #define FONTDATAMAX 2048
>
> -static const unsigned char fontdata_6x8[FONTDATAMAX] = {
> -
> +static struct font_data fontdata_6x8 = {
> +       { 0, 0, FONTDATAMAX, 0 }, {
>         /* 0 0x00 '^@' */
>         0x00, /* 000000 */
>         0x00, /* 000000 */
> @@ -2564,13 +2564,13 @@ static const unsigned char fontdata_6x8[FONTDATAMAX] = {
>         0x00, /* 000000 */
>         0x00, /* 000000 */
>         0x00, /* 000000 */
> -};
> +} };
>
>  const struct font_desc font_6x8 = {
>         .idx    = FONT6x8_IDX,
>         .name   = "6x8",
>         .width  = 6,
>         .height = 8,
> -       .data   = fontdata_6x8,
> +       .data   = fontdata_6x8.data,
>         .pref   = 0,
>  };
> --
> 2.25.1
>


-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
