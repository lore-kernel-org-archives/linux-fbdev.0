From: Ran Shalit <ranshalit@gmail.com>
Date: Wed, 25 Nov 2015 20:02:16 +0000
Subject: image disappear
Message-Id: <CAJ2oMhJ+4N2hKH7PUT02pVRZLS32+pvWg9CYszy7iyX5pbLitQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hello,

I am working on embedded project with LCD 240x320 (width is 240)
When I render image to framebuffer, I see for a split of a second and
than it disappear.
Is there any explanation for such behaviour ?

I first suspected the timing parameters which I've configured.
But when I use test bar color from the cpu it is seen stable , and
clear on the screen. I guess it means that timing are OK ?

Another project (different cpu, kernel) with the same lcd, and the
same (Expected) timing, gives the following:
mode "240x320-0"
# D: 0.000 MHz, H: 0.000 kHz, V: 0.000 Hz
geometry 240 320 240 320 16
timings 0 0 0 0 0 0 0
accel false
rgba 5/11,6/5,5/0,0/0
endmode

In that project there is no issue when rendering an image (the image
does not disapear).

But In my cpu, kernel I see the following:


root@dm814x:/opt/dvr_rdk/ti814x# fbset -fb /dev/fb0

mode "240x320-782"

   # D: 148.500 MHz, H: 285.577 kHz, V: 782.403 Hz

   geometry 240 320 240 320 16

   timings 6734 148 88 36 4 44 5

   rgba 5/11,6/5,5/0,0/0

endmode

Can any of the above differences explain this behaviour ? Hiw can I
fix it (I tried to use fbset with -t 0 0 0 ... but it did not help)

The images on my board can be seen here:
https://drive.google.com/drive/folders/0B22GsWueReZTR1IxYzEteDNpUGc

Regards,
Ran
