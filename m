From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 23 Mar 2015 17:20:47 +0000
Subject: Re: [PATCH v1 05/47] pci: add pci_iomap_wc() variants
Message-Id: <CAErSpo5LfgTM879jmt58yLrXD6e7spsaX1wNDcc2ppU9JrMXOg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1426893517-2511-1-git-send-email-mcgrof@do-not-panic.com> <1426893517-2511-6-git-send-email-mcgrof@do-not-panic.com>
In-Reply-To: <1426893517-2511-6-git-send-email-mcgrof@do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: Andy Lutomirski <luto@amacapital.net>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, jgross@suse.com, Jan Beulich <JBeulich@suse.com>, Borislav Petkov <bp@suse.de>, Suresh Siddha <suresh.b.siddha@intel.com>, venkatesh.pallipadi@intel.com, Dave Airlie <airlied@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-fbdev@vger.kernel.org, "x86@kernel.org" <x86@kernel.org>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, "Luis R. Rodriguez" <mcgrof@suse.com>, Ingo Molnar <mingo@elte.hu>, Daniel Vetter <daniel.vetter@ffwll.ch>, Antonino Daplas <adaplas@gmail.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Dave Hansen <dave.hansen@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, "Michael S. Tsirkin" <mst@redhat.com>, Stefan Bader <stefan.bader@canonical.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, David Vrabel <david.vrabel@citrix.com>, Toshi Kani <toshi.kani@hp.com>, =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>, xen-devel <xen-devel@lists.xensource.com>

Hi Luis,

This seems OK to me, but I'm curious about a few things.

On Fri, Mar 20, 2015 at 6:17 PM, Luis R. Rodriguez
<mcgrof@do-not-panic.com> wrote:
> From: "Luis R. Rodriguez" <mcgrof@suse.com>
>
> This allows drivers to take advantage of write-combining
> when possible. Ideally we'd have pci_read_bases() just
> peg an IORESOURCE_WC flag for us

We do set IORESOURCE_PREFETCH.  Do you mean something different?

>  but where exactly
> video devices memory lie varies *largely* and at times things
> are mixed with MMIO registers, sometimes we can address
> the changes in drivers, other times the change requires
> intrusive changes.

What does a video device address have to do with this?  I do see that
if a BAR maps only a frame buffer, the device might be able to mark it
prefetchable, while if the BAR mapped both a frame buffer and some
registers, it might not be able to make it prefetchable.  But that
doesn't seem like it depends on the *address*.

pci_iomap_range() already makes a cacheable mapping if
IORESOURCE_CACHEABLE; I'm guessing that you would like it to
automatically use WC if the BAR if IORESOURCE_PREFETCH, e.g.,

  if (flags & IORESOURCE_CACHEABLE)
    return ioremap(start, len);
  if (flags & IORESOURCE_PREFETCH)
    return ioremap_wc(start, len);
  return ioremap_nocache(start, len);

Is there a reason not to do that?

> Although there is also arch_phys_wc_add() that makes use of
> architecture specific write-combinging alternatives (MTRR on
> x86 when a system does not have PAT) we void polluting
> pci_iomap() space with it and force drivers and subsystems
> that want to use it to be explicit.
>
> There are a few motivations for this:
>
> a) Take advantage of PAT when available
>
> b) Help bury MTRR code away, MTRR is architecture specific and on
>    x86 its replaced by PAT
>
> c) Help with the goal of eventually using _PAGE_CACHE_UC over
>    _PAGE_CACHE_UC_MINUS on x86 on ioremap_nocache() (de33c442e)
> ...

> +void __iomem *pci_iomap_wc_range(struct pci_dev *dev,
> +                                int bar,
> +                                unsigned long offset,
> +                                unsigned long maxlen)
> +{
> +       resource_size_t start = pci_resource_start(dev, bar);
> +       resource_size_t len = pci_resource_len(dev, bar);
> +       unsigned long flags = pci_resource_flags(dev, bar);
> +
> +       if (len <= offset || !start)
> +               return NULL;
> +       len -= offset;
> +       start += offset;
> +       if (maxlen && len > maxlen)
> +               len = maxlen;
> +       if (flags & IORESOURCE_IO)
> +               return __pci_ioport_map(dev, start, len);
> +       if (flags & IORESOURCE_MEM)

Should we log a note in dmesg if the BAR is *not* IORESOURCE_PREFETCH?
 I know the driver might know it's safe even if the device didn't mark
the BAR as prefetchable, but it does seem like an easy way for a
driver to shoot itself in the foot.

> +               return ioremap_wc(start, len);
> +       /* What? */
> +       return NULL;
> +}
