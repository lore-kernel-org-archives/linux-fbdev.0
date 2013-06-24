From: Daniel Drake <dsd@laptop.org>
Date: Mon, 24 Jun 2013 16:17:41 +0000
Subject: Re: [V2 5/7] video: mmp: add pitch info in mmp_win structure
Message-Id: <CAMLZHHTzR4WffVdw2nWVP6c0_jBb1vW=mOR3RrQudjUNu5Hupg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1370879574-11397-1-git-send-email-jtzhou@marvell.com>
 <CAMLZHHRxS-wqd4Tb=Af6VEnfRb9MJeNo5RC7qeTLBZ0rgU69pw@mail.gmail.com>
 <CACDDiy9CP2NyLAwCSr97yOAS50gz6HumY9cAHwO1DFRSCy9L-w@mail.gmail.com>
In-Reply-To: <CACDDiy9CP2NyLAwCSr97yOAS50gz6HumY9cAHwO1DFRSCy9L-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Mon, Jun 24, 2013 at 4:34 AM, jett zhou <jett.zhou@gmail.com> wrote:
>     pitch is used to represent line length in byte, the usage depends
> on pix_fmt.
>     If the fmt is YUV , the pitch[0] will be Y length, pitch[1] will
> be U length, pitch[2] will be V lenth.
>     If the fmt is RGB, the picth[0] will be line lenth, and
> pitch[1]/pitch[2] will be 0 and not be used.

This description is clear, thanks - hopefully you can write it with
such clarity in the comment :)

>     For the patch rolling, do you mean combine the patch5 and patch6
> by one patch?

I view patch 6 as a cleanup (consolidating and removing duplication of
code), so I would leave that one separate. Patch 6 should not interact
with any pitch[] stuff.

Then you can write a followup patch which adds the pitch[] header,
*and* modifies mmpfb_set_par() to write to pitch[], *and* acts upon
pitch[] in dmafetch_set_fmt (patch 7). This way, the pitch variable is
defined, documented, written to, and acted upon all in the same patch,
the meaning will then be very clear.

Thanks
Daniel
