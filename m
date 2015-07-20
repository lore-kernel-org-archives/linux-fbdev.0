From: Boris Brezillon <boris.brezillon@free-electrons.com>
Date: Mon, 20 Jul 2015 19:49:13 +0000
Subject: Re: [PATCH v2 00/10] pwm: add support for atomic update
Message-Id: <20150720214913.73c47fa6@bbrezillon>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1437406327-6207-1-git-send-email-boris.brezillon@free-electrons.com>
 <20150720171950.GE11162@sirena.org.uk>
In-Reply-To: <20150720171950.GE11162@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Mark,

On Mon, 20 Jul 2015 18:19:50 +0100
Mark Brown <broonie@kernel.org> wrote:

> On Mon, Jul 20, 2015 at 05:31:57PM +0200, Boris Brezillon wrote:
> 
> > - dropped pwm-regulator patches (should be submitted separately)
> 
> I think the second patch needs to go in with this series doesn't it?  It
> was just the enable one that was good to go immediately IIRC.

I was planning on submitting those two patches after the PWM changes
have been merged, but you're right, maybe we should think about a proper
way to smoothly get all of them in the same release.

I have rebased my work on top your regulator/topic/pwm branch containing
Lee's work [1].

Note that patch 1 has changed a bit to take Lee's additions into
account.

Thierry, could you create a branch based on Mark's regulator/topic/pwm
branch ?
If everybody agrees on the solution I'll send a v3 rebasing my work on
top of this topic branch.

Best Regards,

Boris

[1]https://github.com/bbrezillon/linux-rk/tree/atomic-pwm-v3
-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
