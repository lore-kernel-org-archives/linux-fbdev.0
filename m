From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Mon, 09 Mar 2015 07:42:53 +0000
Subject: Re: [PATCH v2 1/4] staging: sm750fb: wrong type for print
Message-Id: <CA+V-a8s65fCvd2cA6w2EwaJfaLgPqQ=Hme+m9_wv+y3Y=GxPiQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1425886506-8643-1-git-send-email-sudipm.mukherjee@gmail.com>
In-Reply-To: <1425886506-8643-1-git-send-email-sudipm.mukherjee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, LFBDEV <linux-fbdev@vger.kernel.org>, OSUOSL Drivers <devel@driverdev.osuosl.org>, LKML <linux-kernel@vger.kernel.org>

On Mon, Mar 9, 2015 at 7:35 AM, Sudip Mukherjee
<sudipm.mukherjee@gmail.com> wrote:
> mention correct format specifier while printing.
> fixes all the build warnings about incorrect argument type while
> printing.
>
> Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
> ---
>
> V2: Giedrius commented resource_size_t can be either u64 or u32
> depending on if CONFIG_PHYS_ADDR_T_64BIT. based on his comments i
> should have kept the datatype as resource_size_t and  used %pa as the
> format specifier. But since this is a framebuffer device and it
> should follow what the framebuffer layer is suggesting in
> struct fb_fix_screeninfo at smem_start and mmio_start.
> adding Tomi for his comments.
>
> this patch will give checkpatch warnings about use of printk.
> this patch was mainly to fix the build warnings. printk will be
> converted to pr_* and dev_* in a later patch.
>
>  drivers/staging/sm750fb/sm750.c    | 24 ++++++++++++------------
>  drivers/staging/sm750fb/sm750.h    |  8 ++++----
>  drivers/staging/sm750fb/sm750_hw.c |  4 ++--
>  3 files changed, 18 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
> index 520c69e..753869e 100644
> --- a/drivers/staging/sm750fb/sm750.c
> +++ b/drivers/staging/sm750fb/sm750.c
> @@ -530,20 +530,20 @@ static int lynxfb_ops_mmap(struct fb_info * info, struct vm_area_struct * vma)
>         if (vma->vm_pgoff > (~0UL >> PAGE_SHIFT))
>                 return -EINVAL;
>         off = vma->vm_pgoff << PAGE_SHIFT;
> -       printk("lynxfb mmap pgoff: %x\n", vma->vm_pgoff);
> -       printk("lynxfb mmap off 1: %x\n", off);
> +       printk("lynxfb mmap pgoff: %lx\n", vma->vm_pgoff);
> +       printk("lynxfb mmap off 1: %lx\n", off);
>
wouldn't it makes sense to change printk to some pr_*() ?

Cheers,
--Prabhakar Lad
