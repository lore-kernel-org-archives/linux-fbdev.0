From: Bernie Thompson <bernie@plugable.com>
Date: Fri, 21 May 2010 18:59:21 +0000
Subject: Adding X damage support to xf86-video-fbdev and standardizing ioctl
Message-Id: <AANLkTil4329qzpdruGtyBHNn4PrglyO7PUC04UNNxlZ8@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

For virtual framebuffers that need to shuffle pixels over a bus or
network, to be efficient they need to get notification of what pixels
are changing in the case of a memory mapped framebuffer.

This has come up before (Jaya/others have thought and talked about
this), and here's another example implementation (for DisplayLink USB
devices):

http://plugable.com/2010/05/21/linux-support-for-higher-res-monitors-on-lower-res-displaylink-devices/

This uses a hacked ioctl.  But there's a commented out proposal in
there for cleaning it up.

It would be great to standardize the interface for passing damage
notifications (from X or other) down to kernel.  Some open questions:

* Which ioctl ordinal could be reserved for this (maybe 'F' 0x1A?)
* What struct (just a single rect as above, or pass X damage struct
down directly?)
* User-configured (with X option as with implementation above), or
auto-negotiated between kernel and user?

Any thoughts or comments on this, and the feasibility of eventually
getting this into fbdev (and xf86-video-fbdev) are welcome.

Best wishes,
Bernie
http://plugable.com/
