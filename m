From: Bernie Thompson <bernie@plugable.com>
Date: Wed, 09 Dec 2009 21:52:46 +0000
Subject: conflicts between fbcon and user-mode fbdev clients
Message-Id: <480988180912091352v77fa9a12s5077b3211c13586b@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi fbdevs,

This is probably a FAQ, but I haven't found the answer.

What (if anything) should a driver be doing to prevent fbcon and other
clients (e.g. X, etc.) from simultaneously opening and rendering to
the framebuffer?

Running a USB graphics device using the udlfb framebuffer driver
(in the staging tree of 2.6.32), a common problem is fbcon
automatically opens the first available framebuffer device (/dev/fb0).
 Then when the user loads an X server, both the X server and fbcon
continue to merrily render to the device, overwriting each other.

So, typically, the udlfb driver will see this sequence at boot (with
the xf-video-displaylink X server):
fb_open(user = 0)  fbcon opening the framebuffer
fb_open(user = 1)  X opening the framebuffer
fb_open(user = 1)  Another instance of X opening framebuffer
* X and fbcon both render to the framebuffer, causing a mess *
And then any calls to release() later.

This will happen only for the 1st usb device on the system.  For the
2nd or later (/dev/fb1 ...), fbcon doesn't try to grab the device.

It's possible to disable fbcon as a module, or fail open() when
user=0.  But that's obviously not right.  And fbset by the user could
be a solution - but there's a desire to have this work out of the box.

Looking at the various fbdev drivers, I don't see other drivers
special casing this in general.  So I assume there's a known
recommended behavior here, but don't know what it is.

What is the expected behavior, for a fbdev driver and its clients, to
arbitrate among multiple clients?

Thanks for any answers here!
Bernie Thompson
http://plugable.com/
