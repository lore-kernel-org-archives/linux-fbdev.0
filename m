From: Lennert Buytenhek <buytenh@wantstofly.org>
Date: Mon, 28 Nov 2011 10:01:42 +0000
Subject: Re: [PATCH] video: convert drivers/video/* to use
Message-Id: <20111128100142.GW795@wantstofly.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1322274354.10633.3.camel@phoenix>
In-Reply-To: <1322274354.10633.3.camel@phoenix>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Mon, Nov 28, 2011 at 02:41:14AM +0000, Jingoo Han wrote:

> > -----Original Message-----
> > Subject: [PATCH] video: convert drivers/video/* to use
> > module_platform_driver()
> > 
> > This patch converts the drivers in drivers/video/* to use the
> > module_platform_driver() macro which makes the code smaller and a bit
> > simpler.
> > 
> > Cc: Wan ZongShun <mcuos.com@gmail.com>
> > Cc: Sascha Hauer <s.hauer@pengutronix.de>
> > Cc: Lennert Buytenhek <buytenh@wantstofly.org>

For pxa168fb:

Acked-by: Lennert Buytenhek <buytenh@wantstofly.org>
