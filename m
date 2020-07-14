From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Tue, 14 Jul 2020 07:43:55 +0000
Subject: Re: [PATCH v2] efi: avoid error message when booting under Xen
Message-Id: <0a5494ff-431d-5667-680f-77987cff2984@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20200710142443eucas1p120b3d15e1f7be8bb95ffb9d83875fa70@eucas1p1.samsung.com>
 <20200710142253.28070-1-jgross@suse.com>
In-Reply-To: <20200710142253.28070-1-jgross@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Juergen Gross <jgross@suse.com>
Cc: linux-fbdev@vger.kernel.org, linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Peter Jones <pjones@redhat.com>, xen-devel@lists.xenproject.org, Ard Biesheuvel <ardb@kernel.org>


On 7/10/20 4:22 PM, Juergen Gross wrote:
> efifb_probe() will issue an error message in case the kernel is booted
> as Xen dom0 from UEFI as EFI_MEMMAP won't be set in this case. Avoid
> that message by calling efi_mem_desc_lookup() only if EFI_MEMMAP is set.
> 
> Fixes: 38ac0287b7f4 ("fbdev/efifb: Honour UEFI memory map attributes when mapping the FB")
> Signed-off-by: Juergen Gross <jgross@suse.com>

Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
>  drivers/video/fbdev/efifb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/video/fbdev/efifb.c b/drivers/video/fbdev/efifb.c
> index 65491ae74808..e57c00824965 100644
> --- a/drivers/video/fbdev/efifb.c
> +++ b/drivers/video/fbdev/efifb.c
> @@ -453,7 +453,7 @@ static int efifb_probe(struct platform_device *dev)
>  	info->apertures->ranges[0].base = efifb_fix.smem_start;
>  	info->apertures->ranges[0].size = size_remap;
>  
> -	if (efi_enabled(EFI_BOOT) &&
> +	if (efi_enabled(EFI_MEMMAP) &&
>  	    !efi_mem_desc_lookup(efifb_fix.smem_start, &md)) {
>  		if ((efifb_fix.smem_start + efifb_fix.smem_len) >
>  		    (md.phys_addr + (md.num_pages << EFI_PAGE_SHIFT))) {
> 
