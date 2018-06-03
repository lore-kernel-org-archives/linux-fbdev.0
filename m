From: Mikulas Patocka <mpatocka@redhat.com>
Date: Sun, 03 Jun 2018 14:40:58 +0000
Subject: [PATCH 05/21] udl-kms: fix a linked-list corruption when using fbdefio
Message-Id: <20180603144220.849008093@twibright.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180603144053.875668929@twibright.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mikulas Patocka <mpatocka@redhat.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Dave Airlie <airlied@redhat.com>, Bernie Thompson <bernie@plugable.com>, Ladislav Michl <ladis@linux-mips.org>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org

The udl driver crashes when fbdefio is used. The crash can be reproduced
with this sequence:
1. echo 1 >/sys/module/udl/parameters/fb_defio
2. run some program that maps the framebuffer, such as 'links -g' or 'fbi'
3. allocate memory to the point where the machine starts swapping

The reason for the crash is that udl_gem_get_pages calls drm_gem_get_pages
and drm_gem_get_pages allocates the pages using shmem_read_mapping_page.
The shmem pages are kept on the memory management lists using the
page->lru entry.

However, fbdefio reuses the page->lru entry for the list of pages that
were modified, so the memory management lists are corrupted and the
machine crashes when vmscan starts to scan memory.

I fixed this crash by allocating pages with "alloc_page" instead. The
pages allocated with "alloc_page" have page->lru unused, and thus the
system doesn't crash when fbdefio uses it.

Unable to handle kernel paging request at virtual address dead000000000200
Mem abort info:
  ESR = 0x96000044
  Exception class = DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
Data abort info:
  ISV = 0, ISS = 0x00000044
  CM = 0, WnR = 1
[dead000000000200] address between user and kernel address ranges
Internal error: Oops: 96000044 [#1] PREEMPT SMP
Modules linked in: ip6table_filter ip6_tables iptable_filter ip_tables x_tables af_packet autofs4 udl drm_kms_helper cfbfillrect syscopyarea cfbimgblt sysfillrect sysimgblt fb_sys_fops cfbcopyarea fb font drm drm_panel_orientation_quirks mousedev hid_generic usbhid hid binfmt_misc snd_usb_audio snd_hwdep snd_usbmidi_lib snd_rawmidi snd_pcm snd_timer snd soundcore ipv6 aes_ce_blk crypto_simd cryptd aes_ce_cipher crc32_ce ghash_ce gf128mul aes_arm64 sha2_ce sha256_arm64 sha1_ce sha1_generic xhci_plat_hcd xhci_hcd sd_mod usbcore usb_common mvpp2 unix
CPU: 0 PID: 39 Comm: kswapd0 Not tainted 4.16.12 #3
Hardware name: Marvell 8040 MACHIATOBin (DT)
pstate: 00000085 (nzcv daIf -PAN -UAO)
pc : isolate_lru_pages.isra.16+0x23c/0x2b0
lr : isolate_lru_pages.isra.16+0x104/0x2b0
sp : ffffffc13a897ac0
x29: ffffffc13a897ac0 x28: 0000000000000003
x27: 0000000000000003 x26: 0000000000000004
x25: ffffff80087e84a0 x24: ffffffc13a897b68
x23: ffffffbf04cefc60 x22: ffffffc13a897e44
x21: 0000000000000009 x20: ffffffc13a897c00
x19: ffffffc13a897b40 x18: ffffffbf04d39000
x17: 00000000fffffff8 x16: ffffffbf00000000
x15: 0000000000000006 x14: 0000000000000000
x13: 00000000000001aa x12: 400000000004001c
x11: 0000000000000001 x10: 0000000000000001
x9 : 00000000000ee3ac x8 : 00000000000004a0
x7 : ffffff80087e84a0 x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000002
x3 : ffffff80087e84a0 x2 : 0000000000000200
x1 : dead000000000200 x0 : 400000000004001c
Process kswapd0 (pid: 39, stack limit = 0x0000000097f25571)
Call trace:
 isolate_lru_pages.isra.16+0x23c/0x2b0
 shrink_inactive_list+0xe4/0x3b0
 shrink_node_memcg.constprop.19+0x374/0x630
 shrink_node+0x64/0x1c8
 kswapd+0x340/0x568
 kthread+0x118/0x120
 ret_from_fork+0x10/0x18
Code: d2804002 f85e02e0 f85e02ec f9000461 (f9000023)
---[ end trace f9f3ad3856cb2ef3 ]---
note: kswapd0[39] exited with preempt_count 1

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Cc: stable@vger.kernel.org

---
 drivers/gpu/drm/udl/udl_gem.c |   31 +++++++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)

Index: linux-4.16.12/drivers/gpu/drm/udl/udl_gem.c
=================================--- linux-4.16.12.orig/drivers/gpu/drm/udl/udl_gem.c	2018-01-10 09:31:23.000000000 +0100
+++ linux-4.16.12/drivers/gpu/drm/udl/udl_gem.c	2018-05-29 17:46:10.000000000 +0200
@@ -130,28 +130,51 @@ int udl_gem_fault(struct vm_fault *vmf)
 int udl_gem_get_pages(struct udl_gem_object *obj)
 {
 	struct page **pages;
+	int npages, i;
 
 	if (obj->pages)
 		return 0;
 
-	pages = drm_gem_get_pages(&obj->base);
-	if (IS_ERR(pages))
-		return PTR_ERR(pages);
+	npages = obj->base.size >> PAGE_SHIFT;
+
+	pages = kvmalloc_array(npages, sizeof(struct page *), GFP_KERNEL);
+	if (!pages)
+		return -ENOMEM;
+
+	for (i = 0; i < npages; i++) {
+		struct page *p = alloc_page(GFP_KERNEL | __GFP_ZERO);
+		if (!p)
+			goto fail;
+		pages[i] = p;
+	}
 
 	obj->pages = pages;
 
 	return 0;
+
+fail:
+	while (i--)
+		put_page(pages[i]);
+	kvfree(pages);
+	return -ENOMEM;
 }
 
 void udl_gem_put_pages(struct udl_gem_object *obj)
 {
+	int npages, i;
+
 	if (obj->base.import_attach) {
 		kvfree(obj->pages);
 		obj->pages = NULL;
 		return;
 	}
 
-	drm_gem_put_pages(&obj->base, obj->pages, false, false);
+	npages = obj->base.size >> PAGE_SHIFT;
+
+	for (i = 0; i < npages; i++)
+		put_page(obj->pages[i]);
+
+	kvfree(obj->pages);
 	obj->pages = NULL;
 }
 

