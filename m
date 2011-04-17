From: Maciej Rutecki <maciej.rutecki@gmail.com>
Date: Sun, 17 Apr 2011 16:04:04 +0000
Subject: [REGRESSION] [2.6.39-rc3] Wrong resolution in framebuffer and X Window
Message-Id: <201104171804.04664.maciej.rutecki@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, mbroemme@plusserver.de, airlied@linux.ie, dri-devel@lists.freedesktop.org, "Rafael J. Wysocki" <rjw@sisk.pl>

Hi

Last known good: 2.6.38
Failing kernel: 2.6.39-rc3
Subsystem: Intel graphics driver.

Description:
PC should work with 1440x900 resolution. But console (and after) X Window 
start work with 1024x768. 

I attach dmesg and Xorg.0.log with drm.debug log_buf_lenM options:
http://unixy.pl/maciek/download/kernel/2.6.39-rc1/zlom/kms/

seems that driver cannot detect resolution higher than 1024x768.

Also I boot kernel replace "i915.modeset=1" with "nomodeset" option:
http://unixy.pl/maciek/download/kernel/2.6.39-rc1/zlom/nomodeset/

But then X Window fails to start and got message: "(EE) No devices detected."

Config for 2.6.39-rc3:
http://unixy.pl/maciek/download/kernel/2.6.39-rc1/zlom/config-2.6.39-rc3

Best regards
-- 
Maciej Rutecki
http://www.maciek.unixy.pl
