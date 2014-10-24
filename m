From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Date: Fri, 24 Oct 2014 10:37:22 +0000
Subject: [PATCH 0/5] arm: sa1100: fix sa1100 fb and pcmcia w/o cpufreq
Message-Id: <1414147047-12892-1-git-send-email-dbaryshkov@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hello,

These patches were sitting in my queue for some time. On SA-1100
framebuffer and PCMCIA drivers make use of cpufreq_get(0) function call
to determine the cpu frequency. Russell's commit
1937f5b91833e2e8e53bcc821fc7a5fbe6ccb9b5 (ARM: fix sa1100 build) fixed
the build issues, but broke two devices (Collie and Jornada720). For
those two boards the cpufreq code gets compiled but is not enabled (as
board files do not provide timing information for the CPUFREQ driver).
Thus cpufreq_get(0) returns incorrect values and incorrect timings get
programmed into the hardware.

PXA2xx (the very similar platform) uses Clock API to determine CPU
frequency both in framebuffer and PCMCIA drivers. These patches make
similar changes to StrongARM drivers.

These patches are required to make use of framebuffer and CF card on
Sharp Collie (and possibly on HP Jornada 720).

-- 
With best wishes
Dmitry
