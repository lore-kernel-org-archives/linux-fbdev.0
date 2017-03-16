From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Date: Thu, 16 Mar 2017 22:05:19 +0000
Subject: Re: [PATCH v1] x86/mm, asm-generic: Add IOMMU ioremap_uc() variant default
Message-Id: <20170316220519.GU28800@wotan.suse.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1436488096-3165-1-git-send-email-mcgrof@do-not-panic.com>
 <CABhMZUVybSZPrLPWfFhCJKwk922UbacUzhzkMYNvb_++kGuPQw@mail.gmail.com>
In-Reply-To: <CABhMZUVybSZPrLPWfFhCJKwk922UbacUzhzkMYNvb_++kGuPQw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: bjorn@helgaas.com
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>, mingo@kernel.org, bp@suse.de, arnd@arndb.de, dan.j.williams@intel.com, Christoph Hellwig <hch@lst.de>, luto@amacapital.net, hpa@zytor.com, tglx@linutronix.de, geert@linux-m68k.org, ralf@linux-mips.org, hmh@hmh.eng.br, ross.zwisler@linux.intel.com, akpm@linux-foundation.org, jgross@suse.com, Benjamin Herrenschmidt <benh@kernel.crashing.org>, mpe@ellerman.id.au, tj@kernel.org, x86 <x86@kernel.org>, tomi.valkeinen@ti.com, mst@redhat.com, toshi.kani@hp.com, stefan.bader@canonical.com, linux-mm@kvack.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Mar 16, 2017 at 03:46:51PM -0500, Bjorn Helgaas wrote:
> On Thu, Jul 9, 2015 at 7:28 PM, Luis R. Rodriguez
> <mcgrof@do-not-panic.com> wrote:
> 
> > +/**
> > + * DOC: ioremap() and ioremap_*() variants
> > + *
> > + * If you have an IOMMU your architecture is expected to have both ioremap()
> > + * and iounmap() implemented otherwise the asm-generic helpers will provide a
> > + * direct mapping.
> > + *
> > + * There are ioremap_*() call variants, if you have no IOMMU we naturally will
> > + * default to direct mapping for all of them, you can override these defaults.
> > + * If you have an IOMMU you are highly encouraged to provide your own
> > + * ioremap variant implementation as there currently is no safe architecture
> > + * agnostic default. To avoid possible improper behaviour default asm-generic
> > + * ioremap_*() variants all return NULL when an IOMMU is available. If you've
> > + * defined your own ioremap_*() variant you must then declare your own
> > + * ioremap_*() variant as defined to itself to avoid the default NULL return.
> 
> Are the references above to "IOMMU" typos?  Should they say "MMU"
> instead, so they match the #ifdef below?

Yes. Patch welcomed.

  Luis
