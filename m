From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Date: Mon, 24 Nov 2014 23:05:30 +0000
Subject: [PATCH V2 0/6] ARM: sa1100: use clock api to get cpu freq in fb and pcmcia drivers
Message-Id: <1416870336-30114-1-git-send-email-dbaryshkov@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

[Changes since V1:
- reorder patches to add sa1100 and sa1111 clocks before using them
  in sa1100 pcmcia driver.
- Fix error returns in case clk_get returns an error.
- Call clk_prepare_enable/clk_disable_unprepare for the proper API
  usage.]

On SA-1100 framebuffer and PCMCIA drivers make use of cpufreq_get(0)
function call to determine the cpu frequency. Russell's commit
1937f5b91833e2e8e53bcc821fc7a5fbe6ccb9b5 (ARM: fix sa1100 build) fixed
the build issues, but broke two devices (Collie and Jornada720). For
those two boards the cpufreq code gets compiled but is not enabled (as
board files do not provide timing information for the CPUFREQ driver).
Thus cpufreq_get(0) returns incorrect value and incorrect timings get
programmed into the hardware.

PXA2xx (the very similar platform) uses Clock API to determine CPU
frequency both in framebuffer and PCMCIA drivers. These patches make
similar changes to StrongARM drivers.

--
With best wishes
Dmitry

