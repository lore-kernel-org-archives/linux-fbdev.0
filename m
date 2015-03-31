From: Brian Norris <computersforpeace@gmail.com>
Date: Tue, 31 Mar 2015 00:55:38 +0000
Subject: Re: [PATCH 6/8] mtd: replace CONFIG_8xx by CONFIG_PPC_8xx
Message-Id: <20150331005538.GJ32500@ld-irv-0074>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20150312152404.D6C391A2421@localhost.localdomain>
In-Reply-To: <20150312152404.D6C391A2421@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: linux-fbdev@vger.kernel.org, linux-serial@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org, user-mode-linux-user@lists.sourceforge.net, netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org

On Thu, Mar 12, 2015 at 04:24:04PM +0100, Christophe Leroy wrote:
> Two config options exist to define powerpc MPC8xx:
> * CONFIG_PPC_8xx
> * CONFIG_8xx
> In addition, CONFIG_PPC_8xx also defines CONFIG_CPM1 as
> communication co-processor
> 
> arch/powerpc/platforms/Kconfig.cputype has contained the following
> comment about CONFIG_8xx item for some years:
> "# this is temp to handle compat with arch=ppc"
> 
> It looks like not many places still have that old CONFIG_8xx used,
> so it is likely to be a good time to get rid of it completely ?
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

I'm not sure if the consistency aspect is worked out for all symbols
(Geert's comment on the cover letter), but this one looks fine.

Applied this patch to l2-mtd.git.

Brian
