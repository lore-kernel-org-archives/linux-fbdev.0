From: Borislav Petkov <bp@alien8.de>
Date: Mon, 04 May 2015 12:23:03 +0000
Subject: Re: [PATCH v4 2/6] x86: document WC MTRR effects on PAT / non-PAT pages
Message-Id: <20150504122303.GD4096@pd.tnic>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1430343851-967-1-git-send-email-mcgrof@do-not-panic.com>
 <1430343851-967-3-git-send-email-mcgrof@do-not-panic.com>
In-Reply-To: <1430343851-967-3-git-send-email-mcgrof@do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: mingo@elte.hu, tglx@linutronix.de, hpa@zytor.com, bp@suse.de, plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, daniel.vetter@intel.com, airlied@linux.ie, dledford@redhat.com, awalls@md.metrocast.net, syrjala@sci.fi, luto@amacapital.net, mst@redhat.com, cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org, "Luis R. Rodriguez" <mcgrof@suse.com>, Toshi Kani <toshi.kani@hp.com>, Jonathan Corbet <corbet@lwn.net>, Dave Hansen <dave.hansen@linux.intel.com>, Suresh Siddha <sbsiddha@gmail.com>, Juergen Gross <jgross@suse.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Dave Airlie <airlied@redhat.com>, Antonino Daplas <adaplas@gmail.com>, Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>, Davidlohr Bueso <dbueso@suse.de>, linux-fbdev@vger.kernel.org

On Wed, Apr 29, 2015 at 02:44:07PM -0700, Luis R. Rodriguez wrote:
> From: "Luis R. Rodriguez" <mcgrof@suse.com>
> 
> As part of the effort to phase out MTRR use document
> write-combining MTRR effects on pages with different
> non-PAT page attributes flags and different PAT entry
> values. Extend arch_phys_wc_add() documentation to
> clarify power of two sizes / boundary requirements as
> we phase out mtrr_add() use.
> 
> Lastly hint towards ioremap_uc() for corner cases on
> device drivers working with devices with mixed regions
> where MTRR size requirements would otherwise not
> enable write-combining effective memory types.
> 
> Cc: Toshi Kani <toshi.kani@hp.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Andy Lutomirski <luto@amacapital.net>
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
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Borislav Petkov <bp@suse.de>
> Cc: Davidlohr Bueso <dbueso@suse.de>
> Cc: linux-fbdev@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Luis R. Rodriguez <mcgrof@suse.com>
> ---
>  Documentation/x86/mtrr.txt      | 18 +++++++++++++++---
>  Documentation/x86/pat.txt       | 40 +++++++++++++++++++++++++++++++++++++++-
>  arch/x86/kernel/cpu/mtrr/main.c |  3 +++
>  3 files changed, 57 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/x86/mtrr.txt b/Documentation/x86/mtrr.txt
> index cc071dc..a111a6c 100644
> --- a/Documentation/x86/mtrr.txt
> +++ b/Documentation/x86/mtrr.txt
> @@ -1,7 +1,19 @@
>  MTRR (Memory Type Range Register) control
> -3 Jun 1999
> -Richard Gooch
> -<rgooch@atnf.csiro.au>
> +
> +Richard Gooch <rgooch@atnf.csiro.au> - 3 Jun 1999
> +Luis R. Rodriguez <mcgrof@do-not-panic.com> - April 9, 2015
> +
> +=======================================> +Phasing MTRR use

"Phasing out...".

> +
> +MTRR use is replaced on modern x86 hardware with PAT. Over time the only type
> +of effective MTRR that is expected to be supported will be for write-combining.
> +As MTRR use is phased out device drivers should use arch_phys_wc_add() to make
> +MTRR effective on non-PAT systems while a no-op on PAT enabled systems.
> +
> +For details refer to Documentation/x86/pat.txt.
> +
> +=======================================>  
>    On Intel P6 family processors (Pentium Pro, Pentium II and later)
>    the Memory Type Range Registers (MTRRs) may be used to control
> diff --git a/Documentation/x86/pat.txt b/Documentation/x86/pat.txt
> index cf08c9f..7e183e3 100644
> --- a/Documentation/x86/pat.txt
> +++ b/Documentation/x86/pat.txt
> @@ -34,6 +34,8 @@ ioremap                |    --    |    UC-     |       UC-        |
>                         |          |            |                  |
>  ioremap_cache          |    --    |    WB      |       WB         |
>                         |          |            |                  |
> +ioremap_uc             |    --    |    UC      |       UC         |
> +                       |          |            |                  |
>  ioremap_nocache        |    --    |    UC-     |       UC-        |
>                         |          |            |                  |
>  ioremap_wc             |    --    |    --      |       WC         |
> @@ -102,7 +104,43 @@ wants to export a RAM region, it has to do set_memory_uc() or set_memory_wc()
>  as step 0 above and also track the usage of those pages and use set_memory_wb()
>  before the page is freed to free pool.
>  
> -
> +MTRR effects on PAT / non-PAT systems
> +-------------------------------------
> +
> +The following table provides the effects of using write-combining MTRRs when
> +using ioremap*() calls on x86 for both non-PAT and PAT systems. Ideally
> +mtrr_add() usage will be phased in favor of arch_phys_wc_add() which will

				out

> +be a no-op on PAT enabled systems. The region over which a arch_phys_wc_add()
> +is made should already have be ioremap'd with write-combining page attributes

	 , 		have been ioremapped with WC attributes...

> +or PAT entries, this can be done by using ioremap_wc() / or respective helpers.
> +Devices which combine areas of IO memory desired to remain uncachable with
> +areas where write-combining is desirable and are restricted by the size
> +requirements of MTRRs should consider splitting up their IO memory space
> +cleanly with ioremap_uc() and ioremap_wc() followed by an arch_phys_wc_add()
> +encompassing both regions. Such use is nevertheless heavily discouraged as
> +the effective memory type is considered implementation defined. This strategy
> +should only be used as last resort on devices with size-contrained regions
> +where otherwise MTRR write-combining would not be effective.
> +
> +Note that you cannot use set_memory_wc() to override / whitelist IO remapped
> +memory space mapped with ioremap*() calls, set_memory_wc() can only be used
> +on RAM.
> +
> +----------------------------------------------------------------------
> +MTRR Non-PAT   PAT    Linux ioremap value        Effective memory type
> +----------------------------------------------------------------------
> +                                                  Non-PAT |  PAT
> +     PAT
> +     |PCD
> +     ||PWT
> +     |||
> +WC   000      WB      _PAGE_CACHE_MODE_WB            WC   |   WC
> +WC   001      WC      _PAGE_CACHE_MODE_WC            WC*  |   WC
> +WC   010      UC-     _PAGE_CACHE_MODE_UC_MINUS      WC*  |   WC
> +WC   011      UC      _PAGE_CACHE_MODE_UC            UC   |   UC
> +----------------------------------------------------------------------
> +
> +(*) denotes implementation defined and is discouraged
>  
>  Notes:
>  
> diff --git a/arch/x86/kernel/cpu/mtrr/main.c b/arch/x86/kernel/cpu/mtrr/main.c
> index ea5f363..12abdbe 100644
> --- a/arch/x86/kernel/cpu/mtrr/main.c
> +++ b/arch/x86/kernel/cpu/mtrr/main.c
> @@ -538,6 +538,9 @@ EXPORT_SYMBOL(mtrr_del);
>   * attempts to add a WC MTRR covering size bytes starting at base and
>   * logs an error if this fails.
>   *
> + * The caller should expect to need to provide a power of two size on an
> + * equivalent power of two boundary.
> + *
>   * Drivers must store the return value to pass to mtrr_del_wc_if_needed,
>   * but drivers should not try to interpret that return value.
>   */
> -- 
> 2.3.2.209.gd67f9d5.dirty
> 

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
