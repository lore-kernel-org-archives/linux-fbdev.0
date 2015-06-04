From: Dave Chinner <david@fromorbit.com>
Date: Thu, 04 Jun 2015 23:00:15 +0000
Subject: Re: linux-next: Tree for Jun 4 (radeonfb && xfs)
Message-Id: <20150604230015.GX24666@dastard>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20150604231545.506332b5@canb.auug.org.au>
	<5570A3C6.6050509@infradead.org>
In-Reply-To: <5570A3C6.6050509@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-kernel@vger.kernel.org, xfs@oss.sgi.com, linux-next@vger.kernel.org

On Thu, Jun 04, 2015 at 12:15:18PM -0700, Randy Dunlap wrote:
> On 06/04/15 06:15, Stephen Rothwell wrote:
> > Hi all,
> > 
> > Changes since 20150603:
> > 
> 
> 
> on i386:
> 
> fs/built-in.o: In function `xfs_ifree_cluster':
> xfs_inode.c:(.text+0x1c491a): undefined reference to `__umoddi3'
> 
> drivers/built-in.o: In function `radeonfb_pci_register':
> radeon_base.c:(.text+0x72fe0): undefined reference to `__divdi3'

Fix should be in today's linux-next tree.

-Dave
-- 
Dave Chinner
david@fromorbit.com
