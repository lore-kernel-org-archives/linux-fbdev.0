From: =?UTF-8?Q?Paolo_Niccol=C3=B2_Giubelli?=  <paoloniccolo.giubelli@gmail.com>
Date: Sun, 19 Apr 2015 17:39:14 +0000
Subject: Question abouf FB actual size
Message-Id: <CAFAVkqVPVG_h+Kwq-KjdivMWh+2WthJdJvQqRcf1m-qjHTpX1A@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hello world!
I'm developing a simple city simulator in C, and I'd like to draw the
city map on the framebuffer (it's just for debugging purposes).

There's something wrong with the math, because i have a 1366x768x32
FB, but my finfo.line_length (finfo is obtained via
FBIOGET_FSCREENINFO) is 5504 bytes. Well, 5504/4 (4 is 4 bytes per
pixel) is 1376 that is 10 pixels more than 1366.

Actually if I draw a full line using 5504 bytes everything is ok, if I
use 1366*4 I don't reach the edge of the monitor.

I'm using memset on a memory mapped /dev/fb0 file.

Is there something wrong or am I missing something?

Thank you in advance.
