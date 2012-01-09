From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Mon, 09 Jan 2012 02:35:48 +0000
Subject: Re: [PATCH 0/6] video: s3c-fb: Use runtime suspend while blanked
Message-Id: <4F0A5284.7080009@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20111227141550.GA3331@opensource.wolfsonmicro.com>
In-Reply-To: <20111227141550.GA3331@opensource.wolfsonmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Jingoo Han <jg1.han@samsung.com>, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org

On 12/27/2011 02:15 PM, Mark Brown wrote:
> This patch series (the first two of which I posted the other day)
> improves the runtime power management in the s3c-fb driver by moving it
> to keeping the device runtime suspended when the screen is powered down
> by userspace.  This saves a trivial amount of power in the framebuffer
> controller and allows the SoC core code to enter system wide idle
> states which offer much more substantial gains.
> 
> Currently it's only lightly tested but it certainly seems to the right
> thing for me.

Applied all 6 patches of this series.


Thanks,

Florian Tobias Schandinat

> 
> Mark Brown (6):
>       video: s3c-fb: Make runtime PM functional again
>       video: s3c-fb: Use s3c_fb_enable() to enable the framebuffer
>       video: s3c-fb: Disable runtime PM in error paths from probe
>       video: s3c-fb: Take a runtime PM reference when unblanked
>       video: s3c-fb: Hold runtime PM references when touching registers
>       video: s3c-fb: Don't keep device runtime active when open
> 
>  drivers/video/s3c-fb.c |  127 ++++++++++++++++++++++++++++++++++-------------
>  1 files changed, 92 insertions(+), 35 deletions(-)
> 
> 

