From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 10 Jul 2020 14:27:13 +0000
Subject: Re: [PATCH v2] efi: avoid error message when booting under Xen
Message-Id: <CAMj1kXEdm8MrdWVLO0w_-LJLvpiUURHhazv4-B39L1Bbk8kqFw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200710142253.28070-1-jgross@suse.com>
In-Reply-To: <20200710142253.28070-1-jgross@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Juergen Gross <jgross@suse.com>
Cc: linux-fbdev@vger.kernel.org, linux-efi <linux-efi@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org, Peter Jones <pjones@redhat.com>, xen-devel@lists.xenproject.org

On Fri, 10 Jul 2020 at 17:24, Juergen Gross <jgross@suse.com> wrote:
>
> efifb_probe() will issue an error message in case the kernel is booted
> as Xen dom0 from UEFI as EFI_MEMMAP won't be set in this case. Avoid
> that message by calling efi_mem_desc_lookup() only if EFI_MEMMAP is set.
>
> Fixes: 38ac0287b7f4 ("fbdev/efifb: Honour UEFI memory map attributes when mapping the FB")
> Signed-off-by: Juergen Gross <jgross@suse.com>

Acked-by: Ard Biesheuvel <ardb@kernel.org>

> ---
>  drivers/video/fbdev/efifb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/video/fbdev/efifb.c b/drivers/video/fbdev/efifb.c
> index 65491ae74808..e57c00824965 100644
> --- a/drivers/video/fbdev/efifb.c
> +++ b/drivers/video/fbdev/efifb.c
> @@ -453,7 +453,7 @@ static int efifb_probe(struct platform_device *dev)
>         info->apertures->ranges[0].base = efifb_fix.smem_start;
>         info->apertures->ranges[0].size = size_remap;
>
> -       if (efi_enabled(EFI_BOOT) &&
> +       if (efi_enabled(EFI_MEMMAP) &&
>             !efi_mem_desc_lookup(efifb_fix.smem_start, &md)) {
>                 if ((efifb_fix.smem_start + efifb_fix.smem_len) >
>                     (md.phys_addr + (md.num_pages << EFI_PAGE_SHIFT))) {
> --
> 2.26.2
>
