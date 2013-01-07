From: Afzal Mohammed <afzal@ti.com>
Date: Mon, 07 Jan 2013 05:13:30 +0000
Subject: [PATCH v2 00/10] video: da8xx-fb: runtime timing configuration
Message-Id: <cover.1357303978.git.afzal@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, nsekhar@ti.com, hvaibhav@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree-discuss@lists.ozlabs.org

Hi,

This series makes da8xx-fb driver (device found on DaVinci and AM335x)
capable of handling runtime timing configuration by adding fb_set_par.

The last change adds actual fb_set_par support. Other preceeding
changes makes the way clear for it as well as does certain cleanup's
on the way.

This has been tested on da850 evm as is. This was also tested on
am335x-evm & am335x-evmsk with a series that adds DT support which
follows shortly.

This is based on v3.8-rc2

Regards
Afzal

v2: disable raster in fb_set_par properly

Afzal Mohammed (10):
  video: da8xx-fb: fb_check_var enhancement
  video: da8xx-fb: simplify lcd_reset
  video: da8xx-fb: use modedb helper to update var
  video: da8xx-fb: remove unneeded "var" initialization
  video: da8xx-fb: store current display information
  video: da8xx-fb: store clk rate even if !CPUFREQ
  video: da8xx-fb: pix clk and clk div handling cleanup
  video: da8xx-fb: store struct device *
  video: da8xx-fb: report correct pixclock
  video: da8xx-fb: fb_set_par support

 drivers/video/da8xx-fb.c |  181 +++++++++++++++++++++++++++-------------------
 1 file changed, 105 insertions(+), 76 deletions(-)

-- 
1.7.9.5

