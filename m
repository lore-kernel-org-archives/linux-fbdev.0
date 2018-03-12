From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Mon, 12 Mar 2018 15:31:23 +0000
Subject: Re: [PATCH] video: offb: Deallocate the color map
Message-Id: <2500950.WnLxRKliRb@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20180213180825epcas1p44674e978de3188bb9a42970b28e20d52@epcas1p4.samsung.com>
 <20180213180747.12666-1-malat@debian.org>
In-Reply-To: <20180213180747.12666-1-malat@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mathieu Malaterre <malat@debian.org>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org

On Tuesday, February 13, 2018 07:07:45 PM Mathieu Malaterre wrote:
> The function offb_destroy did not deallocate the color map leaving some
> memory around after destruction. Call the color map deallocate function to
> remove the memory leak.
> 
> Handle another case where color map should have been deallocated during an
> error code path.
> 
> Fix memory leaks reported by kmemleak:
> 
> # dmesg
> ...
> [ 1884.719941] kmemleak: 3 new suspected memory leaks (see /sys/kernel/debug/kmemleak)
> # cat /sys/kernel/debug/kmemleak
> unreferenced object 0xde3d9000 (size 512):
>   comm "swapper", pid 1, jiffies 4294892827 (age 1906.784s)
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 aa aa aa aa aa aa aa aa  ................
>     55 55 55 55 55 55 55 55 ff ff ff ff ff ff ff ff  UUUUUUUU........
>   backtrace:
>     [<f1433400>] fb_alloc_cmap_gfp+0x54/0x15c
>     [<cb6b409b>] offb_init_nodriver+0x8e8/0xa3c
>     [<b5a1c019>] offb_init+0xd0/0x164
>     [<322f82a3>] do_one_initcall+0x4c/0x178
>     [<b592db9f>] kernel_init_freeable+0x138/0x1cc
>     [<2a17fa0e>] kernel_init+0x24/0x118
>     [<4079749a>] ret_from_kernel_thread+0x5c/0x64
> unreferenced object 0xde3d9200 (size 512):
>   comm "swapper", pid 1, jiffies 4294892827 (age 1906.784s)
>   hex dump (first 32 bytes):
>     00 00 00 00 aa aa aa aa 00 00 00 00 55 55 aa aa  ............UU..
>     55 55 55 55 ff ff ff ff 55 55 55 55 ff ff ff ff  UUUU....UUUU....
>   backtrace:
>     [<4bf3594d>] fb_alloc_cmap_gfp+0x6c/0x15c
>     [<cb6b409b>] offb_init_nodriver+0x8e8/0xa3c
>     [<b5a1c019>] offb_init+0xd0/0x164
>     [<322f82a3>] do_one_initcall+0x4c/0x178
>     [<b592db9f>] kernel_init_freeable+0x138/0x1cc
>     [<2a17fa0e>] kernel_init+0x24/0x118
>     [<4079749a>] ret_from_kernel_thread+0x5c/0x64
> unreferenced object 0xde3d9600 (size 512):
>   comm "swapper", pid 1, jiffies 4294892827 (age 1906.784s)
>   hex dump (first 32 bytes):
>     00 00 aa aa 00 00 aa aa 00 00 aa aa 00 00 aa aa  ................
>     55 55 ff ff 55 55 ff ff 55 55 ff ff 55 55 ff ff  UU..UU..UU..UU..
>   backtrace:
>     [<23a3ea03>] fb_alloc_cmap_gfp+0x84/0x15c
>     [<cb6b409b>] offb_init_nodriver+0x8e8/0xa3c
>     [<b5a1c019>] offb_init+0xd0/0x164
>     [<322f82a3>] do_one_initcall+0x4c/0x178
>     [<b592db9f>] kernel_init_freeable+0x138/0x1cc
>     [<2a17fa0e>] kernel_init+0x24/0x118
>     [<4079749a>] ret_from_kernel_thread+0x5c/0x64
> 
> Signed-off-by: Mathieu Malaterre <malat@debian.org>

Patch queued for 4.17, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

