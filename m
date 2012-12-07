From: Afzal Mohammed <afzal@ti.com>
Date: Fri, 07 Dec 2012 11:55:18 +0000
Subject: [PATCH 00/10] video: da8xx-fb: runtime timing configuration and cleanup
Message-Id: <cover.1354874432.git.afzal@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Vaibhav Hiremath <hvaibhav@ti.com>, Sekhar Nori <nsekhar@ti.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hi,

This series makes da8xx-fb driver (device found on DaVinci and AM335x)
capable of handling runtime timing configuration by adding fb_set_par.

The last change adds actual fb_set_par support. Other preceeding
changes makes the way clear for it as well as does certain cleanup's
on the way.

This has been tested on DA850 EVM.

Not sure whether Florian or Tomi would be handling fbdev patches after
the coming merge window, as Tomi is queueing fbdev patches currently,
these changes has been made over Tomi Valkeinen's for-next branch.

Regards
Afzal

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

 drivers/video/da8xx-fb.c | 181 +++++++++++++++++++++++++++--------------------
 1 file changed, 105 insertions(+), 76 deletions(-)

-- 
1.7.12

