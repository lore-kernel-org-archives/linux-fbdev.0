From: Damian Hobson-Garcia <dhobsong@igel.co.jp>
Date: Mon, 28 Nov 2011 09:09:19 +0000
Subject: Re: [PATCH] video: convert drivers/video/* to use module_platform_driver()
Message-Id: <4ED34FBF.2020802@igel.co.jp>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1322274354.10633.3.camel@phoenix>
In-Reply-To: <1322274354.10633.3.camel@phoenix>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Axel Lin <axel.lin@gmail.com>
Cc: linux-kernel@vger.kernel.org, Wan ZongShun <mcuos.com@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>, Lennert Buytenhek <buytenh@marvell.com>, Ben Dooks <ben@simtec.co.uk>, Alexey Charkov <alchark@gmail.com>, Manuel Lauss <mano@roarinelk.homelinux.net>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, linux-fbdev@vger.kernel.org

On 2011/11/26 11:25, Axel Lin wrote:
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
>  drivers/video/nuc900fb.c         |   13 +------------
>  drivers/video/pxa168fb.c         |   12 +-----------
>  drivers/video/pxa3xx-gcu.c       |   15 +--------------
>  drivers/video/s3c-fb.c           |   13 +------------
>  drivers/video/sh7760fb.c         |   13 +------------
>  drivers/video/sh_mobile_lcdcfb.c |   13 +------------
>  drivers/video/sh_mobile_meram.c  |   13 +------------
>  drivers/video/sm501fb.c          |   13 +------------
>  drivers/video/vt8500lcdfb.c      |   13 +------------
>  drivers/video/w100fb.c           |   13 +------------
>  drivers/video/wm8505fb.c         |   13 +------------
>  drivers/video/wmt_ge_rops.c      |   13 +------------
>  drivers/video/xilinxfb.c         |   20 +-------------------
>  14 files changed, 14 insertions(+), 176 deletions(-)

for sh_mobile_meram.c

Acked-by: Damian Hobson-Garcia <dhobsong@igel.co.jp>

Thanks very much,
