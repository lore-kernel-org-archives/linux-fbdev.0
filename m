From: "Luis R. Rodriguez" <mcgrof@suse.com>
Date: Thu, 30 Apr 2015 17:40:08 +0000
Subject: Re: [PATCH v1 23/47] staging: xgifb: use arch_phys_wc_add() and ioremap_wc()
Message-Id: <CAB=NE6VO6A9z4GaV_sW=ss+ZBzDEhZAQCrcBvL79azDbiH8k=A@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1426893517-2511-1-git-send-email-mcgrof@do-not-panic.com> <1426893517-2511-24-git-send-email-mcgrof@do-not-panic.com>
In-Reply-To: <1426893517-2511-24-git-send-email-mcgrof@do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andy Lutomirski <luto@amacapital.net>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Juergen Gross <jgross@suse.com>, Jan Beulich <JBeulich@suse.com>, Borislav Petkov <bp@suse.de>, Suresh Siddha <suresh.b.siddha@intel.com>, venkatesh.pallipadi@intel.com, Dave Airlie <airlied@redhat.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-fbdev <linux-fbdev@vger.kernel.org>, X86 ML <x86@kernel.org>, xen-devel@lists.xenproject.org, "Luis R. Rodriguez" <mcgrof@suse.com>, Ingo Molnar <mingo@elte.hu>, Daniel Vetter <daniel.vetter@ffwll.ch>, Antonino Daplas <adaplas@gmail.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

On Fri, Mar 20, 2015 at 4:18 PM, Luis R. Rodriguez
<mcgrof@do-not-panic.com> wrote:
> The same area used for ioremap() is used for the MTRR area.
> Convert the driver from using the x86 specific MTRR code to
> the architecture agnostic arch_phys_wc_add(). arch_phys_wc_add()
> will avoid MTRR if write-combining is available, in order to
> take advantage of that also ensure the ioremap'd area is requested
> as write-combining.
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
>
> The conversion done is expressed by the following Coccinelle
> SmPL patch, it additionally required manual intervention to
> address all the #ifdery and removal of redundant things which
> arch_phys_wc_add() already addresses such as verbose message
> about when MTRR fails and doing nothing when we didn't get
> an MTRR.
>
> @ mtrr_found @
> expression index, base, size;
> @@
>
> -index = mtrr_add(base, size, MTRR_TYPE_WRCOMB, 1);
> +index = arch_phys_wc_add(base, size);
>
> @ mtrr_rm depends on mtrr_found @
> expression mtrr_found.index, mtrr_found.base, mtrr_found.size;
> @@
>
> -mtrr_del(index, base, size);
> +arch_phys_wc_del(index);
>
> @ mtrr_rm_zero_arg depends on mtrr_found @
> expression mtrr_found.index;
> @@
>
> -mtrr_del(index, 0, 0);
> +arch_phys_wc_del(index);
>
> @ mtrr_rm_fb_info depends on mtrr_found @
> struct fb_info *info;
> expression mtrr_found.index;
> @@
>
> -mtrr_del(index, info->fix.smem_start, info->fix.smem_len);
> +arch_phys_wc_del(index);
>
> @ ioremap_replace_nocache depends on mtrr_found @
> struct fb_info *info;
> expression base, size;
> @@
>
> -info->screen_base = ioremap_nocache(base, size);
> +info->screen_base = ioremap_wc(base, size);
>
> @ ioremap_replace_default depends on mtrr_found @
> struct fb_info *info;
> expression base, size;
> @@
>
> -info->screen_base = ioremap(base, size);
> +info->screen_base = ioremap_wc(base, size);
>
> Generated-by: Coccinelle SmPL
> Cc: Suresh Siddha <suresh.b.siddha@intel.com>
> Cc: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
> Cc: Ingo Molnar <mingo@elte.hu>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Juergen Gross <jgross@suse.com>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: Andy Lutomirski <luto@amacapital.net>
> Cc: Dave Airlie <airlied@redhat.com>
> Cc: Antonino Daplas <adaplas@gmail.com>
> Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Cc: linux-fbdev@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Luis R. Rodriguez <mcgrof@suse.com>

Hey folks, can this be considered to be merged.

Thanks,

  Luis
