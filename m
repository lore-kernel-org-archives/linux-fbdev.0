From: Joe Perches <joe@perches.com>
Date: Thu, 16 Jul 2015 03:57:37 +0000
Subject: Re: [PATCH] sm750fb: coding style fixes lines over 80 chars
Message-Id: <1437019057.16262.22.camel@perches.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1436985972-5431-1-git-send-email-simhavcs@gmail.com>
In-Reply-To: <1436985972-5431-1-git-send-email-simhavcs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Vinay Simha BN <simhavcs@gmail.com>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Teddy Wang <teddy.wang@siliconmotion.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "open list:STAGING - SILICON MOTION SM750 FRAME BUFFER DRIVER" <linux-fbdev@vger.kernel.org>, "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>, open list <linux-kernel@vger.kernel.org>

On Thu, 2015-07-16 at 00:16 +0530, Vinay Simha BN wrote:
> scripts/checkpatch.pl kernel coding style fixes of WARNING

Please don't be a checkpatch robot.

Use tools to prompt your brain, but don't ever turn
your brain off.

> diff --git a/drivers/staging/sm750fb/ddk750_help.h b/drivers/staging/sm750fb/ddk750_help.h


> +/* if 718 big endian turned on,be aware that don't use this driver for general
> +	 use,only for ppc big-endian */
> +#warning "big endian on target cpu and enable nature big endian support of 718
> +	capability !"

Yes, this if #if 0, but it's also obviously incorrect

I didn't look at the rest.


