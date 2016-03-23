From: =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Date: Wed, 23 Mar 2016 15:25:42 +0000
Subject: Problems using fb_deferred_io with drm_fb_cma_helper
Message-Id: <56F2B576.5080508@tronnes.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

I'm trying to add deferred io support to=20
drivers/gpu/drm/drm_gem_cma_helper.c.
This is a fbdev helper for DRM.

The first problem is that fb_deferred_io_page() requires either a vmalloc
address or a physical address:

         if (is_vmalloc_addr(screen_base + offs))
                 page =3D vmalloc_to_page(screen_base + offs);
         else
                 page =3D pfn_to_page((info->fix.smem_start + offs) >>=20
PAGE_SHIFT);

However drm_fb_cma_helper allocates memory this way:

         cma_obj->vaddr =3D dma_alloc_writecombine(drm->dev, size,
                         &cma_obj->paddr, GFP_KERNEL | __GFP_NOWARN);

The name paddr is somewhat misleading here since this is the device address
which isn't always the same as the physical address (Raspberry Pi). Is
there a way to turn the virtual address into a physical one which will work
on all architectures?

I use __va() now, but that is marked as not for use by drivers in
arch/arm/include/asm/memory.h (the same goes for virt_to_phys).

Maybe this is valid for all? page_to_phys(virt_to_page(x))

I have looked at all the users of fb_deferred_io_init() and found only
3 drivers that doesn't use a vmalloc screen buffer:

drivers/gpu/drm/udl/udl_fb.c:
     obj->vmapping =3D vmap(obj->pages, page_count, 0, PAGE_KERNEL);
         info->screen_base =3D ufbdev->ufb.obj->vmapping;
         info->fix.smem_start =3D (unsigned long)ufbdev->ufb.obj->vmapping;
Since it uses vmap() I guess it is_vmalloc_addr().

drivers/video/fbdev/sh_mobile_lcdcfb.c:
         ch->fb_mem =3D dma_alloc_coherent(dev, ch->fb_size, &ch->dma_handl=
e,
                                         GFP_KERNEL);
         info->screen_base =3D ch->fb_mem;
         info->fix.smem_start =3D ch->dma_handle;
It uses dma_mmap_coherent() in it's fb_mmap function, but nothing special
with it's deferred_io use.

drivers/video/fbdev/ssd1307fb.c:
         vmem =3D (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO,
                                         get_order(vmem_size));
         info->screen_base =3D (u8 __force __iomem *)vmem;
         info->fix.smem_start =3D __pa(vmem);

So maybe this could be possible:

  static struct page *fb_deferred_io_page(struct fb_info *info, unsigned=20
long offs)
  {
      void *screen_base =3D (void __force *) info->screen_base;
      struct page *page;

      if (is_vmalloc_addr(screen_base + offs))
          page =3D vmalloc_to_page(screen_base + offs);
      else
-        page =3D pfn_to_page((info->fix.smem_start + offs) >> PAGE_SHIFT);
+        page =3D virt_to_page(screen_base + offs);

      return page;
  }


The second problem I'm facing is that I get short horizontal lines that have
old pixels. My problem goes away if I add this to fb_deferred_io_mmap():

         vma->vm_page_prot =3D pgprot_writecombine(vma->vm_page_prot);

Is there a way to add this to fb_deferred_io_mmap() with some kind of if
statement, or perhaps export the function so I can use it like this:

static int drm_fbdev_cma_defio_mmap(struct fb_info *info,
                                     struct vm_area_struct *vma)
{
         fb_deferred_io_mmap(info, vma);
         vma->vm_page_prot =3D pgprot_writecombine(vma->vm_page_prot);

         return 0;
}


Thanks,
Noralf Tr=C3=B8nnes

