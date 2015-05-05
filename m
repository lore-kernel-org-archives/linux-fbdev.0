From: "Luis R. Rodriguez" <mcgrof@suse.com>
Date: Tue, 05 May 2015 07:31:07 +0000
Subject: Re: [PATCH v4 2/6] x86: document WC MTRR effects on PAT / non-PAT pages
Message-Id: <20150505073107.GJ5622@wotan.suse.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1430343851-967-1-git-send-email-mcgrof@do-not-panic.com>
 <1430343851-967-3-git-send-email-mcgrof@do-not-panic.com>
 <5542A628.8050705@infradead.org>
In-Reply-To: <5542A628.8050705@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Randy Dunlap <rdunlap@infradead.org>
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>, mingo@elte.hu, tglx@linutronix.de, hpa@zytor.com, bp@suse.de, plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, daniel.vetter@intel.com, airlied@linux.ie, dledford@redhat.com, awalls@md.metrocast.net, syrjala@sci.fi, luto@amacapital.net, mst@redhat.com, cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org, Toshi Kani <toshi.kani@hp.com>, Jonathan Corbet <corbet@lwn.net>, Dave Hansen <dave.hansen@linux.intel.com>, Suresh Siddha <sbsiddha@gmail.com>, Juergen Gross <jgross@suse.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Dave Airlie <airlied@redhat.com>, Antonino Daplas <adaplas@gmail.com>, Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>, Davidlohr Bueso <dbueso@suse.de>, linux-fbdev@vger.kernel.org

On Thu, Apr 30, 2015 at 03:01:12PM -0700, Randy Dunlap wrote:
> On 04/29/15 14:44, Luis R. Rodriguez wrote:
> > From: "Luis R. Rodriguez" <mcgrof@suse.com>
> > 
> 
> > ---
> >  Documentation/x86/mtrr.txt      | 18 +++++++++++++++---
> >  Documentation/x86/pat.txt       | 40 +++++++++++++++++++++++++++++++++++++++-
> >  arch/x86/kernel/cpu/mtrr/main.c |  3 +++
> >  3 files changed, 57 insertions(+), 4 deletions(-)
> > 
> > diff --git a/Documentation/x86/pat.txt b/Documentation/x86/pat.txt
> > index cf08c9f..7e183e3 100644
> > --- a/Documentation/x86/pat.txt
> > +++ b/Documentation/x86/pat.txt
> > @@ -102,7 +104,43 @@ wants to export a RAM region, it has to do set_memory_uc() or set_memory_wc()
> >  as step 0 above and also track the usage of those pages and use set_memory_wb()
> >  before the page is freed to free pool.
> >  
> > -
> > +MTRR effects on PAT / non-PAT systems
> > +-------------------------------------
> > +
> > +The following table provides the effects of using write-combining MTRRs when
> > +using ioremap*() calls on x86 for both non-PAT and PAT systems. Ideally
> > +mtrr_add() usage will be phased in favor of arch_phys_wc_add() which will
> > +be a no-op on PAT enabled systems. The region over which a arch_phys_wc_add()
> > +is made should already have be ioremap'd with write-combining page attributes
> > +or PAT entries, this can be done by using ioremap_wc() / or respective helpers.
> > +Devices which combine areas of IO memory desired to remain uncachable with
> 
> I would spell it uncacheable.  In kernel Documentation/, grep uncacheable finds
> 14 hits vs. 6 hits for uncachable.  No big deal.

Fixed.

> > +areas where write-combining is desirable and are restricted by the size
> > +requirements of MTRRs should consider splitting up their IO memory space
> > +cleanly with ioremap_uc() and ioremap_wc() followed by an arch_phys_wc_add()
> > +encompassing both regions. Such use is nevertheless heavily discouraged as
> > +the effective memory type is considered implementation defined. This strategy
> > +should only be used as last resort on devices with size-contrained regions
> 
>                                                       size-constrained

Fixed.

> > +where otherwise MTRR write-combining would not be effective.
> > +
> > +Note that you cannot use set_memory_wc() to override / whitelist IO remapped
> > +memory space mapped with ioremap*() calls, set_memory_wc() can only be used
> > +on RAM.
> > +
> > +----------------------------------------------------------------------
> > +MTRR Non-PAT   PAT    Linux ioremap value        Effective memory type
> > +----------------------------------------------------------------------
> > +                                                  Non-PAT |  PAT
> > +     PAT
> > +     |PCD
> > +     ||PWT
> > +     |||
> > +WC   000      WB      _PAGE_CACHE_MODE_WB            WC   |   WC
> > +WC   001      WC      _PAGE_CACHE_MODE_WC            WC*  |   WC
> > +WC   010      UC-     _PAGE_CACHE_MODE_UC_MINUS      WC*  |   WC
> > +WC   011      UC      _PAGE_CACHE_MODE_UC            UC   |   UC
> > +----------------------------------------------------------------------
> > +
> > +(*) denotes implementation defined and is discouraged
> >  
> >  Notes:
> >  
> > diff --git a/arch/x86/kernel/cpu/mtrr/main.c b/arch/x86/kernel/cpu/mtrr/main.c
> > index ea5f363..12abdbe 100644
> > --- a/arch/x86/kernel/cpu/mtrr/main.c
> > +++ b/arch/x86/kernel/cpu/mtrr/main.c
> > @@ -538,6 +538,9 @@ EXPORT_SYMBOL(mtrr_del);
> >   * attempts to add a WC MTRR covering size bytes starting at base and
> >   * logs an error if this fails.
> >   *
> > + * The caller should expect to need to provide a power of two size on an
> 
>     * The called should provide a power of two size on an equivalent
>     * power of two boundary.

Fixed.

 Luis
