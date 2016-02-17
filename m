From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 17 Feb 2016 10:48:38 +0000
Subject: Re: [PATCH 0/7] fix IS_ERR_VALUE usage
Message-Id: <7443859.JK6ybmGO1A@wuerfel>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1455546925-22119-1-git-send-email-a.hajda@samsung.com>
In-Reply-To: <1455546925-22119-1-git-send-email-a.hajda@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Monday 15 February 2016 15:35:18 Andrzej Hajda wrote:
> 
> Andrzej Hajda (7):
>   netfilter: fix IS_ERR_VALUE usage
>   MIPS: module: fix incorrect IS_ERR_VALUE macro usages
>   drivers: char: mem: fix IS_ERROR_VALUE usage
>   atmel-isi: fix IS_ERR_VALUE usage
>   serial: clps711x: fix IS_ERR_VALUE usage
>   fbdev: exynos: fix IS_ERR_VALUE usage
>   usb: gadget: fsl_qe_udc: fix IS_ERR_VALUE usage
> 

Can you Cc me the next time on all of the patches? I only got
three of them this time.

	Arnd
