From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Wed, 22 Mar 2017 06:01:38 +0000
Subject: Re: staging: iio: Replace a bit shift by a use of BIT.
Message-Id: <20170322060138.GA13416@kroah.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170322024942.GA21242@arushi-HP-Pavilion-Notebook>
In-Reply-To: <20170322024942.GA21242@arushi-HP-Pavilion-Notebook>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arushi Singhal <arushisinghal19971997@gmail.com>
Cc: outreachy-kernel@googlegroups.com, devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org, Teddy Wang <teddy.wang@siliconmotion.com>, linux-kernel@vger.kernel.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>

On Wed, Mar 22, 2017 at 08:19:42AM +0530, Arushi Singhal wrote:
> This patch replaces bit shifting on 1 with the BIT(x) macro.
> This was done with coccinelle:
> @@
> constant c;
> @@
> 
> -1 << c
> +BIT(c)
> 
> Signed-off-by: Arushi Singhal <arushisinghal19971997@gmail.com>
> ---
>  drivers/staging/iio/adc/ad7816.c |  2 +-
>  drivers/staging/iio/cdc/ad7150.c |  2 +-
>  drivers/staging/iio/cdc/ad7746.c | 22 +++++++++++-----------
>  3 files changed, 13 insertions(+), 13 deletions(-)

Please be careful about your cc: list, you missed the correct list, and
added one not needed at all.  And you forgot the [PATCH] prefix :(

thanks,

greg k-h
