From: Dave Airlie <airlied@gmail.com>
Date: Thu, 11 Mar 2010 04:47:59 +0000
Subject: Re: My goal
Message-Id: <21d7e9971003102047i1531f719i45f7ff1ef308f185@mail.gmail.com>
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

Hi James,

I had a plan (with a picture) but we lost the picture in a disk crash.

But it basically sounded like this.

Currently we have two device nodes per drm device, a control node
and a legacy card node. The control node is there in theory to support
multi-seat.

The plan was some sort of userspace multi-seat manager (in gdm or
otherwise), would use the control node to divide up the modesetting
resources and create a number of seat nodes. These seat nodes
would operate like the current legacy node except they would only
show the user the modesetting resources assigned to them. The
control node could also be used to create a node with no mode
resources for GPGPU work.

You can see the start of this in the drm, look for mode_group.

Once the kernel was generating the seat nodes, it would be a
matter of giving that path to the X server KMS driver and it would
open that instead of the legacy device node, and same for the
second X server.

This would require of course starting X servers with -sharevts
and -novtswitch most likely.

Dave.
,
