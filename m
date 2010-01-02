From: Bernie Thompson <bernie@plugable.com>
Date: Sat, 02 Jan 2010 04:35:57 +0000
Subject: fbdev: ARGB8888 vs. RGB888
Message-Id: <480988181001012035iccffebbn21ed0bb69d29a670@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

The udlfb (DisplayLink virtual USB) framebuffer driver currently
supports 16bpp (RGB565) only.  Looking at adding 24/32bpp support.
Because it's a virtual device where the pixels get processed before
sending over USB, any pixel encoding on the host side could work.
Just have to choose the best one.

Anyone know of any surprising pros/cons which would lead one of
ARGB8888 or RGB888 being an obvious choice, all other things equal?
Is either mode known to work better for xf86-video-fbdev or other
client app compatibility?

RBG888 has several advantages, of course.  One interesting advantage
of ARG8888 is udlfb has a mode where it's a defio client -- and larger
bpp means page faults are actually somewhat more precise in
identifying the damaged areas of the screen, in addition to natural
alignment advantages.

As background -- udlfb is in the kernel staging tree. And there is
some future work at git.plugable.com.

Thanks,
Bernie
http://plugable.com/
