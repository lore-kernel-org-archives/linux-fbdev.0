From: Dave Airlie <airlied@gmail.com>
Date: Thu, 18 Mar 2010 00:05:32 +0000
Subject: Re: My goal
Message-Id: <21d7e9971003171705mbd61603n4c8a998108d1b227@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <alpine.LFD.2.00.1003110341550.21470@casper.infradead.org>
In-Reply-To: <alpine.LFD.2.00.1003110341550.21470@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: James Simmons <jsimmons@infradead.org>
Cc: Linux console project <linuxconsole-dev@lists.sourceforge.net>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, DRI development list <dri-devel@lists.sourceforge.net>

On Thu, Mar 11, 2010 at 1:51 PM, James Simmons <jsimmons@infradead.org> wrote:
>
> Okay all the discussion about multiple display brings me to why I'm doing
> this. I'm attempting to revive the linux console project. I'm in a
> position to again work on this project. About 4 years ago the eproject
> managed to get multi-seat working. My goal is to get there again. My first
> goal is to get my netbook to act has a multiseat system for two. With a plugged
> in external montior and a USB keyboard run two concurrent X sessions both
> running OpenGL applications at the same time. I set out to do this 10
> years ago and I want to finally accomplish this.

Okay I took an afternoon to flesh out my design and got something working here,
I'll try and setup a videod demo later (if I can find a camera).

But I can now run two *separate* X servers on different outputs of the same GPU.

http://people.freedesktop.org/~airlied/multiseat/

has the kernel + libdrm patch, this is hacked for *my* X1900 (the radeon driver
hardcodes a seat -> crtc/connector/encoder mapping that should be dynamically
setup from userspace via the drm control node.

The libdrm patches adds an env var to pick device node (probably needs to be
secured).

With this I can and some proper xorg.conf to pick the correct input devices

DRM_DEVICE_PATH=/dev/dri/renderD128 /opt/xorg/bin/Xorg -retro
DRM_DEVICE_PATH=/dev/dri/renderD129 /opt/xorg/bin/Xorg :1 -sharevts
-novtswitch -retro

I can run two independent X servers on the same GPU.

Hopefully this gives you some idea of where I was planning on heading with this.

Dave.
