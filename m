From: Toshi Kani <toshi.kani@hp.com>
Date: Fri, 27 Mar 2015 19:18:36 +0000
Subject: Re: [PATCH v1 05/47] pci: add pci_iomap_wc() variants
Message-Id: <1427483916.31093.30.camel@misato.fc.hp.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1426893517-2511-1-git-send-email-mcgrof@do-not-panic.com>
	 <1426893517-2511-6-git-send-email-mcgrof@do-not-panic.com>
	 <CAErSpo5LfgTM879jmt58yLrXD6e7spsaX1wNDcc2ppU9JrMXOg@mail.gmail.com>
In-Reply-To: <CAErSpo5LfgTM879jmt58yLrXD6e7spsaX1wNDcc2ppU9JrMXOg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>, Andy Lutomirski <luto@amacapital.net>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, jgross@suse.com, Jan Beulich <JBeulich@suse.com>, Borislav Petkov <bp@suse.de>, Suresh Siddha <suresh.b.siddha@intel.com>, venkatesh.pallipadi@intel.com, Dave Airlie <airlied@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-fbdev@vger.kernel.org, "x86@kernel.org" <x86@kernel.org>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, "Luis R. Rodriguez" <mcgrof@suse.com>, Ingo Molnar <mingo@elte.hu>, Daniel Vetter <daniel.vetter@ffwll.ch>, Antonino Daplas <adaplas@gmail.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Dave Hansen <dave.hansen@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, "Michael S. Tsirkin" <mst@redhat.com>, Stefan Bader <stefan.bader@canonical.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>, David Vrabel <david.vrabel@citrix.com>, Roger Pau =?ISO-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>, xen-devel <xen-devel@lists.xensource.com>

On Mon, 2015-03-23 at 12:20 -0500, Bjorn Helgaas wrote:
 :
> pci_iomap_range() already makes a cacheable mapping if
> IORESOURCE_CACHEABLE; I'm guessing that you would like it to
> automatically use WC if the BAR if IORESOURCE_PREFETCH, e.g.,
> 
>   if (flags & IORESOURCE_CACHEABLE)
>     return ioremap(start, len);

Is this supposed to be ioremap_cache()?  ioremap() is the same as
ioremap_nocache() at least on x86 per arch/x86/include/asm/io.h.

>   if (flags & IORESOURCE_PREFETCH)
>     return ioremap_wc(start, len);
>   return ioremap_nocache(start, len);
> 

-Toshi


