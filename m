From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Mon, 28 Nov 2011 08:43:38 +0000
Subject: Re: [PATCH] video: convert drivers/video/* to use
Message-Id: <20111128084338.GR27267@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1322274354.10633.3.camel@phoenix>
In-Reply-To: <1322274354.10633.3.camel@phoenix>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Axel Lin <axel.lin@gmail.com>
Cc: linux-kernel@vger.kernel.org, Wan ZongShun <mcuos.com@gmail.com>, Lennert Buytenhek <buytenh@marvell.com>, Ben Dooks <ben@simtec.co.uk>, Alexey Charkov <alchark@gmail.com>, Damian Hobson-Garcia <dhobsong@igel.co.jp>, Manuel Lauss <mano@roarinelk.homelinux.net>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, linux-fbdev@vger.kernel.org

On Sat, Nov 26, 2011 at 10:25:54AM +0800, Axel Lin wrote:
> This patch converts the drivers in drivers/video/* to use the
> module_platform_driver() macro which makes the code smaller and a bit
> simpler.
> 
> Cc: Wan ZongShun <mcuos.com@gmail.com>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Lennert Buytenhek <buytenh@marvell.com>
> Cc: Ben Dooks <ben@simtec.co.uk>
> Cc: Alexey Charkov <alchark@gmail.com>
> Cc: Damian Hobson-Garcia <dhobsong@igel.co.jp>
> Cc: Manuel Lauss <mano@roarinelk.homelinux.net>
> Signed-off-by: Axel Lin <axel.lin@gmail.com>
> ---
>  drivers/video/mxsfb.c            |   13 +------------

For the mxsfb driver:

Acked-by: Sascha Hauer <s.hauer@pengutronix.de>

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
