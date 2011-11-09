From: kuninori.morimoto.gx@renesas.com
Date: Wed, 09 Nov 2011 04:32:19 +0000
Subject: [PATCH 0/15] fbdev: sh_mipi_dsi: care un-explained register settings
Message-Id: <874nydc3vz.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org


Dear Florian, Paul

These are sh_mipi_dsi update patches.

Kuninori Morimoto (15):
      fbdev: sh_mobile_lcdcfb: fixup LDHAJR :: HSYNPAJ needs mask
      fbdev: sh_mipi_dsi: tidyup dsip_clk
      fbdev: sh_mipi_dsi: typo fix of SH_MIPI_DSI_HBPBM
      fbdev: sh_mipi_dsi: tidyup VMCTR2 parameter expression
      fbdev: sh_mipi_dsi: add SH_MIPI_DSI_HFPBM flag
      fbdev: sh_mipi_dsi: add SH_MIPI_DSI_BL2E flag
      fbdev: sh_mipi_dsi: add lane control support
      fbdev: sh_mipi_dsi: add sync_pulses/sync_events/burst mode
      fbdev: sh_mipi_dsi: add VMLEN1/VMLEN2 calculation
      fbdev: sh_mipi_dsi: add set_dot_clock() for each platform
      fbdev: sh_mipi_dsi: add HSxxCLK support
      fbdev: sh_mipi_dsi: sh_mipi has pdata instead of dev
      fbdev: sh_mipi_dsi: fixup setup timing of sh_mipi_setup()
      fbdev: sh_mipi_dsi: fixup setup timing of SYSCONF
      fbdev: sh_mipi_dsi: fixup setup timing DSICTRL

SH MIPI DSI has many registers, but some registers are not explained for detail in SH manual.
This time, I asked it to Renesas MIPI guys.
These patches include this result.

for example, if your board is using AP5R chip,
HS4divCLK is needed for 1920x1080p 60Hz output.
But you can NOT find its explain and calculation method on AP5R manual.

These are based on latest linus/master tree

>> Paul

Can you please check #2, #7, #8, #10, #11 pache which modify arch/arm/mach-shmobile/xxx
