From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 16 Nov 2010 09:52:32 +0000
Subject: Re: [PATCH] lxfb: Program panel v/h sync output polarity correctly
Message-Id: <20101116095232.GE1330@linux-sh.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20101114141231.414F29D401B@zog.reactivated.net>
In-Reply-To: <20101114141231.414F29D401B@zog.reactivated.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Tue, Nov 16, 2010 at 09:33:52AM +0000, Daniel Drake wrote:
> On 16 November 2010 08:26, Michael Grzeschik <mgr@pengutronix.de> wrote:
> > I rechecked the Datasheet and it seems you are right with that.
> > But i don't like the logical mess in the statements. So here is what i
> > would prefer.
> >
> >>
> >> - ? ? ? ? ? ? if (info->var.sync & FB_SYNC_HOR_HIGH_ACT)
> >> + ? ? ? ? ? ? if (!(info->var.sync & FB_SYNC_HOR_HIGH_ACT))
> >> ? ? ? ? ? ? ? ? ? ? ? temp |= FP_PT2_HSP;
> >
> > Instead i would like to see something like this:
> >
> >
> > ? ? ? ? ? ? ? ?if (info->var.sync & FB_SYNC_HOR_HIGH_ACT)
> > ? ? ? ? ? ? ? ? ? ? ? ?temp &= ~(FP_PT2_HSP);
> 
> You'd have to add an else condition to actually set the bit (in the
> active low case) though.
> I'd be happy to do that, but my opinion is that my original version is cleaner.
> Apples vs oranges. Paul, which approach do you prefer?
> 
I'm fairly ambivalent. Some people like to write these things out
verbosely so it's immediately apparent what is going on, which can often
help when staring at non-obvious logic inversion. However, your original
version matches the current variable utilization fine, and the cases
involved are not that sufficiently complex that they're likely to be
misinterpreted.

The trying to make inverted logic appear more obvious angle is what
necessitated this change in the first place, so keeping it simple and
concise is certainly preferable (and indeed, another subtle bug would
have been introduced by flipping it around in the way proposed, as you
pointed out). Given that, and that we now have Michael's implicit
acknowledgement of the problem, I'll just take your original patch.

I can of course apply a follow-up patch that brings it in line with a
stylistic consensus if you two manage to come up with one at a later
point in time ;-)
