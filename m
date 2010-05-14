From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Date: Fri, 14 May 2010 07:23:34 +0000
Subject: Re: [PATCH v2 0/2] DSS2:Allow FB to build without VRFB
Message-Id: <1273821814.2814.63.camel@tubuntu.research.nokia.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1273764028-25822-1-git-send-email-svadivu@ti.com>
In-Reply-To: <1273764028-25822-1-git-send-email-svadivu@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ext Senthilvadivu Guruswamy <svadivu@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "hvaibhav@ti.com" <hvaibhav@ti.com>

Hi,

On Thu, 2010-05-13 at 17:20 +0200, ext Senthilvadivu Guruswamy wrote:
> From: Senthilvadivu Guruswamy  <svadivu@ti.com>
> 
> Hi all,
> 
> This patch series replaces the patch 
> "DSS2 Include VRFB into omap2-3build only"
> Thanks for the review comments. 
> 
> The intent of this series is to split the patch into 2 logical
> patches and also to incorporate the comments on multi-omap build.
> 
> In this series, Kconfig is changed to have 
> OMAP2_VRFB depend on ARCH_OMAP2 and ARCH_OMAP3.
> This change takes care of the multi-omap builds. 
> 
> This patch would allow successful build of omap_4430sdp_defconfig 
> when OMAP2_DSS and FB_OMAP2 is enabled from menuconfig.
> 
> For verification: Generated the .config on omap3_defconfig with DSS
> and FB enabled. Generated .config is same with and without the patch.
> 
> List of Changed Files:
> arch/arm/plat-omap/include/plat/vrfb.h
> drivers/video/omap2/Kconfig
> drivers/video/omap2/omapfb/Kconfig

The patch set makes VRFB optional. What happens if VRFB is turned off,
and the user uses VRFB for a framebuffer?

 Tomi


