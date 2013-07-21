From: "Alexandra N. Kossovsky" <Alexandra.Kossovsky@oktetlabs.ru>
Date: Sun, 21 Jul 2013 15:11:51 +0000
Subject: kmemleak warning in efifb_probe
Message-Id: <20130721151151.GK24717@sanechka.spb.ru>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Peter Jones <pjones@redhat.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello.

I am running linux-3.10.0 with kmemleak and see following warnings
in /sys/kernel/debug/kmemleak:

unreferenced object 0xffff880216fcfe00 (size 512):
  comm "swapper/0", pid 1, jiffies 4294895429 (age 1415.320s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 aa aa aa aa aa aa aa aa  ................
    55 55 55 55 55 55 55 55 ff ff ff ff ff ff ff ff  UUUUUUUU........
  backtrace:
    [<ffffffff813e415c>] kmemleak_alloc+0x21/0x3e
    [<ffffffff8111c17f>] kmemleak_alloc_recursive.constprop.57+0x16/0x18
    [<ffffffff8111e63b>] __kmalloc+0xf9/0x144
    [<ffffffff8123d9cf>] fb_alloc_cmap_gfp+0x47/0xe1
    [<ffffffff8123da77>] fb_alloc_cmap+0xe/0x10
    [<ffffffff81aff40a>] efifb_probe+0x3e9/0x48f
    [<ffffffff812c566f>] platform_drv_probe+0x34/0x5e
    [<ffffffff812c3e6d>] driver_probe_device+0x98/0x1b4
    [<ffffffff812c3fd7>] __driver_attach+0x4e/0x6f
    [<ffffffff812c25bf>] bus_for_each_dev+0x57/0x8a
    [<ffffffff812c3984>] driver_attach+0x19/0x1b
    [<ffffffff812c362b>] bus_add_driver+0xde/0x201
    [<ffffffff812c453f>] driver_register+0x8c/0x110
    [<ffffffff812c510d>] platform_driver_register+0x41/0x43
    [<ffffffff812c5127>] platform_driver_probe+0x18/0x8a
    [<ffffffff81aff002>] efifb_init+0x276/0x295
unreferenced object 0xffff880205e90e00 (size 512):
  comm "swapper/0", pid 1, jiffies 4294895429 (age 1415.320s)
  hex dump (first 32 bytes):
    00 00 00 00 aa aa aa aa 00 00 00 00 55 55 aa aa  ............UU..
    55 55 55 55 ff ff ff ff 55 55 55 55 ff ff ff ff  UUUU....UUUU....
  backtrace:
    [<ffffffff813e415c>] kmemleak_alloc+0x21/0x3e
    [<ffffffff8111c17f>] kmemleak_alloc_recursive.constprop.57+0x16/0x18
    [<ffffffff8111e63b>] __kmalloc+0xf9/0x144
    [<ffffffff8123d9ea>] fb_alloc_cmap_gfp+0x62/0xe1
    [<ffffffff8123da77>] fb_alloc_cmap+0xe/0x10
    [<ffffffff81aff40a>] efifb_probe+0x3e9/0x48f
    [<ffffffff812c566f>] platform_drv_probe+0x34/0x5e
    [<ffffffff812c3e6d>] driver_probe_device+0x98/0x1b4
    [<ffffffff812c3fd7>] __driver_attach+0x4e/0x6f
    [<ffffffff812c25bf>] bus_for_each_dev+0x57/0x8a
    [<ffffffff812c3984>] driver_attach+0x19/0x1b
    [<ffffffff812c362b>] bus_add_driver+0xde/0x201
    [<ffffffff812c453f>] driver_register+0x8c/0x110
    [<ffffffff812c510d>] platform_driver_register+0x41/0x43
    [<ffffffff812c5127>] platform_driver_probe+0x18/0x8a
    [<ffffffff81aff002>] efifb_init+0x276/0x295
unreferenced object 0xffff880205e91e00 (size 512):
  comm "swapper/0", pid 1, jiffies 4294895429 (age 1415.320s)
  hex dump (first 32 bytes):
    00 00 aa aa 00 00 aa aa 00 00 aa aa 00 00 aa aa  ................
    55 55 ff ff 55 55 ff ff 55 55 ff ff 55 55 ff ff  UU..UU..UU..UU..
  backtrace:
    [<ffffffff813e415c>] kmemleak_alloc+0x21/0x3e
    [<ffffffff8111c17f>] kmemleak_alloc_recursive.constprop.57+0x16/0x18
    [<ffffffff8111e63b>] __kmalloc+0xf9/0x144
    [<ffffffff8123d9fe>] fb_alloc_cmap_gfp+0x76/0xe1
    [<ffffffff8123da77>] fb_alloc_cmap+0xe/0x10
    [<ffffffff81aff40a>] efifb_probe+0x3e9/0x48f
    [<ffffffff812c566f>] platform_drv_probe+0x34/0x5e
    [<ffffffff812c3e6d>] driver_probe_device+0x98/0x1b4
    [<ffffffff812c3fd7>] __driver_attach+0x4e/0x6f
    [<ffffffff812c25bf>] bus_for_each_dev+0x57/0x8a
    [<ffffffff812c3984>] driver_attach+0x19/0x1b
    [<ffffffff812c362b>] bus_add_driver+0xde/0x201
    [<ffffffff812c453f>] driver_register+0x8c/0x110
    [<ffffffff812c510d>] platform_driver_register+0x41/0x43
    [<ffffffff812c5127>] platform_driver_probe+0x18/0x8a
    [<ffffffff81aff002>] efifb_init+0x276/0x295
unreferenced object 0xffff880205e942e0 (size 32):
  comm "swapper/0", pid 1, jiffies 4294895429 (age 1415.344s)
  hex dump (first 32 bytes):
    00 01 10 00 00 00 ad de 00 02 20 00 00 00 ad de  .......... .....
    00 2c e9 05 02 88 ff ff 01 5a 5a 5a 5a 5a 5a a5  .,.......ZZZZZZ.
  backtrace:
    [<ffffffff813e415c>] kmemleak_alloc+0x21/0x3e
    [<ffffffff8111c17f>] kmemleak_alloc_recursive.constprop.57+0x16/0x18
    [<ffffffff8111e76c>] kmem_cache_alloc_trace+0xe6/0x12e
    [<ffffffff8107bb34>] pm_vt_switch_required+0x54/0x86
    [<ffffffff8123addb>] register_framebuffer+0x1e0/0x294
    [<ffffffff81aff429>] efifb_probe+0x408/0x48f
    [<ffffffff812c566f>] platform_drv_probe+0x34/0x5e
    [<ffffffff812c3e6d>] driver_probe_device+0x98/0x1b4
    [<ffffffff812c3fd7>] __driver_attach+0x4e/0x6f
    [<ffffffff812c25bf>] bus_for_each_dev+0x57/0x8a
    [<ffffffff812c3984>] driver_attach+0x19/0x1b
    [<ffffffff812c362b>] bus_add_driver+0xde/0x201
    [<ffffffff812c453f>] driver_register+0x8c/0x110
    [<ffffffff812c510d>] platform_driver_register+0x41/0x43
    [<ffffffff812c5127>] platform_driver_probe+0x18/0x8a
    [<ffffffff81aff002>] efifb_init+0x276/0x295

Feel free to ask for more info about my system;
I can also try a patch.

-- 
Alexandra N. Kossovsky
OKTET Labs (http://www.oktetlabs.ru/)
e-mail: sasha@oktetlabs.ru
