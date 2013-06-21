From: Daniel Drake <dsd@laptop.org>
Date: Fri, 21 Jun 2013 17:12:01 +0000
Subject: Re: [V2 3/7] video: mmp: fix graphics/video layer enable/mask swap issue
Message-Id: <CAMLZHHSDUYZ8fpjjSKzDWKL3=RhOaxO8pq-ty5zM+KHzEu30QA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1370879552-11290-1-git-send-email-jtzhou@marvell.com>
In-Reply-To: <1370879552-11290-1-git-send-email-jtzhou@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Mon, Jun 10, 2013 at 9:52 AM, Jett.Zhou <jtzhou@marvell.com> wrote:
> From: Jing Xiang <jxiang@marvell.com>
>
> There is bug when switch dma of graphic layer and video layer, it
> configured opposite bit, fix it.

So, overlays can be either graphics or video. overlay_is_vid() tells
you which type.
overlay_is_vid() makes its decision based on dmafetch_id which is
undocumented and I don't understand it (and in another mail you said
this is legacy configuration that is going to be removed).

Ignoring my lack of understanding of the background: the patch here
seems to make the code more correct. It will modify the path's
underlying control register to enable graphics or video transfer
depending on the overlay type. Turning a graphics overlay dmafetch ON
will not stomp on the bits set by any video overlay dmafetch on the
same path. Previously the logic was reversed.

This codepath will not work correctly if there will ever be more than
one overlay of the same type on the same path. For example, if we have
two graphics overlays;
1. dmafetch_onoff(overlay1, on) - graphics transfer is now enabled in
the hardware
2. dmafetch_onoff(overlay2, on) - graphics transfer was already
enabled, no change
3. dmafetch_onoff(overlay2, off) - graphics transfer is now disabled
in the hardware

At this point overlay1 is still active in theory, but the driver has
disabled graphics transfer at the hardware level.

Daniel
