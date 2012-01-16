From: Timur Tabi <timur@freescale.com>
Date: Mon, 16 Jan 2012 16:12:27 +0000
Subject: Re: [PATCH] drivers/video: compile fixes for fsl-diu-fb.c
Message-Id: <4F144C6B.4020706@freescale.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <19504.1326673788@neuling.org> <4F1370C9.9010400@freescale.com>
 <21913.1326675139@neuling.org> <4F138CBB.1080901@freescale.com>
 <21370.1326683320@neuling.org>
In-Reply-To: <21370.1326683320@neuling.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michael Neuling <mikey@neuling.org>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>

Michael Neuling wrote:
> drivers/video/fsl-diu-fb.c: In function 'fsl_diu_suspend':
> drivers/video/fsl-diu-fb.c:1435: error: incompatible type for argument 1 of 'disable_lcdc'
> drivers/video/fsl-diu-fb.c:592: note: expected 'struct fb_info *' but argument is of type 'struct fb_info'
> drivers/video/fsl-diu-fb.c: In function 'fsl_diu_resume':
> drivers/video/fsl-diu-fb.c:1445: error: incompatible type for argument 1 of 'enable_lcdc'
> drivers/video/fsl-diu-fb.c:583: note: expected 'struct fb_info *' but argument is of type 'struct fb_info'

I figured out what the problem is.  I never compiled a configuration with
CONFIG_PM enabled.  For some reason, CONFIG_PM is disabled when SMP is
enabled, and I only tested with mpc85xx_smp_defconfig.

-- 
Timur Tabi
Linux kernel developer at Freescale

