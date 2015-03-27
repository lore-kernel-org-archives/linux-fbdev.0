From: "Luis R. Rodriguez" <mcgrof@suse.com>
Date: Fri, 27 Mar 2015 18:40:26 +0000
Subject: Re: [PATCH v1 05/47] pci: add pci_iomap_wc() variants
Message-Id: <20150327184026.GG5622@wotan.suse.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1426893517-2511-1-git-send-email-mcgrof@do-not-panic.com>
 <1426893517-2511-6-git-send-email-mcgrof@do-not-panic.com>
 <20150325200743.GP25884@l.oracle.com>
In-Reply-To: <20150325200743.GP25884@l.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>, luto@amacapital.net, mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com, jgross@suse.com, JBeulich@suse.com, bp@suse.de, suresh.b.siddha@intel.com, venkatesh.pallipadi@intel.com, airlied@redhat.com, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, x86@kernel.org, xen-devel@lists.xenproject.org, Ingo Molnar <mingo@elte.hu>, Daniel Vetter <daniel.vetter@ffwll.ch>, Bjorn Helgaas <bhelgaas@google.com>, Antonino Daplas <adaplas@gmail.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Dave Hansen <dave.hansen@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, "Michael S. Tsirkin" <mst@redhat.com>, Stefan Bader <stefan.bader@canonical.com>, ville.syrjala@linux.intel.com, david.vrabel@citrix.com, toshi.kani@hp.com, Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>, xen-devel@lists.xensource.com

On Wed, Mar 25, 2015 at 04:07:43PM -0400, Konrad Rzeszutek Wilk wrote:
> On Fri, Mar 20, 2015 at 04:17:55PM -0700, Luis R. Rodriguez wrote:
> > From: "Luis R. Rodriguez" <mcgrof@suse.com>
> > 
> > This allows drivers to take advantage of write-combining
> > when possible. Ideally we'd have pci_read_bases() just
> > peg an IORESOURCE_WC flag for us but where exactly
> > video devices memory lie varies *largely* and at times things
> > are mixed with MMIO registers, sometimes we can address
> > the changes in drivers, other times the change requires
> > intrusive changes.
> > 
> > Although there is also arch_phys_wc_add() that makes use of
> > architecture specific write-combinging alternatives (MTRR on
> 
> combinging?

Amended.

> > diff --git a/lib/pci_iomap.c b/lib/pci_iomap.c
> > index bcce5f1..30b65ae 100644
> > --- a/lib/pci_iomap.c
> > +++ b/lib/pci_iomap.c
> > @@ -52,6 +52,46 @@ void __iomem *pci_iomap_range(struct pci_dev *dev,
> >  EXPORT_SYMBOL(pci_iomap_range);
> >  
> >  /**
> > + * pci_iomap_wc_range - create a virtual WC mapping cookie for a PCI BAR
> > + * @dev: PCI device that owns the BAR
> > + * @bar: BAR number
> > + * @offset: map memory at the given offset in BAR
> > + * @maxlen: max length of the memory to map
> > + *
> > + * Using this function you will get a __iomem address to your device BAR.
> > + * You can access it using ioread*() and iowrite*(). These functions hide
> > + * the details if this is a MMIO or PIO address space and will just do what
> > + * you expect from them in the correct way. When possible write combining
> > + * is used.
> > + *
> > + * @maxlen specifies the maximum length to map. If you want to get access to
> > + * the complete BAR from offset to the end, pass %0 here.
> 
> s/%0/0 ? Or is that some special syntax?

This copies the syntax of pci_iomap_range() which also uses %0, and as per
Documentation/kernel-doc-nano-HOWTO.txt % is used for constants. See:

scripts/kernel-doc -man -function pci_iomap_range lib/pci_iomap.c | nroff -man | less

  Luis
