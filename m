From: Ran Shalit <ranshalit@gmail.com>
Date: Mon, 23 Nov 2015 19:41:12 +0000
Subject: How to disable timing configuration ?
Message-Id: <CAJ2oMhLUVf_c4zPX44UrXcmZ2=iDrL-146Ub4OXSXYALVj65qQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hello,

I need to configure fbdev to have the following configuration:

mode "240x320-0"
# D: 0.000 MHz, H: 0.000 kHz, V: 0.000 Hz
geometry 240 320 240 320 16
timings 0 0 0 0 0 0 0
accel false
rgba 5/11,6/5,5/0,0/0
endmode

But on trying to configure the above in /etc/fb.modes I get error

/etc/fb.modes:5: syntax error

I then tried to configure it using fbset, but I can't manage to make
it show the line
timings 0 0 0 0 0 0 0

I think the zeros mean that it is configured externally ?

How should I configure fbdev so that it will be resulted in the above
configuration ?

Thanks,
Ran
