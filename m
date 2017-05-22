From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Mon, 22 May 2017 11:51:58 +0000
Subject: Re: [PATCH] Fixed cameCase check in file drivers/staging/sm750fb/ddk750_chip.c
Message-Id: <20170522115158.sarc4wdluqiinw4w@mwanda>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1495449937-24573-1-git-send-email-richaj@cdac.in>
In-Reply-To: <1495449937-24573-1-git-send-email-richaj@cdac.in>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Richa Jha <richaj@cdac.in>
Cc: gregkh@linuxfoundation.org, devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org, teddy.wang@siliconmotion.com, linux-kernel@vger.kernel.org, sudipm.mukherjee@gmail.com

On Mon, May 22, 2017 at 04:15:37PM +0530, Richa Jha wrote:
> Changes :
> 
> ulActualMxClk ---> ul_actual_max_clk
> p_init_param  ---> pInitParam

It doesn't touch p_init_param.

> -------------------------------------------------------------------------------------------------------------------------------
> [ C-DAC is on Social-Media too. Kindly follow us at:
> Facebook: https://www.facebook.com/CDACINDIA & Twitter: @cdacindia ]
> 
> This e-mail is for the sole use of the intended recipient(s) and may
> contain confidential and privileged information. If you are not the
> intended recipient, please contact the sender by reply e-mail and destroy
> all copies and the original message. Any unauthorized review, use,
> disclosure, dissemination, forwarding, printing or copying of this email
> is strictly prohibited and appropriate legal action will be taken.
> -------------------------------------------------------------------------------------------------------------------------------

These non-disclosure things aren't allowed.

regards,
dan carpenter

