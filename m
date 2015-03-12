From: David Miller <davem@redhat.com>
Date: Thu, 12 Mar 2015 19:27:29 +0000
Subject: Re: [PATCH 4/8] net: freescale: replace CONFIG_8xx by CONFIG_PPC_8xx
Message-Id: <20150312.152729.567538955925640045.davem@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20150312152354.A47721A241F@localhost.localdomain>
In-Reply-To: <20150312152354.A47721A241F@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: christophe.leroy@c-s.fr
Cc: linux-fbdev@vger.kernel.org, linux-serial@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, vitb@kernel.crashing.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, linux-mtd@lists.infradead.org, user-mode-linux-user@lists.sourceforge.net, pantelis.antoniou@gmail.com, linuxppc-dev@lists.ozlabs.org

From: Christophe Leroy <christophe.leroy@c-s.fr>
Date: Thu, 12 Mar 2015 16:23:54 +0100 (CET)

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

Acked-by: David S. Miller <davem@davemloft.net>
