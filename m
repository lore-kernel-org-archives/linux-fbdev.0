From: Luc Verhaegen <libv@skynet.be>
Date: Thu, 28 Aug 2014 16:50:31 +0000
Subject: Re: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
Message-Id: <20140828165031.GA7654@skynet.be>
List-Id: <linux-fbdev.vger.kernel.org>
References: <53FDB46C.5010609@redhat.com> <20140827125613.GF23186@ulmo>
 <53FDE0CE.5030807@redhat.com> <20140827141632.GB32243@ulmo>
 <53FF1D6C.6090205@redhat.com>
 <CAKON4OyXPjXx4q828kFgMsC_u7u3nqLPLxOp-kRZbS27yRKOEg@mail.gmail.com>
 <CAMuHMdU+zxUCU05YOpyuP1fx=Dgb5SZu=vbaJW13sQAaMBwU_w@mail.gmail.com>
 <CAKON4Oy8X9CSpZjYnTRgZ_MsxXQ=zaP+kxiZ2b7Es4GjN+1iJw@mail.gmail.com>
 <CAOMqctRvNbvFTb9dixCO1D0PfOWDgmBBs2U3yR5pvL8dFM_Lvw@mail.gmail.com>
 <CAKON4OyB55L5q7fVo43V8kgtqHRZ3vkBMaA+Htxpob-FA1obaA@mail.gmail.com>
In-Reply-To: <CAKON4OyB55L5q7fVo43V8kgtqHRZ3vkBMaA+Htxpob-FA1obaA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, Aug 28, 2014 at 12:34:58PM -0400, jonsmirl@gmail.com wrote:
> 
> 2) Spend a day implementing a device specific fbdev driver that does
> the correct thing all of the time. These drivers would sit in initrd
> and load before the clock/regulator clean up shuts everything off. Use
> the existing simplefb code as a template for doing this.

If that finally ends this discussion, i'll more than happily do it. I'm 
sure that we've all could've done this a hundred times in the time we've
wasted here.

Good call Geert.

Luc Verhaegen.
