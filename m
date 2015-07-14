From: Boris Brezillon <boris.brezillon@free-electrons.com>
Date: Tue, 14 Jul 2015 11:02:22 +0000
Subject: Re: [RFC PATCH 14/15] regulator: pwm: implement ->enable(), ->disable() and ->is_enabled methods
Message-Id: <20150714130222.1bdfedc5@bbrezillon>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1435738921-25027-1-git-send-email-boris.brezillon@free-electrons.com>
 <1435738921-25027-15-git-send-email-boris.brezillon@free-electrons.com>
 <20150714105019.GR11162@sirena.org.uk>
In-Reply-To: <20150714105019.GR11162@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Mark,

On Tue, 14 Jul 2015 11:50:19 +0100
Mark Brown <broonie@kernel.org> wrote:

> On Wed, Jul 01, 2015 at 10:22:00AM +0200, Boris Brezillon wrote:
> > Implement the ->enable(), ->disable() and ->is_enabled methods and remove
> > the PWM call in ->set_voltage_sel().
> 
> This doesn't apply, please check and resend.

This series was made on top of Linus' tree (4.2-rc1 IIRC) and patch 14
and 15 were not meant to be applied without Thierry's approval (they
depend on other changes in the PWM framework).
I can rebase them on top of linux-next (or just on top of Linus'
4.2-rc2) if Thierry is okay with that, but I don't think rebasing them
on your regulator's for-next branch is a good idea.

Thierry, Mark, let me know what you prefer.

Thanks,

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
