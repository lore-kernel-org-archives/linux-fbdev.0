From: =?windows-1252?Q?Markus_B=F6hme?= <markus.boehme@mailbox.org>
Date: Sun, 14 Jun 2015 18:45:02 +0000
Subject: Re: [PATCH] Staging: sm750fb: fix checkpatch.pl indentation warnings
Message-Id: <557DCBAE.8070109@mailbox.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20150614174339.GA6105@codebox>
In-Reply-To: <20150614174339.GA6105@codebox>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Dighe, Niranjan (N.)" <ndighe@visteon.com>
Cc: "sudipm.mukherjee@gmail.com" <sudipm.mukherjee@gmail.com>, "teddy.wang@siliconmotion.com" <teddy.wang@siliconmotion.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

> This patch fixes indentation issues by replacing spaces by tabs at
> the start of line
>
> Signed-off-by: Niranjan Dighe <ndighe@visteon.com>
>
> diff --git a/drivers/staging/sm750fb/ddk750_dvi.c b/drivers/staging/sm750fb/ddk750_dvi.c
> index b2bf7e6..c73b74a 100644
> --- a/drivers/staging/sm750fb/ddk750_dvi.c
> +++ b/drivers/staging/sm750fb/ddk750_dvi.c

> -	if(pCurrentDviCtrl->pfnInit != NULL)
> +	if (pCurrentDviCtrl->pfnInit != NULL)

You are fixing a different type of warning here. Please make only one
kind of change per patch.

Regards,
Markus

