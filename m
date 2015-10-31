From: Pavel Machek <pavel@ucw.cz>
Date: Sat, 31 Oct 2015 20:13:44 +0000
Subject: Mobility Radeon HD 4530/4570/545v: flicker in 1920x1080
Message-Id: <20151031201344.GA30459@amd>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: alexander.deucher@amd.com, christian.koenig@amd.com, dri-devel@lists.freedesktop.org, kernel list <linux-kernel@vger.kernel.org>, linux-fbdev@vger.kernel.org

Hi!

4.3-rc7 kernel, graphics works reasonably well in 1600x1200 mode. But
my monitor is native 1920x1080, so that mode looks pretty ugly on
screen. If I go to 1920x1080, I see colored horizontal lines (often
black) as soon as there's graphics activity.

pavel@half:~$ xrandr
Screen 0: minimum 320 x 200, current 1920 x 1080, maximum 8192 x 8192
VGA-0 connected 1920x1080+0+0 (normal left inverted right x axis y
axis) 478mm x 268mm
   1920x1080     60.00*+
      1600x1200     60.00
         1680x1050     59.95
	    1280x1024     75.02    60.02
	       1440x900      59.89
	          1024x768      75.08    60.00
		     800x600       75.00    60.32
		        640x480       75.00    60.00
			   720x400       70.08
 pavel@half:~$ xrandr --output VGA-0 --mode 1600x1200
 pavel@half:~$ xrandr --output VGA-0 --mode 1920x1080
 pavel@half:~$ xrandr --output VGA-0 --mode 1600x1200
			   

This is Acer notebook,

01:00.0 VGA compatible controller: Advanced Micro Devices,
Inc. [AMD/ATI] RV710/M92 [Mobility Radeon HD 4530/4570/545v]

Ouch, and power consumption seems to be 8W too high. (25W instead of
17W), I believe it started when I added radeon firmware, but will
check. It does not go lower even when I switch to text console.

Any ideas?

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
