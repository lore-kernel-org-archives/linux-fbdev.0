From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Tue, 29 May 2012 06:21:07 +0000
Subject: Re: [PATCH v2] video: bfin_adv7393fb: Fix cleanup code
Message-Id: <20120529062107.GA21008@mwanda>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1338224091-8322-1-git-send-email-emilgoode@gmail.com>
In-Reply-To: <1338224091-8322-1-git-send-email-emilgoode@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Emil Goode <emilgoode@gmail.com>
Cc: FlorianSchandinat@gmx.de, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

On Mon, May 28, 2012 at 06:54:51PM +0200, Emil Goode wrote:
> This patch fixes the cleanup code of the bfin_adv7393_fb_probe
> function.
> 
> 1) The resources were not freed in the order that we allocated them
>    so we call dma_free_coherent() before it was allocated.
> 2) The labels weren't in the right place which also meant that we
>    freed resources that weren't allocated.
> 3) We should free gpio_free(P_IDENT(P_PPI0_FS3)) before returning.
> 4) Lets change the label names into something more meaningful.
> 
> Signed-off-by: Emil Goode <emilgoode@gmail.com>
> ---

Yep.  Looks great.

I see the goto free_ppi_pins;  I look up a couple lines.  I see that
yeah, it makes sense to free the ppi_pins.  I hit the '*' key in vim
I see that the label does exactly what it says.  Move on.

Bing.  Bang.  Boom.

regards,
dan carpenter

