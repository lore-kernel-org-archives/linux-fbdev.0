From: Matthew Wilcox <willy@infradead.org>
Date: Sat, 14 Apr 2018 19:35:06 +0000
Subject: Re: [PATCH] video: fbdev: core: Change return type to vm_fault_t
Message-Id: <20180414193506.GA31523@bombadil.infradead.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org


I don't think we need to bother Andrew with this.  I found a newer email
address for Jaya; let's try that, and the linux-fbdev mailing list.

On Sun, Apr 15, 2018 at 12:40:14AM +0530, Souptick Joarder wrote:
> Mail-Id of Maintainer doesn't in invalid. Shall i send this patch to Andrew ?
> 
> On Sun, Apr 15, 2018 at 12:40 AM, Souptick Joarder <jrdr.linux@gmail.com> wrote:
> > Use new return type vm_fault_t for fault handler
> > and page_mkwrite handler.
> >
> > Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> > Reviewed-by: Matthew Wilcox <mawilcox@microsoft.com>
> > ---
> >  drivers/video/fbdev/core/fb_defio.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/video/fbdev/core/fb_defio.c b/drivers/video/fbdev/core/fb_defio.c
> > index 487d5e3..82c20c6 100644
> > --- a/drivers/video/fbdev/core/fb_defio.c
> > +++ b/drivers/video/fbdev/core/fb_defio.c
> > @@ -37,7 +37,7 @@ static struct page *fb_deferred_io_page(struct fb_info *info, unsigned long offs
> >  }
> >
> >  /* this is to find and return the vmalloc-ed fb pages */
> > -static int fb_deferred_io_fault(struct vm_fault *vmf)
> > +static vm_fault_t fb_deferred_io_fault(struct vm_fault *vmf)
> >  {
> >         unsigned long offset;
> >         struct page *page;
> > @@ -90,7 +90,7 @@ int fb_deferred_io_fsync(struct file *file, loff_t start, loff_t end, int datasy
> >  EXPORT_SYMBOL_GPL(fb_deferred_io_fsync);
> >
> >  /* vm_ops->page_mkwrite handler */
> > -static int fb_deferred_io_mkwrite(struct vm_fault *vmf)
> > +static vm_fault_t fb_deferred_io_mkwrite(struct vm_fault *vmf)
> >  {
> >         struct page *page = vmf->page;
> >         struct fb_info *info = vmf->vma->vm_private_data;
> > --
> > 1.9.1
> >
