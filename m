From: Joe Perches <joe@perches.com>
Date: Tue, 21 Jul 2015 08:14:41 +0000
Subject: Re: [PATCH 1/2] sm750fb: coding style fixes lines over 80 chars
Message-Id: <1437466481.28284.39.camel@perches.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1437461084-17565-1-git-send-email-simhavcs@gmail.com>
	 <1437464402-18451-1-git-send-email-simhavcs@gmail.com>
In-Reply-To: <1437464402-18451-1-git-send-email-simhavcs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Vinay Simha BN <simhavcs@gmail.com>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Teddy Wang <teddy.wang@siliconmotion.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "open list:STAGING - SILICON MOTION SM750 FRAME BUFFER DRIVER" <linux-fbdev@vger.kernel.org>, "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>, open list <linux-kernel@vger.kernel.org>

On Tue, 2015-07-21 at 13:10 +0530, Vinay Simha BN wrote:
> scripts/checkpatch.pl kernel coding style fixes of WARNING

Please run your patches through scripts/checkpatch.pl --strict

> diff --git a/drivers/staging/sm750fb/ddk750_power.h b/drivers/staging/sm750fb/ddk750_power.h
> index b7cf6b2..abad4fe 100644
> --- a/drivers/staging/sm750fb/ddk750_power.h
> +++ b/drivers/staging/sm750fb/ddk750_power.h
> @@ -12,9 +12,9 @@ DPMS_t;
>  #define setDAC(off) \
>  		{	\
>  		POKE32(MISC_CTRL, FIELD_VALUE(PEEK32(MISC_CTRL), \
> -									MISC_CTRL,	\
> -									DAC_POWER,	\
> -									off));	\
> +			MISC_CTRL,	\
> +			DAC_POWER,	\
> +			off));		\

This is used only once and might be better expanded
in-place instead.

It's a single statement macro and doesn't need
braces or a terminating ; and it shouldn't be
indented 2 tabs.

#define setDAC(off)							\
	POKE32(MISC_CTRL,						\
	       FIELD_VALUE(PEEK32(MISC_CTRL), MISC_CTRL, DAC_POWER,	\
			   off))

> diff --git a/drivers/staging/sm750fb/ddk750_sii164.h b/drivers/staging/sm750fb/ddk750_sii164.h
[]
> @@ -5,10 +5,11 @@
[]
> +	SII164_HOTPLUG_DISABLE = 0, /* Disable Hot Plug output bit
> +					(always high) */

comment style isn't correct
etc...


