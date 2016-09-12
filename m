From: Greg KH <gregkh@linuxfoundation.org>
Date: Mon, 12 Sep 2016 11:16:35 +0000
Subject: Re: [PATCH 1/2] staging: sm750fb: fix line length coding style issues in ddk750_chip.c
Message-Id: <20160912111635.GA12026@kroah.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <523e16874da50855062fcc51b6754e2b9c42b9e5.1472932508.git.mgmoshes@gmail.com>
In-Reply-To: <523e16874da50855062fcc51b6754e2b9c42b9e5.1472932508.git.mgmoshes@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Moshe Green <mgmoshes@gmail.com>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, Sep 04, 2016 at 09:03:27PM +0300, Moshe Green wrote:
> Fix multiple line length warnings found by the checkpatch.pl tool
> in ddk750_chip.c.
> 
> Signed-off-by: Moshe Green <mgmoshes@gmail.com>
> ---
>  drivers/staging/sm750fb/ddk750_chip.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/staging/sm750fb/ddk750_chip.c b/drivers/staging/sm750fb/ddk750_chip.c
> index c1356bb..76aaeaa 100644
> --- a/drivers/staging/sm750fb/ddk750_chip.c
> +++ b/drivers/staging/sm750fb/ddk750_chip.c
> @@ -71,7 +71,7 @@ static void setChipClock(unsigned int frequency)
>  		pll.clockType = MXCLK_PLL;
>  
>  		/*
> -		* Call calcPllValue() to fill up the other fields for PLL structure.
> +		* Call calcPllValue() to fill the other fields of PLL structure.
>  		* Sometime, the chip cannot set up the exact clock required by User.
>  		* Return value from calcPllValue() gives the actual possible clock.

You only changed one sentance here, please fix the whole block.

thanks,

greg k-h
