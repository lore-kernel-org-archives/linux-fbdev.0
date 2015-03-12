From: David Miller <davem@redhat.com>
Date: Thu, 12 Mar 2015 19:27:20 +0000
Subject: Re: [PATCH 7/8] isdn: replace CONFIG_8xx by CONFIG_PPC_8xx
Message-Id: <20150312.152720.2248943963968220981.davem@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20150312152409.E7B5C1A2422@localhost.localdomain>
In-Reply-To: <20150312152409.E7B5C1A2422@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: christophe.leroy@c-s.fr
Cc: isdn@linux-pingi.de, linux-serial@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-mtd@lists.infradead.org, user-mode-linux-user@lists.sourceforge.net, linuxppc-dev@lists.ozlabs.org

From: Christophe Leroy <christophe.leroy@c-s.fr>
Date: Thu, 12 Mar 2015 16:24:09 +0100 (CET)

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
