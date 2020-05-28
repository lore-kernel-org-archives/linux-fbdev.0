From: Brian D Goldberg <bdg215@nyu.edu>
Date: Thu, 28 May 2020 19:32:01 +0000
Subject: modedb and CVT
Message-Id: <CAFRjJ8zpbD9iuJ2ofF1abJf_fAuDVDU7OzjDFhLRFpyBiu3dEA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-fbdev@vger.kernel.org

Hello:

I am attempting to get modedb to output a 15kHz Horizontal
320x240@60Hz signal. The standard VESA CEA mode 1,8 represents the
digital implementation of SD resolution re: BT.601
https://en.wikipedia.org/wiki/Rec._601

 Based on this information:

https://www.kernel.org/doc/html/v5.4/fb/modedb.html

It appears that modedb will pass my modeline set in the kernel to some
CVT timing calculator and lets that derive the timings. I have found
that this internal calculator doesn’t work, and using standard CVT
timing selections produces incorrect results in the following manner:

When selecting VESA Mode CEA 8, setting this mode in the kernel works
perfectly, as evidenced by correctly displayed boot screen and initial
pre-cmdline boot dialog. When cmdline parses and modedb sets the
framebuffer, display goes blank.

Modedb reports in /proc/cmdline video=HDMI-A-1:720x240M@60 but it does
not output a usable signal.

Since this signal is a standard VESA CEA mode, CVT should create the
mode correctly, but there is clearly something wrong going on with the
timings. Perhaps the CVT calculator is trying to produce a
line-doubled or line-quadrupled mode with 31kHz horizontal?

In any case, it’s not usable in the defined setup. Is this normal? Is
there a workaround such as defining a custom video mode for the modedb
pool with custom timings, etc?

I found this old document:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/EDID/HOWTO.txt?id=be53bfdb8088e9d1924199cc1a96e113756b1075

Which mentions a method to insert a custom EDID, but I don't follow
the method exactly. Is this something that could address the issue I
am having?


Thanks,
Brian Goldberg
