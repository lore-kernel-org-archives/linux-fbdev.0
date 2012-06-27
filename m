From: Shawn Guo <shawn.guo@linaro.org>
Date: Wed, 27 Jun 2012 13:53:19 +0000
Subject: Re: [PATCH 0/2] simple device tree support for mxsfb
Message-Id: <20120627135317.GD9787@S2101-09.ap.freescale.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1340701379-8619-1-git-send-email-shawn.guo@linaro.org>
In-Reply-To: <1340701379-8619-1-git-send-email-shawn.guo@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Florian,

I have a mxs platform patch depends on these two patches to covert
a few board files over to device tree.  I would like to have the patches
go via arm-soc tree if they look good.  Please let me know if you have
problem with the patches go through arm-soc tree.  Thanks.

Regards,
Shawn

On Tue, Jun 26, 2012 at 05:02:57PM +0800, Shawn Guo wrote:
> It adds a simple device tree support for mxsfb driver.
> 
> Shawn Guo (2):
>   video: mxsfb: move mxsfb.h into include/linux
>   video: mxsfb: add simple device tree probe
> 
>  Documentation/devicetree/bindings/fb/mxsfb.txt     |   21 +++++++
>  arch/arm/mach-mxs/devices-mx23.h                   |    2 +-
>  arch/arm/mach-mxs/devices-mx28.h                   |    2 +-
>  arch/arm/mach-mxs/devices/platform-mxsfb.c         |    2 +-
>  drivers/video/mxsfb.c                              |   62 +++++++++++++++-----
>  .../include/mach => include/linux}/mxsfb.h         |    6 +-
>  6 files changed, 75 insertions(+), 20 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/fb/mxsfb.txt
>  rename {arch/arm/mach-mxs/include/mach => include/linux}/mxsfb.h (95%)
> 
> -- 
> 1.7.5.4
> 
> 

