From: Conor O <falling174fps@gmail.com>
Date: Sat, 15 Mar 2014 11:29:06 +0000
Subject: Possible bug in deferred io with mmaped memory?
Message-Id: <CAAtz+1YfwnSQZMjpA3aKCKG7u1+kXLx+zbQAF6NV3oMsxVd6KQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hello all, I hope this is a reasonable place to post a bug. If I fix
it I can post a fix too.

I believe there might be a bug in deferred io. In my fb driver I have
a block of memory, allocated with kmalloc, that I can mmap, write to,
and munmap perfectly fine using my own mmap routine. As soon as I
switch to deferred io, there's a problem:

From userspace, I can mmap the framebuffer memory fine and write to
it. The deferred io driver routine is called and updates the display
perfectly correctly. As soon as I call munmap() I get a repeated
kernel messages. This happens on ARM but not under an Ubuntu
Virtualbox VM (x86):

BUG: Bad page state in process fbtest1  pfn:ad11d
page:c0dc03a0 count:0 mapcount:0 mapping:edbf7144 index:0x1d
page flags: 0x94(referenced|dirty|slab)
Modules linked in: hhlcd28a(O) sysimgblt sysfillrect syscopyarea
fb_sys_fops bnep ipv6 mwifiex_sdio mwifiex btmrvl_sdio firmware_class
btmrvl cfg80211 bluetooth rfkill
[<c0014bc8>] (unwind_backtrace+0x0/0x11c) from [<c00c44d4>] (bad_page+0xd0/0xfc)
[<c00c44d4>] (bad_page+0xd0/0xfc) from [<c00c45c0>]
(free_pages_prepare+0xc0/0x150)
[<c00c45c0>] (free_pages_prepare+0xc0/0x150) from [<c00c5a34>]
(free_hot_cold_page+0x20/0x188)
[<c00c5a34>] (free_hot_cold_page+0x20/0x188) from [<c00c5dc4>]
(free_hot_cold_page_list+0x7c/0x9c)
[<c00c5dc4>] (free_hot_cold_page_list+0x7c/0x9c) from [<c00c90c0>]
(release_pages+0x1b4/0x1c8)
[<c00c90c0>] (release_pages+0x1b4/0x1c8) from [<c00ea854>]
(free_pages_and_swap_cache+0x8c/0x9c)
[<c00ea854>] (free_pages_and_swap_cache+0x8c/0x9c) from [<c00dfff4>]
(unmap_region+0x100/0x154)
[<c00dfff4>] (unmap_region+0x100/0x154) from [<c00e116c>]
(do_munmap+0x218/0x2a4)
[<c00e116c>] (do_munmap+0x218/0x2a4) from [<c00e1234>] (vm_munmap+0x3c/0x50)
[<c00e1234>] (vm_munmap+0x3c/0x50) from [<c000dc20>] (ret_fast_syscall+0x0/0x30)

[repeated for N pages]

root@duovero:~/testdrv#

I will now convert to using vmalloc and check to see if this happens too.

Thanks,

Conor.
