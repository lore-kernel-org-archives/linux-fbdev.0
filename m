From: "Michael S. Tsirkin" <mst@redhat.com>
Date: Tue, 21 Apr 2015 19:25:05 +0000
Subject: Re: [PATCH v1 05/47] pci: add pci_iomap_wc() variants
Message-Id: <20150421211557-mutt-send-email-mst@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1426893517-2511-1-git-send-email-mcgrof@do-not-panic.com>
 <1426893517-2511-6-git-send-email-mcgrof@do-not-panic.com>
 <CAErSpo5LfgTM879jmt58yLrXD6e7spsaX1wNDcc2ppU9JrMXOg@mail.gmail.com>
In-Reply-To: <CAErSpo5LfgTM879jmt58yLrXD6e7spsaX1wNDcc2ppU9JrMXOg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>, Andy Lutomirski <luto@amacapital.net>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, jgross@suse.com, Jan Beulich <JBeulich@suse.com>, Borislav Petkov <bp@suse.de>, Suresh Siddha <suresh.b.siddha@intel.com>, venkatesh.pallipadi@intel.com, Dave Airlie <airlied@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-fbdev@vger.kernel.org, "x86@kernel.org" <x86@kernel.org>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, "Luis R. Rodriguez" <mcgrof@suse.com>, Ingo Molnar <mingo@elte.hu>, Daniel Vetter <daniel.vetter@ffwll.ch>, Antonino Daplas <adaplas@gmail.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Dave Hansen <dave.hansen@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, Stefan Bader <stefan.bader@canonical.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>, David Vrabel <david.vrabel@citrix.com>, Toshi Kani <toshi.kani@hp.com>, Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>, xen-devel <xen-devel@lists.xensource.com>

On Mon, Mar 23, 2015 at 12:20:47PM -0500, Bjorn Helgaas wrote:
> pci_iomap_range() already makes a cacheable mapping if
> IORESOURCE_CACHEABLE; I'm guessing that you would like it to
> automatically use WC if the BAR if IORESOURCE_PREFETCH, e.g.,
> 
>   if (flags & IORESOURCE_CACHEABLE)
>     return ioremap(start, len);
>   if (flags & IORESOURCE_PREFETCH)
>     return ioremap_wc(start, len);
>   return ioremap_nocache(start, len);
> 
> Is there a reason not to do that?

I think that's wrong and will break a bunch of things.
PCI prefetch bit merely means bridges can combine writes and prefetch
reads.  Prefetch does not affect ordering rules and does not allow
writes to be collapsed.

WC is stronger: it allows collapsing and changes ordering rules.

WC can also hurt latency as small writes are buffered.

To summarise, driver needs to know what it's doing,
we can't set WC in the pci core automatically.

-- 
MST
