From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 30 Nov 2017 10:54:07 +0000
Subject: Re: [PATCH v3 0/4] Fixes for omapdrm on OpenPandora and GTA04
Message-Id: <27b12bc8-2c3a-6caa-c800-158b75f80d3f@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1511884135.git.hns@goldelico.com>
In-Reply-To: <cover.1511884135.git.hns@goldelico.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "H. Nikolaus Schaller" <hns@goldelico.com>, Thierry Reding <thierry.reding@gmail.com>, David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Julia Lawall <Julia.Lawall@lip6.fr>, Sean Paul <seanpaul@chromium.org>
Cc: devicetree@vger.kernel.org, linux-fbdev@vger.kernel.org, letux-kernel@openphoenux.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, kernel@pyra-handheld.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 28/11/17 17:48, H. Nikolaus Schaller wrote:
> Changes V3:
> * stay compatible with old DTB files which still use "toppoly" (suggested by Tomi Valkeinen)
> * replaced MODULE_ALIAS entries by MODULE_DEVICE_TABLE (suggested by Andrew F. Davis)
> * removed DSI VDDS patch as it has already been accepted
> 
> 2017-11-16 09:50:22: Changes V2:
> * replaced patch to fix DSI VDDS for OMAP3 by equivalent patch from Laurent Pinchart
> * keep previous compatibility option in panel driver to handle older device tree binaries
> 
> 2017-11-08 22:09:36:
> This patch set fixes vendor names of the panels
> and fixes a problem on omapdrm with enabling
> VDD_DSI for OMAP3 which is needed for displaying
> the Red and Green channel on OMAP3530 (Pandora).
> 
> H. Nikolaus Schaller (4):
>   omapdrm: panel: fix compatible vendor string for td028ttec1
>   omapdrm: panel: td028ttec1: replace MODULE_ALIAS by
>     MODULE_DEVICE_TABLE
>   DTS: GTA04: fix panel compatibility string
>   DTS: Pandora: fix panel compatibility string
> 
>  .../panel/{toppoly,td028ttec1.txt => tpo,td028ttec1.txt}    |  4 ++--
>  arch/arm/boot/dts/omap3-gta04.dtsi                          |  2 +-
>  arch/arm/boot/dts/omap3-pandora-common.dtsi                 |  2 +-
>  drivers/gpu/drm/omapdrm/displays/panel-tpo-td028ttec1.c     | 13 ++++++++++++-
>  .../fbdev/omap2/omapfb/displays/panel-tpo-td028ttec1.c      | 12 +++++++++++-
>  5 files changed, 27 insertions(+), 6 deletions(-)
>  rename Documentation/devicetree/bindings/display/panel/{toppoly,td028ttec1.txt => tpo,td028ttec1.txt} (84%)
> 

Thanks. I have picked up patches 1 and 2.

3 can be applied when 1 & 2 are in. The change in 4 could be applied
independently, but it conflicts with 3.

Tony, how do you want to handle 3 and 4? I will push 1 and 2 to v4.16. I
don't think they are real issues, so I don't see a reason to push them
as fixes to v4.15. I think they are mostly just cleanups, and we might
as well wait until v4.17, but that's quite far away...

 Tomi

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
