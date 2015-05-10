From: Greg KH <gregkh@linuxfoundation.org>
Date: Sun, 10 May 2015 13:09:03 +0000
Subject: Re: [PATCH v4] staging: sm750fb: use arch_phys_wc_add() and ioremap_wc()
Message-Id: <20150510130903.GA30824@kroah.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1430784951-16505-1-git-send-email-mcgrof@do-not-panic.com>
In-Reply-To: <1430784951-16505-1-git-send-email-mcgrof@do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, devel@driverdev.osuosl.org, Juergen Gross <jgross@suse.com>, linux-fbdev@vger.kernel.org, Antonino Daplas <adaplas@gmail.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, "Luis R. Rodriguez" <mcgrof@suse.com>, linux-kernel@vger.kernel.org, luto@amacapital.net, Tomi Valkeinen <tomi.valkeinen@ti.com>, Thomas Gleixner <tglx@linutronix.de>, Suresh Siddha <sbsiddha@gmail.com>, Dave Airlie <airlied@redhat.com>, Ingo Molnar <mingo@elte.hu>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, cocci@systeme.lip6.fr

On Mon, May 04, 2015 at 05:15:51PM -0700, Luis R. Rodriguez wrote:
> From: "Luis R. Rodriguez" <mcgrof@suse.com>
> 
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
>    _PAGE_CACHE_UC_MINUS on x86 on ioremap_nocache() (see commit
>    de33c442e titled "x86 PAT: fix performance drop for glx,
>    use UC minus for ioremap(), ioremap_nocache() and
>    pci_mmap_page_range()")
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
> Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
> Cc: Teddy Wang <teddy.wang@siliconmotion.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Suresh Siddha <sbsiddha@gmail.com>
> Cc: Ingo Molnar <mingo@elte.hu>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Juergen Gross <jgross@suse.com>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: Andy Lutomirski <luto@amacapital.net>
> Cc: Dave Airlie <airlied@redhat.com>
> Cc: Antonino Daplas <adaplas@gmail.com>
> Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Cc: devel@driverdev.osuosl.org
> Cc: linux-fbdev@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Luis R. Rodriguez <mcgrof@suse.com>
> ---
>  drivers/staging/sm750fb/sm750.c    | 36 ++++--------------------------------
>  drivers/staging/sm750fb/sm750.h    |  3 ---
>  drivers/staging/sm750fb/sm750_hw.c |  3 +--
>  3 files changed, 5 insertions(+), 37 deletions(-)

Still doesn't apply to my tree:

checking file drivers/staging/sm750fb/sm750.c
Hunk #4 FAILED at 1150.
1 out of 6 hunks FAILED
checking file drivers/staging/sm750fb/sm750.h
checking file drivers/staging/sm750fb/sm750_hw.c
