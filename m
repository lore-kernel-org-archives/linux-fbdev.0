From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 10 Jul 2020 13:27:23 +0000
Subject: Re: [PATCH] efi: avoid error message when booting under Xen
Message-Id: <CAMj1kXGE52Y6QQhGLU6r_9x6TVftZqfS7zyLCiDusZhV4tbhjg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200610141052.13258-1-jgross@suse.com>
 <094be567-2c82-7d5b-e432-288286c6c3fb@suse.com>
 <CGME20200709091750eucas1p18003b0c8127600369485c62c1e587c22@eucas1p1.samsung.com>
 <ec21b883-dc5c-f3fe-e989-7fa13875a4c4@suse.com>
 <170e01b1-220d-5cb7-03b2-c70ed3ae58e4@samsung.com>
In-Reply-To: <170e01b1-220d-5cb7-03b2-c70ed3ae58e4@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>, linux-fbdev@vger.kernel.org, linux-efi <linux-efi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org, Peter Jones <pjones@redhat.com>, xen-devel@lists.xenproject.org

On Fri, 10 Jul 2020 at 13:17, Bartlomiej Zolnierkiewicz
<b.zolnierkie@samsung.com> wrote:
>
>
> [ added EFI Maintainer & ML to Cc: ]
>
> Hi,
>
> On 7/9/20 11:17 AM, Jürgen Groß wrote:
> > On 28.06.20 10:50, Jürgen Groß wrote:
> >> Ping?
> >>
> >> On 10.06.20 16:10, Juergen Gross wrote:
> >>> efifb_probe() will issue an error message in case the kernel is booted
> >>> as Xen dom0 from UEFI as EFI_MEMMAP won't be set in this case. Avoid
> >>> that message by calling efi_mem_desc_lookup() only if EFI_PARAVIRT
> >>> isn't set.
> >>>

Why not test for EFI_MEMMAP instead of EFI_BOOT?


> >>> Fixes: 38ac0287b7f4 ("fbdev/efifb: Honour UEFI memory map attributes when mapping the FB")
> >>> Signed-off-by: Juergen Gross <jgross@suse.com>
> >>> ---
> >>>   drivers/video/fbdev/efifb.c | 2 +-
> >>>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/video/fbdev/efifb.c b/drivers/video/fbdev/efifb.c
> >>> index 65491ae74808..f5eccd1373e9 100644
> >>> --- a/drivers/video/fbdev/efifb.c
> >>> +++ b/drivers/video/fbdev/efifb.c
> >>> @@ -453,7 +453,7 @@ static int efifb_probe(struct platform_device *dev)
> >>>       info->apertures->ranges[0].base = efifb_fix.smem_start;
> >>>       info->apertures->ranges[0].size = size_remap;
> >>> -    if (efi_enabled(EFI_BOOT) &&
> >>> +    if (efi_enabled(EFI_BOOT) && !efi_enabled(EFI_PARAVIRT) &&
> >>>           !efi_mem_desc_lookup(efifb_fix.smem_start, &md)) {
> >>>           if ((efifb_fix.smem_start + efifb_fix.smem_len) >
> >>>               (md.phys_addr + (md.num_pages << EFI_PAGE_SHIFT))) {
> >>>
> >>
> >
> > In case I see no reaction from the maintainer for another week I'll take
> > this patch through the Xen tree.
>
> From fbdev POV this change looks fine to me and I'm OK with merging it
> through Xen or EFI tree:
>
> Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
>
> Best regards,
> --
> Bartlomiej Zolnierkiewicz
> Samsung R&D Institute Poland
> Samsung Electronics
