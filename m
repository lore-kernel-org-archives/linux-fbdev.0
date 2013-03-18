From: Marek Vasut <marex@denx.de>
Date: Mon, 18 Mar 2013 21:31:22 +0000
Subject: Re: [PATCH] ARM: video: mxs: Fix mxsfb misconfiguring VDCTRL0
Message-Id: <201303182231.22749.marex@denx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1363630997-5254-1-git-send-email-marex@denx.de>
 <20130318185810.GA11040@kroah.com>
In-Reply-To: <20130318185810.GA11040@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Greg,

[...]

> > NOTE: This is the version for stable v3.8.3, so I'm sending it to
> > -stable.
> > 
> >       I will send adjusted version for mainline 3.9-rc , since there is
> >       one more board in mainline and therefore the versions of the patch
> >       must differ.
> 
> <formletter>
> 
> This is not the correct way to submit patches for inclusion in the
> stable kernel tree.  Please read Documentation/stable_kernel_rules.txt
> for how to do this properly.

I'm somewhat sure I violated a few (see below), I won't argue there as you 
surely are much more experienced, but let me dissect the rules so I can learn 
which one to be careful about. Please help me if I did not understand something 
properly.

 - It must be obviously correct and tested.
YES, Fabio tested it on MX28EVK, me on M28EVK (two different devices)

 - It cannot be bigger than 100 lines, with context.
NO, but I see no way to compress it under 100 lines.

 - It must fix only one thing.
YES, it fixes broken X11 on MX28

 - It must fix a real bug that bothers people (not a, "This could be a
   problem..." type thing).
YES, it fixes broken X11 on MX28

 - It must fix a problem that causes a build error (but not for things
   marked CONFIG_BROKEN), an oops, a hang, data corruption, a real
   security issue, or some "oh, that's not good" issue.  In short, something
   critical.
YES, it fixes broken X11 on MX28

 - Serious issues as reported by a user of a distribution kernel may also
   be considered if they fix a notable performance or interactivity issue.
   As these fixes are not as obvious and have a higher risk of a subtle
   regression they should only be submitted by a distribution kernel
   maintainer and include an addendum linking to a bugzilla entry if it 
   exists and additional information on the user-visible impact.
This doesn't apply I guess?

 - New device IDs and quirks are also accepted.
This doesn't apply for sure.

 - No "theoretical race condition" issues, unless an explanation of how the
   race can be exploited is also provided.
This doesn't apply for sure.

 - It cannot contain any "trivial" fixes in it (spelling changes,
   whitespace cleanups, etc).
This doesn't apply for sure.

 - It must follow the Documentation/SubmittingPatches rules.
I believe it does. It has one checkpatch warning, but to keep the amount of 
changes to bare minimum, I left it in there.

 - It or an equivalent fix must already exist in Linus' tree (upstream).
This can not happen, the fix in Linus' tree will have to be different since in 
v3.9 there is one more MX28 platform which also needs fixing. I suppose I will 
now wait for Shawn to merge the patch for 3.9-rc, get it mainline and then this 
one can be merged?

Thank you!

Best regards,
Marek Vasut
