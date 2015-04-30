From: Borislav Petkov <bp@alien8.de>
Date: Thu, 30 Apr 2015 10:18:02 +0000
Subject: Re: [PATCH v4 1/6] x86: add ioremap_uc() - force strong UC, PCD=1, PWT=1
Message-Id: <20150430101801.GB5117@pd.tnic>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1430343851-967-1-git-send-email-mcgrof@do-not-panic.com>
 <1430343851-967-2-git-send-email-mcgrof@do-not-panic.com>
In-Reply-To: <1430343851-967-2-git-send-email-mcgrof@do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: mingo@elte.hu, tglx@linutronix.de, hpa@zytor.com, bp@suse.de, plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, daniel.vetter@intel.com, airlied@linux.ie, dledford@redhat.com, awalls@md.metrocast.net, syrjala@sci.fi, luto@amacapital.net, mst@redhat.com, cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org, "Luis R. Rodriguez" <mcgrof@suse.com>, Toshi Kani <toshi.kani@hp.com>, Bjorn Helgaas <bhelgaas@google.com>, Suresh Siddha <sbsiddha@gmail.com>, Juergen Gross <jgross@suse.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Dave Airlie <airlied@redhat.com>, Antonino Daplas <adaplas@gmail.com>, Will Deacon <will.deacon@arm.com>, Thierry Reding <treding@nvidia.com>, Mike Travis <travis@sgi.com>, Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>, Davidlohr Bueso <dbueso@suse.de>, x86@kernel.org, linux-fbdev@vger.kernel.org

On Wed, Apr 29, 2015 at 02:44:06PM -0700, Luis R. Rodriguez wrote:
> From: "Luis R. Rodriguez" <mcgrof@suse.com>
> 
> ioremap_nocache() currently uses UC- by default.
> Our goal is to eventually make UC the default.
> Linux maps UC- to PCD=1, PWT=0 page attributes on
> non-PAT systems. Linux maps UC to PCD=1, PWT=1
> page attributes on non-PAT systems. On non-PAT
> and PAT systems a WC MTRR has different effects on
> pages with either of these attributes. In order to
> help with a smooth transition its best to enable
> use of UC (PCD,1, PWT=1) on a region as that ensures
> a WC MTRR will have no effect on a region, this
> however requires us to have an way to declare a
> region as UC and we currently do not have a way
> to do this.
> 
> WC MTRR on non-PAT system with PCD=1, PWT=0 (UC-) yields WC.
> WC MTRR on non-PAT system with PCD=1, PWT=1 (UC)  yields UC.
> 
> WC MTRR on PAT system with PCD=1, PWT=0 (UC-) yields WC.
> WC MTRR on PAT system with PCD=1, PWT=1 (UC)  yields UC.
> 
> A flip of the default ioremap_nocache() behaviour
> from UC- to UC can therefore regress a memory
> region from effective memory type WC to UC if MTRRs
> are used. Use of MTRRs should be phased out and in
> the best case only arch_phys_wc_add() use will remain,
> even if this happens arch_phys_wc_add() will have an
> effect on non-PAT systems and changes to default
> ioremap_nocache() behaviour could regress drivers.
> 
> Now, ideally we'd use ioremap_nocache() on the regions
> in which we'd need uncachable memory types and avoid
> any MTRRs on those regions. There are however some
> restrictions on MTRRs use, such as the requirement of
> having the base and size of variable sized MTRRs
> to be powers of two, which could mean having to use
> a WC MTRR over a large area which includes a region
> in which write-combining effects are undesirable.
> 
> Add ioremap_uc() to help with the both phasing out of
> MTRR use and also provide a way to blacklist small
> WC undesirable regions in devices with mixed regions
> which are size-implicated to use large WC MTRRs. Use
> of ioremap_uc() helps phase out MTRR use by avoiding
> regressions with an eventual flip of default behaviour
> or ioremap_nocache() from UC- to UC.
> 
> Drivers working with WC MTRRs can use the below table
> to review and consider the use of ioremap*() and similar
> helpers to ensure appropriate behaviour long term even
> if default ioremap_nocache() behaviour changes from UC-
> to UC.
> 
> Although ioremap_uc() is being added we leave set_memory_uc()
> to use UC- as only initial memory type setup is required
> to be able to accomodate existing device drivers and phase
> out MTRR use. It should also be clarified that set_memory_uc()
> cannot be used with IO memory, even though its use will
> not return any errors, it really has no effect.
> 
> ----------------------------------------------------------------------
> MTRR Non-PAT   PAT    Linux ioremap value        Effective memory type
> ----------------------------------------------------------------------
>                                                   Non-PAT |  PAT
>      PAT
>      |PCD
>      ||PWT
>      |||
> WC   000      WB      _PAGE_CACHE_MODE_WB            WC   |   WC
> WC   001      WC      _PAGE_CACHE_MODE_WC            WC*  |   WC
> WC   010      UC-     _PAGE_CACHE_MODE_UC_MINUS      WC*  |   WC
> WC   011      UC      _PAGE_CACHE_MODE_UC            UC   |   UC
> ----------------------------------------------------------------------
> 
> Cc: Toshi Kani <toshi.kani@hp.com>
> Cc: Andy Lutomirski <luto@amacapital.net>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Suresh Siddha <sbsiddha@gmail.com>
> Cc: Ingo Molnar <mingo@elte.hu>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Juergen Gross <jgross@suse.com>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: Dave Airlie <airlied@redhat.com>
> Cc: Antonino Daplas <adaplas@gmail.com>
> Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Cc: Ville Syrjälä <syrjala@sci.fi>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Thierry Reding <treding@nvidia.com>
> Cc: Mike Travis <travis@sgi.com>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Borislav Petkov <bp@suse.de>
> Cc: Davidlohr Bueso <dbueso@suse.de>
> Cc: x86@kernel.org
> Cc: linux-fbdev@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Luis R. Rodriguez <mcgrof@suse.com>
> ---
>  arch/x86/include/asm/io.h |  1 +
>  arch/x86/mm/ioremap.c     | 36 +++++++++++++++++++++++++++++++++++-
>  arch/x86/mm/pageattr.c    |  3 +++
>  include/asm-generic/io.h  |  8 ++++++++
>  4 files changed, 47 insertions(+), 1 deletion(-)

Looks ok to me. Applied, thanks.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
