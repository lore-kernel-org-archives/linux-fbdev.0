From: Timur Tabi <timur@freescale.com>
Date: Mon, 16 Jan 2012 16:12:54 +0000
Subject: Re: [PATCH] drivers/video: compile fixes for fsl-diu-fb.c
Message-Id: <4F144C86.5000403@freescale.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <19504.1326673788@neuling.org> <4F1370C9.9010400@freescale.com>
 <21913.1326675139@neuling.org> <4F138CBB.1080901@freescale.com>
 <21370.1326683320@neuling.org>
In-Reply-To: <21370.1326683320@neuling.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michael Neuling <mikey@neuling.org>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>

Michael Neuling wrote:
> From: Michael Neuling <mikey@neuling.org>
> 
> [PATCH] drivers/video: compile fixes for fsl-diu-fb.c
> 
> Fix a compiler errors introduced in:
>   commit ddd3d905436b572ebadc09dcf2d12ca5b37020a0
>   Author: Timur Tabi <timur@freescale.com>
>   drivers/video: fsl-diu-fb: merge all allocated data into one block
> 
> Signed-off-by: Michael Neuling <mikey@neuling.org>

Acked-by: Timur Tabi <timur@freescale.com>

-- 
Timur Tabi
Linux kernel developer at Freescale

