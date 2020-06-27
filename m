From: Joe Perches <joe@perches.com>
Date: Sat, 27 Jun 2020 05:12:35 +0000
Subject: Re: [PATCH] fbtft-bus.c: Removing that prohibited space before ')'
Message-Id: <82612d7cc05d1a8f178a71be25884ec8ac5ef6cc.camel@perches.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200627045150.ysqvd47o52f4a6rc@pesu-pes-edu>
In-Reply-To: <20200627045150.ysqvd47o52f4a6rc@pesu-pes-edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: B K Karthik <bkkarthik@pesu.pes.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jan Sebastian =?ISO-8859-1?Q?G=F6tte?= <linux@jaseg.net>, Nicolas Saenz Julienne <nsaenzjulienne@suse.de>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org

On Sat, 2020-06-27 at 00:51 -0400, B K Karthik wrote:
> fbtft-bus.c:
> 
> fixing ERROR: space prohibited before that close parenthesis ')' by removing that space and ',' in line 65 and 67.
[]
> diff --git a/drivers/staging/fbtft/fbtft-bus.c b/drivers/staging/fbtft/fbtft-bus.c
> index 63c65dd67b17..847cbfbbd766 100644
> --- a/drivers/staging/fbtft/fbtft-bus.c
> +++ b/drivers/staging/fbtft/fbtft-bus.c
> @@ -62,9 +62,9 @@ out:									      \
>  }                                                                             \
>  EXPORT_SYMBOL(func);
>  
> -define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8, )
> +define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8)
>  define_fbtft_write_reg(fbtft_write_reg16_bus8, __be16, u16, cpu_to_be16)
> -define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16, )
> +define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16)

Q: Did you compile the files modified by this patch
   before you submitted it?
A: No
