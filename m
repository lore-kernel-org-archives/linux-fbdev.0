From: Shawn Guo <shawn.guo@linaro.org>
Date: Wed, 24 Apr 2013 11:49:45 +0000
Subject: Re: [PATCH 0/2] drivers/video: mxs-fb: build fixes
Message-Id: <20130424114943.GA2736@S2101-09.ap.freescale.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1366790894-20426-1-git-send-email-mpa@pengutronix.de>
In-Reply-To: <1366790894-20426-1-git-send-email-mpa@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed, Apr 24, 2013 at 10:08:12AM +0200, Markus Pargmann wrote:
> Hi,
> 
> mxs-fb commit
> 
> 669406534b4abb827d1bdc39bb5e2d5255818ae2 video: mxsfb: get display timings from device tree
> 
> creates a build failure together with those commits:
> 
> a38884f681a4d044befd30d9f3d19a0821bae63a videomode: simplify videomode Kconfig and Makefile
> 6cd2c7db41eab204b6474534df4ca68a7dc53d86 videomode: videomode_from_timing work
> 
> All of them are in linux-next, so mxs-fb fails to build there.

Fabio already had a patch [1] for that.  I will send it mainline during
3.10-rc.

Shawn

[1] http://thread.gmane.org/gmane.linux.ports.arm.kernel/230938

