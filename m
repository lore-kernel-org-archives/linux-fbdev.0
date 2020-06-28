From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Date: Sun, 28 Jun 2020 08:50:11 +0000
Subject: Re: [PATCH] efi: avoid error message when booting under Xen
Message-Id: <094be567-2c82-7d5b-e432-288286c6c3fb@suse.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200610141052.13258-1-jgross@suse.com>
In-Reply-To: <20200610141052.13258-1-jgross@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: xen-devel@lists.xenproject.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Peter Jones <pjones@redhat.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Ping?

On 10.06.20 16:10, Juergen Gross wrote:
> efifb_probe() will issue an error message in case the kernel is booted
> as Xen dom0 from UEFI as EFI_MEMMAP won't be set in this case. Avoid
> that message by calling efi_mem_desc_lookup() only if EFI_PARAVIRT
> isn't set.
> 
> Fixes: 38ac0287b7f4 ("fbdev/efifb: Honour UEFI memory map attributes when mapping the FB")
> Signed-off-by: Juergen Gross <jgross@suse.com>
> ---
>   drivers/video/fbdev/efifb.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/video/fbdev/efifb.c b/drivers/video/fbdev/efifb.c
> index 65491ae74808..f5eccd1373e9 100644
> --- a/drivers/video/fbdev/efifb.c
> +++ b/drivers/video/fbdev/efifb.c
> @@ -453,7 +453,7 @@ static int efifb_probe(struct platform_device *dev)
>   	info->apertures->ranges[0].base = efifb_fix.smem_start;
>   	info->apertures->ranges[0].size = size_remap;
>   
> -	if (efi_enabled(EFI_BOOT) &&
> +	if (efi_enabled(EFI_BOOT) && !efi_enabled(EFI_PARAVIRT) &&
>   	    !efi_mem_desc_lookup(efifb_fix.smem_start, &md)) {
>   		if ((efifb_fix.smem_start + efifb_fix.smem_len) >
>   		    (md.phys_addr + (md.num_pages << EFI_PAGE_SHIFT))) {
> 
