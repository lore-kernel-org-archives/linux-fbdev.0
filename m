From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Mon, 06 Nov 2017 09:53:45 +0000
Subject: Re: video: atmel_lcdfb: Use common error handling code in atmel_lcdfb_of_init()
Message-Id: <20171106095345.ds5ftmdmq4xjnadg@mwanda>
List-Id: <linux-fbdev.vger.kernel.org>
References: <2db677d2-ad4e-1f79-344b-dfa38ce948c9@users.sourceforge.net>
 <5477205e-2067-de4f-8736-71a2c9dc1653@microchip.com>
 <20171106085329.szz2ocu5d2iurlov@mwanda>
 <5e11db02-618e-ac60-921f-2971458a4484@users.sourceforge.net>
In-Reply-To: <5e11db02-618e-ac60-921f-2971458a4484@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org, Nicolas Ferre <nicolas.ferre@microchip.com>

On Mon, Nov 06, 2017 at 10:00:25AM +0100, SF Markus Elfring wrote:
> >> If you want to lower the size of strings in this driver, you can do it,
> >> but not like this.
> > 
> > Just so we're clear, GCC already detects and combines it when you use
> > the same string constant twice.
> 
> Do you distinguish between merging of constants and the combination
> of statements for such an use case?

I would have rejected the patch even if GCC didn't combine the strings
because the most important thing is that the code is readable.

regards,
dan carpenter

