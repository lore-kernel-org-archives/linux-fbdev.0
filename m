From: Tony Lindgren <tony@atomide.com>
Date: Mon, 05 May 2014 18:41:38 +0000
Subject: Re: [PATCH 0/4] OMAPDSS: Add support for panel ls037v7dw01
Message-Id: <20140505184138.GB15463@atomide.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1398815562-24113-1-git-send-email-tony@atomide.com>
In-Reply-To: <1398815562-24113-1-git-send-email-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

* Tony Lindgren <tony@atomide.com> [140429 16:53]:
> Hi all,
> 
> Here are few patches to add devicetree support for panel ls037v7dw01
> that's found on many omap3 boards. They seem to be often mis-configured
> as various panel dpi entries, but really should be move to use panel
> ls037v7dw01 instead. This panel is found at least on the omap3 sdp,
> ldp, omap3 evm and few other development boards.

Tomi, assuming no more comments, do you want to pick up the first
three patches of this series? I can queue the .dts changes or you
can also set up a separate .dts changes branch for DSS that I can
merge in too.

Tony
 
> Regards,
> 
> Tony
> 
> Tony Lindgren (4):
>   OMAPDSS: Fix DSS clock multiplier issue on 3703 and probably 3630
>   OMAPDSS: panel-sharp-ls037v7dw01: update to use gpiod
>   OMAPDSS: panel-sharp-ls037v7dw01: add device tree support
>   ARM: dts: Add LCD panel sharp ls037v7dw01 support for omap3-evm and
>     ldp
> 
>  .../bindings/panel/sharp,ls037v7dw01.txt           |  53 +++++++
>  .../arm/boot/dts/omap-panel-sharp-ls037v7dw01.dtsi |  82 ++++++++++
>  arch/arm/boot/dts/omap3-evm-37xx.dts               |  50 ++++++
>  arch/arm/boot/dts/omap3-evm-common.dtsi            |  47 ++++++
>  arch/arm/boot/dts/omap3-ldp.dts                    |  31 +++-
>  .../omap2/displays-new/panel-sharp-ls037v7dw01.c   | 176 ++++++++++++++-------
>  drivers/video/fbdev/omap2/dss/dss.c                |   5 +-
>  7 files changed, 379 insertions(+), 65 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/panel/sharp,ls037v7dw01.txt
>  create mode 100644 arch/arm/boot/dts/omap-panel-sharp-ls037v7dw01.dtsi
> 
> -- 
> 1.8.1.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
