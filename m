From: "Jaya Kumar" <jayakumar.lkml@gmail.com>
Subject: Re: [PATCH 1/1 2.6.24] fbdev: defio and
	Metronomefb v3
Date: Sat, 23 Feb 2008 06:05:19 -0500
Message-ID: <45a44e480802230305q20c9a1agd3cf933c58eb4a7e@mail.gmail.com>
References: <20080218134125.5159.58386.sendpatchset@nxdomain.guide.opendns.com>
	<20080223000700.dc19a7e5.akpm@linux-foundation.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JSsC5-0007jZ-UT for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 23 Feb 2008 03:05:26 -0800
Received: from wx-out-0506.google.com ([66.249.82.237])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JSsC4-0005uQ-DQ
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 23 Feb 2008 03:05:25 -0800
Received: by wx-out-0506.google.com with SMTP id h31so684139wxd.4
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sat, 23 Feb 2008 03:05:24 -0800 (PST)
In-Reply-To: <20080223000700.dc19a7e5.akpm@linux-foundation.org>
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@linux-foundation.org>
Cc: adaplas@pol.net, linux-fbdev-devel@lists.sourceforge.net, geert@linux-m68k.org

On Sat, Feb 23, 2008 at 3:07 AM, Andrew Morton
<akpm@linux-foundation.org> wrote:
> On Mon, 18 Feb 2008 08:41:26 -0500 Jaya Kumar <jayakumar.lkml@gmail.com> wrote:
> >
>  > @@ -31,7 +31,7 @@ static int fb_deferred_io_fault(struct vm_area_struct *vma,
>  >       unsigned long offset;
>  >       struct page *page;
>  >       struct fb_info *info = vma->vm_private_data;
>  > -     /* info->screen_base is in System RAM */
>  > +     /* info->screen_base is virtual memory */
>  >       void *screen_base = (void __force *) info->screen_base;
>  >
>  >       offset = vmf->pgoff << PAGE_SHIFT;
>  > @@ -43,6 +43,15 @@ static int fb_deferred_io_fault(struct vm_area_struct *vma,
>  >               return VM_FAULT_SIGBUS;
>  >
>  >       get_page(page);
>  > +
>  > +     if (vma->vm_file)
>  > +             page->mapping = vma->vm_file->f_mapping;
>  > +     else
>  > +             printk(KERN_ERR "no mapping available\n");
>  > +
>  > +     BUG_ON(!page->mapping);
>  > +     page->index = vmf->pgoff;
>  > +
>  >       vmf->page = page;
>  >       return 0;
>  >  }
>
>  What locking prevents `page' from being stripped off its mapping here?  y
>  say munmap or truncate (if it's supported here, which it presumably isn't).

Hi Andrew,

I feel I need some help in understanding the details of the above
issue. Here's what I had thought:

I set page->mapping here so that page_mkclean can find the right vma
associated with that struct page. page->mapping, and also index are
used during the deferred io callback that can occur after a write
access to the page. So I must check that munmap/mremap/truncate do not
affect page->mapping or index. At the moment, I am looking through
do_munmap's detach_vmas_to_be_unmapped(), unmap_region(),
remove_vma_list() and I think these do not cause page->mapping, index
to be affected.

The defio_cleanup below is called by the metronomefb driver's remove()
at rmmod time. I think remove() can't be called in a race with the
above callback because I believe the driver's module->ref[]count is
nonzero until the app closes().  Here's the list of scenarios I am
thinking about:

1- the driver loads, then app opens, mmaps, writes, sleeps. then
another app rmmods the driver. the driver won't rmmod because refcount
is nonzero so the prior callback from the write can still use the page
2- same but app closes and rmmod driver before the callback is
scheduled. here the defio_cleanup calls flush_scheduled_work() to make
sure the deferred work is completed before we then remove the
mappings. so I think this ok.

To help myself see the sequence:
- driver loads. vmalloc's the memory.
- X opens (/dev/fb1) , calls mmap
- vma with mapping is created
- X writes to a user virtual address
- defio fault handler vmalloc_to_page sets up user ptes. defio fault
handler sets page's mapping above and sets up deferred callback
- X calls munmap/mremap/truncate
- do_munmap modifies the app's vma and user PTEs. i think
page->mapping and page->index are untouched
- defio gets callback and mkclean()s each page so mapping must also
remain untouched. then passes pagelist to driver
- driver receives its callback and walks the passed pagelist using the
index value. as long as the index value in page was not changed by
do_munmap activity then there's no problem here.
- rmmod is called but can't proceed because refcount is nonzero
- X calls close()
- driver calls defio cleanup which cleans up the page->mapping and
then driver calls vfree.

I hope I didn't form a mistaken assumption above. I appreciate your
questions on this code.

Thanks,
jaya

>
>
>  > @@ -138,11 +147,20 @@ EXPORT_SYMBOL_GPL(fb_deferred_io_init);
>  >
>  >  void fb_deferred_io_cleanup(struct fb_info *info)
>  >  {
>  > +     void *screen_base = (void __force *) info->screen_base;
>  >       struct fb_deferred_io *fbdefio = info->fbdefio;
>  > +     struct page *page;
>  > +     int i;
>  >
>  >       BUG_ON(!fbdefio);
>  >       cancel_delayed_work(&info->deferred_work);
>  >       flush_scheduled_work();
>  > +
>  > +     /* clear out the mapping that we setup */
>  > +     for (i = 0 ; i < info->fix.smem_len; i += PAGE_SIZE) {
>  > +             page = vmalloc_to_page(screen_base + i);
>  > +             page->mapping = NULL;
>  > +     }
>  >  }
>
>  ie: a race with this function?
>
>

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
