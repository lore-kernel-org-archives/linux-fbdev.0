From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Mon, 16 Jun 2014 07:35:35 +0000
Subject: Re: [PATCH] offb: Fix little-endian support
Message-Id: <1402904135.7661.34.camel@pasglop>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1400073709-15012-1-git-send-email-tiwai@suse.de>
In-Reply-To: <1400073709-15012-1-git-send-email-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Takashi Iwai <tiwai@suse.de>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Cedric Le Goater <clg@fr.ibm.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 2014-05-14 at 15:21 +0200, Takashi Iwai wrote:
>         case 16:                /* RGB 565 */
>                 var->bits_per_pixel = 16;
> -               var->red.offset = 11;
> +               if (fb_be_math(info)) {
> +                       var->red.offset = 11;
> +                       var->green.offset = 5;
> +                       var->blue.offset = 0;
> +               } else {
> +                       var->red.offset = 0;
> +                       var->green.offset = 5;
> +                       var->blue.offset = 11;
> +               }
>                 var->red.length = 5;
> -               var->green.offset = 5;
>                 var->green.length = 6;
> -               var->blue.offset = 0;
>                 var->blue.length = 5;
>                 var->transp.offset = 0;
>                 var->transp.length = 0;
>                 break;

I somewhat doubt that this (and 5:5:5) actually work, do they ? the
green gets split into two separate fields, which we can't express
properly here...

Cheers,
Ben.


