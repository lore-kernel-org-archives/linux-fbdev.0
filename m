From: Greg KH <gregkh@linuxfoundation.org>
Date: Mon, 26 Nov 2018 06:56:46 +0000
Subject: Re: [PATCH] Fonts: New Terminus large console font
Message-Id: <20181126065646.GA9680@kroah.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20181126034734.9423-1-amanoeladawod@gmail.com>
In-Reply-To: <20181126034734.9423-1-amanoeladawod@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: nimrud <amanoeladawod@gmail.com>
Cc: akpm@linux-foundation.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, Nov 25, 2018 at 10:47:34PM -0500, nimrud wrote:
> This patch adds an option to compile-in a high resolution and large
> Terminus (ter16x32) bitmap console font for use with HiDPI and Retina screens.
> 
> The font was convereted from standard Terminus ter-i32b.psf (size 16x32)
> with the help of psftools and minor hand editing deleting useless characters.
> 
> This patch is non-intrusive, no options are enabled by default so most
> users won't notice a thing.
> 
> I am placing my changes under the GPL 2.0 just as source Terminus font.
> 
> Signed-off-by: Amanoel Dawod <amanoeladawod@gmail.com>
> ---
>  include/linux/font.h      |    8 +-
>  lib/fonts/Kconfig         |   10 +
>  lib/fonts/Makefile        |    1 +
>  lib/fonts/font_ter16x32.c | 2072 +++++++++++++++++++++++++++++++++++++
>  lib/fonts/fonts.c         |    4 +
>  5 files changed, 2092 insertions(+), 3 deletions(-)
>  create mode 100644 lib/fonts/font_ter16x32.c
> 
> diff --git a/include/linux/font.h b/include/linux/font.h
> index d6821769dd1e..8ab5192e8a13 100644
> --- a/include/linux/font.h
> +++ b/include/linux/font.h
> @@ -29,9 +29,10 @@ struct font_desc {
>  #define	FONT10x18_IDX	5
>  #define SUN8x16_IDX	6
>  #define SUN12x22_IDX	7
> -#define ACORN8x8_IDX	8
> -#define	MINI4x6_IDX	9
> -#define FONT6x10_IDX	10
> +#define TER16x32_IDX	8
> +#define ACORN8x8_IDX	9
> +#define	MINI4x6_IDX	10
> +#define FONT6x10_IDX	11

By changing the font names, did you just break anything?  Why not just
add your new one at the end of the list?

thanks,

greg k-h
