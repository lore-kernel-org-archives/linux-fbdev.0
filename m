From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Mon, 06 Nov 2017 08:53:29 +0000
Subject: Re: [PATCH] video: atmel_lcdfb: Use common error handling code in atmel_lcdfb_of_init()
Message-Id: <20171106085329.szz2ocu5d2iurlov@mwanda>
List-Id: <linux-fbdev.vger.kernel.org>
References: <2db677d2-ad4e-1f79-344b-dfa38ce948c9@users.sourceforge.net>
 <5477205e-2067-de4f-8736-71a2c9dc1653@microchip.com>
In-Reply-To: <5477205e-2067-de4f-8736-71a2c9dc1653@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org, SF Markus Elfring <elfring@users.sourceforge.net>

On Mon, Nov 06, 2017 at 09:40:19AM +0100, Nicolas Ferre wrote:
> If you want to lower the size of strings in this driver, you can do it,
> but not like this.

Just so we're clear, GCC already detects and combines it when you use
the same string constant twice.

regards,
dan carpenter
