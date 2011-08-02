From: Damian Hobson-Garcia <dhobsong@igel.co.jp>
Date: Tue, 02 Aug 2011 08:43:51 +0000
Subject: Re: [PATCH 1/4] fbdev: sh_mobile_meram: Replace hardcoded register
Message-Id: <4E37B8C7.3050408@igel.co.jp>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi Laurent,

> -#define MExxCTL 0x0
> -#define MExxBSIZE 0x4
> -#define MExxMNCF 0x8
> -#define MExxSARA 0x10
> -#define MExxSARB 0x14
> -#define MExxSBSIZE 0x18
[snip]
> +#define MExxCTL			0x400
> +#define MExxBSIZE		0x404
> +#define MExxMNCF		0x408
> +#define MExxSARA		0x410
> +#define MExxSARB		0x414
> +#define MExxSBSIZE		0x418

One small comment on the definition of these register offsets and
explanation of what I was originally thinking.  Since each of these
actually reprents a series of registers, one per ICB, (i.e. ME00CTL,
ME01CTL, etc.) it makes sense to me to represent them as an offset from
the base address (0x400) + the start of each ICB address (0x20 * index).

Other than that, looks great.

Thanks very much,
Damian

