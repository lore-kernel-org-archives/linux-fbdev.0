From: "Luis R. Rodriguez" <mcgrof@suse.com>
Date: Wed, 25 Mar 2015 20:39:14 +0000
Subject: Re: [Xen-devel] [PATCH v1 04/47] pci: add pci_ioremap_wc_bar()
Message-Id: <20150325203914.GD12247@wotan.suse.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1426893517-2511-1-git-send-email-mcgrof@do-not-panic.com>
 <1426893517-2511-5-git-send-email-mcgrof@do-not-panic.com>
 <20150325200346.GO25884@l.oracle.com>
In-Reply-To: <20150325200346.GO25884@l.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Arjan van de Ven <arjan@infradead.org>, Arjan van de Ven <arjan@linux.intel.com>
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>, luto@amacapital.net, mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com, jgross@suse.com, JBeulich@suse.com, bp@suse.de, suresh.b.siddha@intel.com, venkatesh.pallipadi@intel.com, airlied@redhat.com, linux-fbdev@vger.kernel.org, Antonino Daplas <adaplas@gmail.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, x86@kernel.org, linux-kernel@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, xen-devel@lists.xenproject.org, Ingo Molnar <mingo@elte.hu>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>

On Wed, Mar 25, 2015 at 04:03:46PM -0400, Konrad Rzeszutek Wilk wrote:
> On Fri, Mar 20, 2015 at 04:17:54PM -0700, Luis R. Rodriguez wrote:
> > From: "Luis R. Rodriguez" <mcgrof@suse.com>
> > 
> > This lets drivers take advanate of PAT when available. This
> 
> s/advanate/advantage/

Amended.

> > should help with the transition of converting video drivers over
> > to ioremap_wc() to help with the goal of eventually using
> > _PAGE_CACHE_UC over _PAGE_CACHE_UC_MINUS on x86 on
> > ioremap_nocache() (de33c442e)
> 
> Please mention the title of the patch too:
> 
> "x86 PAT: fix performance drop for glx, use UC minus for ioremap(), ioremap_nocache() and pci_mmap_page_range()"

Added.

> > 
> > Cc: Suresh Siddha <suresh.b.siddha@intel.com>
> > Cc: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
> > Cc: Ingo Molnar <mingo@elte.hu>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Juergen Gross <jgross@suse.com>
> > Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> > Cc: Andy Lutomirski <luto@amacapital.net>
> > Cc: Dave Airlie <airlied@redhat.com>
> > Cc: Antonino Daplas <adaplas@gmail.com>
> > Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
> > Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> > Cc: linux-fbdev@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > Signed-off-by: Luis R. Rodriguez <mcgrof@suse.com>
> > ---
> >  drivers/pci/pci.c   | 14 ++++++++++++++
> >  include/linux/pci.h |  1 +
> >  2 files changed, 15 insertions(+)
> > 
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index 81f06e8..6afd507 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -137,6 +137,20 @@ void __iomem *pci_ioremap_bar(struct pci_dev *pdev, int bar)
> >  				     pci_resource_len(pdev, bar));
> >  }
> >  EXPORT_SYMBOL_GPL(pci_ioremap_bar);
> > +
> > +void __iomem *pci_ioremap_wc_bar(struct pci_dev *pdev, int bar)
> > +{
> > +	/*
> > +	 * Make sure the BAR is actually a memory resource, not an IO resource
> > +	 */
> > +	if (!(pci_resource_flags(pdev, bar) & IORESOURCE_MEM)) {
> > +		WARN_ON(1);
> 
> Would it be better to use dev_warn ? That way you can see which BDF it is?
> 
> Thought WARN will give a nice stack-trace that should easily point to the
> driver so perhaps not.. Either way - up to you.

I'm sticking to the style and use as with pci_ioremap_bar(). Whatever we pick
we should make both use the same. More information is always better and
since we do have dev_warn(), it would be nice to use that however within
its use on both pci_ioremap_wc_bar() and pci_ioremap_bar() we have
a use of the pdev with pci_resource_flags() and I believe if pdev is NULL
we'd get a NULL dereference (dev_driver_string() is used), so it would
seem it might be best to stick with a simple WARN_ON(). Arjan, any
preference? Obviously if pdev is NULL your driver is dumb but as folks
develop drivers this should be expected.

 Luis
