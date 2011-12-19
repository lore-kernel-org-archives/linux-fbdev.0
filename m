From: Timur Tabi <timur@freescale.com>
Date: Mon, 19 Dec 2011 16:08:38 +0000
Subject: Re: Should I use FBINFO_VIRTFB?
Message-Id: <4EEF6186.1030901@freescale.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <4EEA5DA7.3010406@freescale.com>
In-Reply-To: <4EEA5DA7.3010406@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Geert Uytterhoeven wrote:
>> > I'm a little confused about panning support in my driver (which I didn't write -- I'm just cleaning it up).  There is .fb_pan_display function, but it only gets called early in the boot process, and only with xoffset=0 and yoffset=0.  After that, it never seems to get called again.  Under what circumstances is panning really used?

> Is yres_virtual larger than yres? Is the font size a multiple of ypanstep?
> If not, panning is disabled.

I can't seem to get partial panning to "activate", no matter what I do.  I set 'flags' to FBINFO_DEFAULT | FBINFO_VIRTFB | FBINFO_PARTIAL_PAN_OK | FBINFO_READS_FAST.  I have a 1280x1024 monitor.  I set the virtual_size to 1280,1280 via sysfs.  Then I set panning to "0,100", and I see the screen scroll.  I tried sending a bunch of output to /dev/tty1, but no matter what I do, none of the SCROLL_PAN_REDRAW or SCROLL_PAN_MOVE case statements in fbcon_scroll() get executed.

At this point, should I just FBINFO_VIRTFB | FBINFO_PARTIAL_PAN_OK | FBINFO_READS_FAST and not worry about whether it really makes a difference?

-- 
Timur Tabi
Linux kernel developer at Freescale

