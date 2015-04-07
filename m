From: Pavel Machek <pavel@ucw.cz>
Date: Tue, 07 Apr 2015 12:12:47 +0000
Subject: simple framebuffer slower by factor of 20, on socfpga (arm) platform
Message-Id: <20150407121247.GA29497@amd>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Marek Vasut <marek.vasut@gmail.com>, kernel list <linux-kernel@vger.kernel.org>, dinh.linux@gmail.com
Cc: plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, grant.likely@linaro.org, robh+dt@kernel.org, jg1.han@samsung.com, robdclark@gmail.com, geert@linux-m68k.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org

Hi!

I have an socfpga board, which uses has simple framebuffer implemented
in the FPGA. On 3.15, framebuffer is fast:

root@wagabuibui:~# time cat /dev/fb0 > /dev/null
real		   0m 0.00s
user		   0m 0.00s
sys		   0m 0.00s

on 3.18, this takes 220msec. Similar slowdown exists for
writes. Simple framebuffer did not change at all between 3.15 and
3.18; resource flags of the framebuffer are still same (0x200).

If I enable caching on 3.18, it speeds up a bit, to 70msec or
so... Which means problem is not only in caching.

Any ideas?

Best regards,
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
