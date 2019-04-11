From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Thu, 11 Apr 2019 15:44:20 +0000
Subject: Re: [PATCH v2] fbdev: fix WARNING in __alloc_pages_nodemask bug
Message-Id: <22269220-5e37-7ccb-f4cb-c776d7a964e2@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org


On 03/28/2019 10:38 AM, Jiufei Xue wrote:
> Syzkaller hit 'WARNING in __alloc_pages_nodemask' bug.
> 
> WARNING: CPU: 1 PID: 1473 at mm/page_alloc.c:4377
> __alloc_pages_nodemask+0x4da/0x2130
> Kernel panic - not syncing: panic_on_warn set ...
> 
> Call Trace:
>  alloc_pages_current+0xb1/0x1e0
>  kmalloc_order+0x1f/0x60
>  kmalloc_order_trace+0x1d/0x120
>  fb_alloc_cmap_gfp+0x85/0x2b0
>  fb_set_user_cmap+0xff/0x370
>  do_fb_ioctl+0x949/0xa20
>  fb_ioctl+0xdd/0x120
>  do_vfs_ioctl+0x186/0x1070
>  ksys_ioctl+0x89/0xa0
>  __x64_sys_ioctl+0x74/0xb0
>  do_syscall_64+0xc8/0x550
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 
> This is a warning about order >= MAX_ORDER and the order is from
> userspace ioctl. Add flag __NOWARN to silence this warning.
> 
> Signed-off-by: Jiufei Xue <jiufei.xue@linux.alibaba.com>

Patch queued for v5.2, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
