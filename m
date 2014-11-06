From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Date: Thu, 06 Nov 2014 07:41:12 +0000
Subject: [PATCH RESEND 0/5] arm: sa1100: add cpu clock for fbdev and pcmcia
Message-Id: <1415259677-18770-1-git-send-email-dbaryshkov@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

These patches are required to make SL-5500 (collie) to work properly.
Framebuffer maintainer added his ack to the respective patch. PCMCIA
subsystem seems to be unmaintained at this moment. Russell, could you
please review and hopefully ack these patches?

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

