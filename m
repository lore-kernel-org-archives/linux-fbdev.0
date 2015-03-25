From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Date: Wed, 25 Mar 2015 20:07:43 +0000
Subject: Re: [PATCH v1 05/47] pci: add pci_iomap_wc() variants
Message-Id: <20150325200743.GP25884@l.oracle.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1426893517-2511-1-git-send-email-mcgrof@do-not-panic.com>
 <1426893517-2511-6-git-send-email-mcgrof@do-not-panic.com>
In-Reply-To: <1426893517-2511-6-git-send-email-mcgrof@do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: luto@amacapital.net, mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com, jgross@suse.com, JBeulich@suse.com, bp@suse.de, suresh.b.siddha@intel.com, venkatesh.pallipadi@intel.com, airlied@redhat.com, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, x86@kernel.org, xen-devel@lists.xenproject.org, "Luis R. Rodriguez" <mcgrof@suse.com>, Ingo Molnar <mingo@elte.hu>, Daniel Vetter <daniel.vetter@ffwll.ch>, Bjorn Helgaas <bhelgaas@google.com>, Antonino Daplas <adaplas@gmail.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Dave Hansen <dave.hansen@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, "Michael S. Tsirkin" <mst@redhat.com>, Stefan Bader <stefan.bader@canonical.com>, ville.syrjala@linux.intel.com, david.vrabel@citrix.com, toshi.kani@hp.com, Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>, xen-devel@lists.xensource.com

On Fri, Mar 20, 2015 at 04:17:55PM -0700, Luis R. Rodriguez wrote:
> From: "Luis R. Rodriguez" <mcgrof@suse.com>
>=20
> This allows drivers to take advantage of write-combining
> when possible. Ideally we'd have pci_read_bases() just
> peg an IORESOURCE_WC flag for us but where exactly
> video devices memory lie varies *largely* and at times things
> are mixed with MMIO registers, sometimes we can address
> the changes in drivers, other times the change requires
> intrusive changes.
>=20
> Although there is also arch_phys_wc_add() that makes use of
> architecture specific write-combinging alternatives (MTRR on

combinging?

> x86 when a system does not have PAT) we void polluting
> pci_iomap() space with it and force drivers and subsystems
> that want to use it to be explicit.
>=20
> There are a few motivations for this:
>=20
> a) Take advantage of PAT when available
>=20
> b) Help bury MTRR code away, MTRR is architecture specific and on
>    x86 its replaced by PAT
>=20
> c) Help with the goal of eventually using _PAGE_CACHE_UC over
>    _PAGE_CACHE_UC_MINUS on x86 on ioremap_nocache() (de33c442e)
>=20
> Cc: Andy Lutomirski <luto@amacapital.net>
> Cc: Suresh Siddha <suresh.b.siddha@intel.com>
> Cc: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
> Cc: Ingo Molnar <mingo@elte.hu>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Juergen Gross <jgross@suse.com>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: Dave Airlie <airlied@redhat.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Antonino Daplas <adaplas@gmail.com>
> Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: venkatesh.pallipadi@intel.com
> Cc: Stefan Bader <stefan.bader@canonical.com>
> Cc: konrad.wilk@oracle.com
> Cc: ville.syrjala@linux.intel.com
> Cc: david.vrabel@citrix.com
> Cc: jbeulich@suse.com
> Cc: toshi.kani@hp.com
> Cc: Roger Pau Monn=E9 <roger.pau@citrix.com>
> Cc: linux-fbdev@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: xen-devel@lists.xensource.com
> Signed-off-by: Luis R. Rodriguez <mcgrof@suse.com>
> ---
>  include/asm-generic/pci_iomap.h | 14 ++++++++++
>  lib/pci_iomap.c                 | 61 +++++++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 75 insertions(+)
>=20
> diff --git a/include/asm-generic/pci_iomap.h b/include/asm-generic/pci_io=
map.h
> index 7389c87..b1e17fc 100644
> --- a/include/asm-generic/pci_iomap.h
> +++ b/include/asm-generic/pci_iomap.h
> @@ -15,9 +15,13 @@ struct pci_dev;
>  #ifdef CONFIG_PCI
>  /* Create a virtual mapping cookie for a PCI BAR (memory or IO) */
>  extern void __iomem *pci_iomap(struct pci_dev *dev, int bar, unsigned lo=
ng max);
> +extern void __iomem *pci_iomap_wc(struct pci_dev *dev, int bar, unsigned=
 long max);
>  extern void __iomem *pci_iomap_range(struct pci_dev *dev, int bar,
>  				     unsigned long offset,
>  				     unsigned long maxlen);
> +extern void __iomem *pci_iomap_wc_range(struct pci_dev *dev, int bar,
> +					unsigned long offset,
> +					unsigned long maxlen);
>  /* Create a virtual mapping cookie for a port on a given PCI device.
>   * Do not call this directly, it exists to make it easier for architectu=
res
>   * to override */
> @@ -34,12 +38,22 @@ static inline void __iomem *pci_iomap(struct pci_dev =
*dev, int bar, unsigned lon
>  	return NULL;
>  }
> =20
> +static inline void __iomem *pci_iomap_wc(struct pci_dev *dev, int bar, u=
nsigned long max)
> +{
> +	return NULL;
> +}
>  static inline void __iomem *pci_iomap_range(struct pci_dev *dev, int bar,
>  					    unsigned long offset,
>  					    unsigned long maxlen)
>  {
>  	return NULL;
>  }
> +static inline void __iomem *pci_iomap_wc_range(struct pci_dev *dev, int =
bar,
> +					       unsigned long offset,
> +					       unsigned long maxlen)
> +{
> +	return NULL;
> +}
>  #endif
> =20
>  #endif /* __ASM_GENERIC_IO_H */
> diff --git a/lib/pci_iomap.c b/lib/pci_iomap.c
> index bcce5f1..30b65ae 100644
> --- a/lib/pci_iomap.c
> +++ b/lib/pci_iomap.c
> @@ -52,6 +52,46 @@ void __iomem *pci_iomap_range(struct pci_dev *dev,
>  EXPORT_SYMBOL(pci_iomap_range);
> =20
>  /**
> + * pci_iomap_wc_range - create a virtual WC mapping cookie for a PCI BAR
> + * @dev: PCI device that owns the BAR
> + * @bar: BAR number
> + * @offset: map memory at the given offset in BAR
> + * @maxlen: max length of the memory to map
> + *
> + * Using this function you will get a __iomem address to your device BAR.
> + * You can access it using ioread*() and iowrite*(). These functions hide
> + * the details if this is a MMIO or PIO address space and will just do w=
hat
> + * you expect from them in the correct way. When possible write combining
> + * is used.
> + *
> + * @maxlen specifies the maximum length to map. If you want to get acces=
s to
> + * the complete BAR from offset to the end, pass %0 here.

s/%0/0 ? Or is that some special syntax?

> + * */
> +void __iomem *pci_iomap_wc_range(struct pci_dev *dev,
> +				 int bar,
> +				 unsigned long offset,
> +				 unsigned long maxlen)
> +{
> +	resource_size_t start =3D pci_resource_start(dev, bar);
> +	resource_size_t len =3D pci_resource_len(dev, bar);
> +	unsigned long flags =3D pci_resource_flags(dev, bar);
> +
> +	if (len <=3D offset || !start)
> +		return NULL;
> +	len -=3D offset;
> +	start +=3D offset;
> +	if (maxlen && len > maxlen)
> +		len =3D maxlen;
> +	if (flags & IORESOURCE_IO)
> +		return __pci_ioport_map(dev, start, len);
> +	if (flags & IORESOURCE_MEM)
> +		return ioremap_wc(start, len);
> +	/* What? */
> +	return NULL;
> +}
> +EXPORT_SYMBOL_GPL(pci_iomap_wc_range);
> +
> +/**
>   * pci_iomap - create a virtual mapping cookie for a PCI BAR
>   * @dev: PCI device that owns the BAR
>   * @bar: BAR number
> @@ -70,4 +110,25 @@ void __iomem *pci_iomap(struct pci_dev *dev, int bar,=
 unsigned long maxlen)
>  	return pci_iomap_range(dev, bar, 0, maxlen);
>  }
>  EXPORT_SYMBOL(pci_iomap);
> +
> +/**
> + * pci_iomap_wc - create a virtual WC mapping cookie for a PCI BAR
> + * @dev: PCI device that owns the BAR
> + * @bar: BAR number
> + * @maxlen: length of the memory to map
> + *
> + * Using this function you will get a __iomem address to your device BAR.
> + * You can access it using ioread*() and iowrite*(). These functions hide
> + * the details if this is a MMIO or PIO address space and will just do w=
hat
> + * you expect from them in the correct way. When possible write combining
> + * is used.
> + *
> + * @maxlen specifies the maximum length to map. If you want to get acces=
s to
> + * the complete BAR without checking for its length first, pass %0 here.
> + * */
> +void __iomem *pci_iomap_wc(struct pci_dev *dev, int bar, unsigned long m=
axlen)
> +{
> +	return pci_iomap_wc_range(dev, bar, 0, maxlen);
> +}
> +EXPORT_SYMBOL_GPL(pci_iomap_wc);
>  #endif /* CONFIG_PCI */
> --=20
> 2.3.2.209.gd67f9d5.dirty
>=20
