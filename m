From: David Brown <davidb@codeaurora.org>
Date: Mon, 23 Apr 2012 16:19:41 +0000
Subject: Re: [PATCH 1/2] video: msm: Fix section mismatches in mddi.c
Message-Id: <20120423161941.GA26903@codeaurora.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1334256334-8234-1-git-send-email-davidb@codeaurora.org>
 <4F94F3D7.5030904@gmx.de>
In-Reply-To: <4F94F3D7.5030904@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Mon, Apr 23, 2012 at 06:16:55AM +0000, Florian Tobias Schandinat wrote:
> On 04/12/2012 06:45 PM, David Brown wrote:
> > The change
> >     commit 461cbe77d0a4f887c33a3a95ea68a7daf23b4302
> >     Author: Gregory Bean <gbean@codeaurora.org>
> >     Date:   Wed Jul 28 10:22:13 2010 -0700
> > 
> >         video: msm: Fix section mismatch in mddi.c.
> > 
> > fixes a section mismatch between the board file and the driver's probe
> > function, however, it misses the additional mismatches between the
> > probe function and some routines it calls.  Fix these up as well.
> > 
> > Signed-off-by: David Brown <davidb@codeaurora.org>
> 
> Applied.

Hmm.  I guess it is somewhat my fault, since I sent the message To
both myself and you.  I've already applied this to the MSM tree, and I
believe it has been merged into Linus' tree.  I don't think it'll be
an issue, since git merge will handle the duplicate patch fine.

Next time, I'll try to be clearer about which tree I'm thinking for a
patch to go through.

David

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
