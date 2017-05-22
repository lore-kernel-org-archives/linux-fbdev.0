From: Greg KH <gregkh@linuxfoundation.org>
Date: Mon, 22 May 2017 13:41:35 +0000
Subject: Re: [PATCH] Fixed cameCase check in file drivers/staging/sm750fb/ddk750_chip.c
Message-Id: <20170522134135.GB7129@kroah.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1495455091-25431-1-git-send-email-richaj@cdac.in>
In-Reply-To: <1495455091-25431-1-git-send-email-richaj@cdac.in>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Richa Jha <richaj@cdac.in>
Cc: devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org, teddy.wang@siliconmotion.com, linux-kernel@vger.kernel.org, sudipm.mukherjee@gmail.com

On Mon, May 22, 2017 at 05:41:31PM +0530, Richa Jha wrote:
> Changes :
> 
> ulActualMxClk ---> ul_actual_max_clk
> pInitParam    ---> p_init_param

I can see that from the patch, but _why_ are you doing this?

And please fix up your subject to match others for this driver, you can
find that in 'git log FILENAME'

thanks,

greg k-h
