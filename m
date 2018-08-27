From: Greg KH <gregkh@linuxfoundation.org>
Date: Mon, 27 Aug 2018 17:49:15 +0000
Subject: Re: [PATCH] ddk750_mode.c: Wraps line to 80 charecters
Message-Id: <20180827174915.GB27089@kroah.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180808093552.2248-1-abishekvashok@gmail.com>
In-Reply-To: <20180808093552.2248-1-abishekvashok@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Abishek V Ashok <abishekvashok@gmail.com>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org

On Wed, Aug 08, 2018 at 03:05:52PM +0530, Abishek V Ashok wrote:
> Splits definition of function programModeRegisters into two lines such
> that each line is less than 80 characters.
> 
> Signed-off-by: Abishek V Ashok <abishekvashok@gmail.com>
> ---
>  drivers/staging/sm750fb/ddk750_mode.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Please put the subsystem in the subject line to make it harder to miss
your patch, you need a "staging:" in there, like all other patches for
drivers/staging/

Please fix up and resend.


thanks,

greg k-h
