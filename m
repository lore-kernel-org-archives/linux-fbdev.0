From: Maciej Rutecki <maciej.rutecki@gmail.com>
Date: Wed, 18 Aug 2010 18:46:37 +0000
Subject: [REGRESSION] [2.6.36-rc1] [DRM INTEL] [drm:intel_calculate_wm] *ERROR* Insufficient FIFO for plane,
Message-Id: <201008182046.37732.maciej.rutecki@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, airlied@linux.ie

Last known good: 2.6.35
Failing kernel: 2.6.36-rc1

During boot kernel display this message:
[    0.831906] [drm:intel_calculate_wm] *ERROR* Insufficient FIFO for plane, 
expect flickering: entries required = 36, available = 28.
[    0.895058] [drm:intel_calculate_wm] *ERROR* Insufficient FIFO for plane, 
expect flickering: entries required = 36, available = 28.
[    0.895066] [drm:intel_calculate_wm] *ERROR* Insufficient FIFO for plane, 
expect flickering: entries required = 36, available = 28.
[    0.895287] [drm:intel_calculate_wm] *ERROR* Insufficient FIFO for plane, 
expect flickering: entries required = 36, available = 28.
[    0.916426] [drm:intel_calculate_wm] *ERROR* Insufficient FIFO for plane, 
expect flickering: entries required = 36, available = 28.


Systems seems work OK, but in 2.6.35 I don't have this message. On another 
system with 2.6.36-rc1 kernel I have the same message.

lspci:
http://unixy.pl/maciek/download/kernel/2.6.36-rc1/zlom/lspci.txt
.config:
http://unixy.pl/maciek/download/kernel/2.6.36-rc1/zlom/config-2.6.36-rc1
dmesg:
http://unixy.pl/maciek/download/kernel/2.6.36-rc1/zlom/dmesg-2.6.36-rc1.txt

Regards
-- 
Maciej Rutecki
http://www.maciek.unixy.pl
