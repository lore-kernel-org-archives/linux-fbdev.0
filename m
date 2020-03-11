From: Greg KH <gregkh@linuxfoundation.org>
Date: Wed, 11 Mar 2020 06:06:20 +0000
Subject: Re: [PATCH] staging: fbtft: Remove prohibited spaces before ')'
Message-Id: <20200311060620.GB3522362@kroah.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200311012533.26167-1-marcio.ahf@gmail.com>
In-Reply-To: <20200311012533.26167-1-marcio.ahf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Marcio Albano <marcio.ahf@gmail.com>
Cc: devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org, lkcamp@lists.libreplanetbr.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org

On Wed, Mar 11, 2020 at 01:25:33AM +0000, Marcio Albano wrote:
> Fix checkpatch errors:
> 
> "ERROR: space prohibited before that close parenthesis ')'"
> in fbtft-bus.c:65 and fbtft-bus.c:67.
> 
> Signed-off-by: Marcio Albano <marcio.ahf@gmail.com>
> ---
>  drivers/staging/fbtft/fbtft-bus.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/fbtft/fbtft-bus.c b/drivers/staging/fbtft/fbtft-bus.c
> index 63c65dd67..847cbfbbd 100644
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

Always test-build your patches :(
