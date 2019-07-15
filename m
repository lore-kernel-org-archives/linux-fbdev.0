From: =?UTF-8?Q?Jan_Sebastian_G=c3=b6tte?= <linux@jaseg.net>
Date: Mon, 15 Jul 2019 14:58:01 +0000
Subject: Re: [PATCH] Staging: fbtft: Fix wrong check in,fbtft_write_wmem16_bus8()
Message-Id: <5a77c18f-7338-888f-2379-12171b6a545e@jaseg.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190715143003.12819-1-nsaenzjulienne@suse.de>
 <7b8242ab-cc0c-d90b-60af-ff1c53789e44@opensynergy.com>
In-Reply-To: <7b8242ab-cc0c-d90b-60af-ff1c53789e44@opensynergy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc: =?UTF-8?Q?Jan_Sebastian_G=c3=b6tte?= <linux@jaseg.net>, leobras.c@gmail.com, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, nishadkamdar@gmail.com, gregkh@linuxfoundation.org, dri-devel@lists.freedesktop.org, bhanusreemahesh@gmail.com, Phil Reid <preid@electromag.com.au>

Coincidentially, I've worked on the exact same issue this weekend. I can confirm this change is necessary, and with this and the other two patches from Phil Reid the driver works again. The same mistake occurred in several other locations, though. I'll send a patch fixing all of them.

I've tested this on a ili9486-based display connected to a raspberry pi 3b+.

Regards, Jan

On Mon, 15 Jul 2019 Nicolas Saenz Julienne wrote:
> We actually want to set the gpio pin if it's avilable, not the other way
> around.
> 
> Fixes: c440eee1a7a1 ("Staging: fbtft: Switch to the gpio descriptor
> interface")
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> ---
>  drivers/staging/fbtft/fbtft-bus.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/fbtft/fbtft-bus.c
> b/drivers/staging/fbtft/fbtft-bus.c
> index 2ea814d0dca5..63c65dd67b17 100644
> --- a/drivers/staging/fbtft/fbtft-bus.c
> +++ b/drivers/staging/fbtft/fbtft-bus.c
> @@ -135,7 +135,7 @@ int fbtft_write_vmem16_bus8(struct fbtft_par *par,
> size_t offset, size_t len)
>         remain = len / 2;
>         vmem16 = (u16 *)(par->info->screen_buffer + offset);
>  -      if (!par->gpio.dc)
> +       if (par->gpio.dc)
>                 gpiod_set_value(par->gpio.dc, 1);
>         /* non buffered write */
> --
> 2.22.0
