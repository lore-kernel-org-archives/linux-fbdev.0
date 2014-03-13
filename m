From: Pawel Moll <pawel.moll@arm.com>
Date: Thu, 13 Mar 2014 11:43:22 +0000
Subject: Re: [PATCH v5 1/2] video: ARM CLCD: Add DT support
Message-Id: <1394711002.32336.5.camel@hornet>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1394036606-17784-1-git-send-email-pawel.moll@arm.com>
 <53184C2E.3000807@ti.com>
 <CACRpkdYBuxYko5JD5ZCfoQq+PeXtkKP9eprk9HM=ghW2YMoMuA@mail.gmail.com>
In-Reply-To: <CACRpkdYBuxYko5JD5ZCfoQq+PeXtkKP9eprk9HM=ghW2YMoMuA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, 2014-03-13 at 09:30 +0000, Linus Walleij wrote:
> On Thu, Mar 6, 2014 at 11:21 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> > On 05/03/14 18:23, Pawel Moll wrote:
> >> This patch adds basic DT bindings for the PL11x CLCD cells
> >> and make their fbdev driver use them.
> >
> > Is this an old HW, and presumably there won't be new users for it?
> 
> AFAICT ARM really like to re-synthesize this piece of HW in every
> new reference design they make. 

Not for long now, hopefully...

> > If
> > yes, this is probably fine. If not, you might want to look at the video
> > ports and endpoints, which is used by at least three not-yet-merged series:
> >
> > [PATCHv3 00/41] OMAPDSS: DT support v3
> > [PATCH v5 00/11] imx-drm dt bindings
> > [RFC PATCH v2 00/21] Add DSI display support for Exynos based boards
> >
> > Using bindings like that would be more future proof, even if the current
> > driver doesn't use them.
> 
> I take it that it shouldn't matter if the driver is for framebuffer or
> DRM (as was implied by some answer here) the hardware
> description should be the same no matter what, so the more
> furture-proof the better.

Again, no argument here - the clcd-specific properties will be of use
whatever happens in the future (the "immediate" display timing subnode
is optional and is cloned from other existing bindings, so no new
problem is introduced here). I'm just shying away from the discussions
on generic display (or CDF or video or whatever) bindings. Call me
coward if you wish (maybe just tired to death with this subject ;-)

Pawel

