From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Tue, 21 Jun 2011 10:41:49 +0000
Subject: Re: [PATCH] locomo: drop special locomo_{read/write}l in favor of
Message-Id: <20110621104148.GB8468@core.coreip.homeip.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <201106201454.18070.hartleys@visionengravers.com>
In-Reply-To: <201106201454.18070.hartleys@visionengravers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Mon, Jun 20, 2011 at 02:54:17PM -0700, H Hartley Sweeten wrote:
> All the locomo registers are 16-bit ioremap'ed memory addresses.  
> 
> Make the locomo drivers use generic purpose io routines: ioread16
> and iowrite16 instead of directly accessing memory.
> 
> There are still a couple checkpatch warnings about lines exceeding
> 79 characters.
> 
> Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>

Input parts look good to me.

Acked-by: Dmitry Torokhov <dtor@mail.ru>

-- 
Dmitry
