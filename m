From: "Luis R. Rodriguez" <mcgrof@suse.com>
Date: Tue, 26 May 2015 19:49:13 +0000
Subject: Re: [PATCH v3 0/4] pci: add and use pci_ioremap_wc_bar()
Message-Id: <20150526194913.GQ23057@wotan.suse.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1429647634-17169-1-git-send-email-mcgrof@do-not-panic.com>
 <556428E7.3050606@ti.com>
In-Reply-To: <556428E7.3050606@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: cocci@systeme.lip6.fr

On Tue, May 26, 2015 at 11:03:51AM +0300, Tomi Valkeinen wrote:
> Hi Louis,
> 
> On 21/04/15 23:20, Luis R. Rodriguez wrote:
> > From: "Luis R. Rodriguez" <mcgrof@suse.com>
> > 
> > This series adds pci_ioremap_wc_bar() and makes use of it
> > on a few framebuffer device drivers.
> > 
> > Luis R. Rodriguez (4):
> >   pci: add pci_ioremap_wc_bar()
> >   video: fbdev: i740fb: use arch_phys_wc_add() and pci_ioremap_wc_bar()
> >   video: fbdev: kyrofb: use arch_phys_wc_add() and pci_ioremap_wc_bar()
> >   video: fbdev: gxt4500: use pci_ioremap_wc_bar() for framebuffer
> > 
> >  drivers/pci/pci.c                | 14 ++++++++++++++
> >  drivers/video/fbdev/gxt4500.c    |  2 +-
> >  drivers/video/fbdev/i740fb.c     | 35 ++++++-----------------------------
> >  drivers/video/fbdev/kyro/fbdev.c | 33 +++++++++++----------------------
> >  include/linux/pci.h              |  1 +
> >  include/video/kyro.h             |  4 +---
> >  6 files changed, 34 insertions(+), 55 deletions(-)
> 
> About this and other related series: rather than having multiple
> different patch series containing fbdev changes, going via separate
> trees, I would very much prefer to get all the requisite pci/mtrr
> related patches merged in the next merge window, and only then change
> the fbdev drivers in one series, merged via fbdev tree.

Tomi, OK, I'll ask Bjorn to drop the framebuffer driver specific changes on the
pci_iomap_wc() series then and wait until he takes only the bus specific
changes for this and the pci_iomap_wc() series. Likewise I  will wait for
the x86 require changes (ioremap_uc() and pat_enabled()) stuff to be exported
before sending you the changes required for the framebuffer tree.

 Luis
