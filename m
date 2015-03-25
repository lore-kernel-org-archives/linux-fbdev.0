From: "Luis R. Rodriguez" <mcgrof@suse.com>
Date: Wed, 25 Mar 2015 20:06:36 +0000
Subject: Re: [PATCH v1 04/47] pci: add pci_ioremap_wc_bar()
Message-Id: <20150325200636.GC12247@wotan.suse.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1426893517-2511-1-git-send-email-mcgrof@do-not-panic.com>
 <1426893517-2511-5-git-send-email-mcgrof@do-not-panic.com>
 <CALCETrXkZipqdY_faY+JOyuqcQKerk_CKH90ChDLTgCJPMKLug@mail.gmail.com>
In-Reply-To: <CALCETrXkZipqdY_faY+JOyuqcQKerk_CKH90ChDLTgCJPMKLug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andy Lutomirski <luto@amacapital.net>
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Juergen Gross <jgross@suse.com>, Jan Beulich <JBeulich@suse.com>, Borislav Petkov <bp@suse.de>, Suresh Siddha <suresh.b.siddha@intel.com>, venkatesh.pallipadi@intel.com, Dave Airlie <airlied@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, X86 ML <x86@kernel.org>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, Ingo Molnar <mingo@elte.hu>, Daniel Vetter <daniel.vetter@ffwll.ch>, Antonino Daplas <adaplas@gmail.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

On Fri, Mar 20, 2015 at 04:50:32PM -0700, Andy Lutomirski wrote:
> On Fri, Mar 20, 2015 at 4:17 PM, Luis R. Rodriguez
> <mcgrof@do-not-panic.com> wrote:
> > From: "Luis R. Rodriguez" <mcgrof@suse.com>
> >
> > This lets drivers take advanate of PAT when available. This
> > should help with the transition of converting video drivers over
> > to ioremap_wc() to help with the goal of eventually using
> > _PAGE_CACHE_UC over _PAGE_CACHE_UC_MINUS on x86 on
> > ioremap_nocache() (de33c442e)
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
> >                                      pci_resource_len(pdev, bar));
> >  }
> >  EXPORT_SYMBOL_GPL(pci_ioremap_bar);
> > +
> > +void __iomem *pci_ioremap_wc_bar(struct pci_dev *pdev, int bar)
> > +{
> > +       /*
> > +        * Make sure the BAR is actually a memory resource, not an IO resource
> > +        */
> > +       if (!(pci_resource_flags(pdev, bar) & IORESOURCE_MEM)) {
> > +               WARN_ON(1);
> > +               return NULL;
> > +       }
> 
> if (WARN_ON(...))?

Sure, they are equivalent however this follows the same exact style as
pci_ioremap_bar() so if we change this one might as well change the style of
pci_ioremap_bar() as well. Let me know if there is any preference. I personally
don't mind the extra line as it shortens the check.

 Luis
