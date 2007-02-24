From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [RFC 2.6.20 1/1] fbdev,
	mm: Deferred IO	and hecubafb driver
Date: Sat, 24 Feb 2007 14:51:53 +0800
Message-ID: <1172299914.4109.47.camel@daplas>
References: <20070223063228.GA9906@localhost>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HKqik-0002eg-7x for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 23 Feb 2007 22:49:26 -0800
Received: from py-out-1112.google.com ([64.233.166.179])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HKqii-0006bB-Hi
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 23 Feb 2007 22:49:26 -0800
Received: by py-out-1112.google.com with SMTP id a29so367648pyi
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Fri, 23 Feb 2007 22:49:23 -0800 (PST)
In-Reply-To: <20070223063228.GA9906@localhost>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net, Jaya Kumar <jayakumar.lkml@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org

On Fri, 2007-02-23 at 07:32 +0100, Jaya Kumar wrote:
> Hi Tony, Paul, Peter, fbdev, lkml, and mm,
> 
> This is a first pass at abstracting deferred IO out from hecubafb and
> into fbdev as was discussed before: 
> http://marc.theaimsgroup.com/?l=linux-fbdev-devel&m=117187443327466&w=2
> 
> Please let me know your feedback and if it looks okay so far.
> 

Can you create 2 separate patches, one for the deferred_io and another
for the driver that uses it?

> +Another one may be if one has a device framebuffer that is in an usual format,
> +say diagonally shifting RGB, this may then be a mechanism for you to allow
> +apps to pretend to have a normal framebuffer but reswizzle for the device
> +framebuffer at vsync time based on the touched pagelist.

Hmm, yes, it can be used to implement a shadow framebuffer :-)

> +
> +How to use it: (for applications)
> +---------------------------------
> +No changes needed. mmap the framebuffer like normal and just use it.
> +
> +How to use it: (for fbdev drivers)
> +----------------------------------
> +The following example may be helpful.
> +
> +1. Setup your mmap and vm_ops structures. Eg:
> +
> +
> +The delay is the minimum delay between when the page_mkwrite trigger occurs
> +and when the deferred_io callback is called. The deferred_io callback is
> +explained below.
> +
> +static struct vm_operations_struct hecubafb_vm_ops = {
> +	.nopage   	= hecubafb_vm_nopage,
> +	.page_mkwrite	= fb_deferred_io_mkwrite,
> +};
> +

It would seem to me that the above can be made generic, so we have this
instead:

static struct vm_operations_struct fb_deferred_vm_ops = {
	.nopage   	= fb_deferred_io_vm_nopage,
	.page_mkwrite	= fb_deferred_io_mkwrite,
};

> +You will need a nopage routine to find and retrive the struct page for your
> +framebuffer pages. You must set page_mkwrite to fb_deferred_io_mkwrite.
> +Here's the example nopage for hecubafb where it is a vmalloced framebuffer. 
> +
> +static int hecubafb_mmap(struct fb_info *info, struct vm_area_struct *vma)
> +{
> +	vma->vm_ops = &hecubafb_vm_ops;
> +	vma->vm_flags |= ( VM_IO | VM_RESERVED | VM_DONTEXPAND );
> +	vma->vm_private_data = info;
> +	return 0;
> +}

And this too as fb_deferred_io_mmap.

> +
> +static struct page* hecubafb_vm_nopage(struct vm_area_struct *vma, 
> +					unsigned long vaddr, int *type)
> +{
> +	unsigned long offset;
> +	struct page *page;
> +	struct fb_info *info = vma->vm_private_data;
> +
> +	offset = (vaddr - vma->vm_start) + (vma->vm_pgoff << PAGE_SHIFT);
> +	if (offset >= (DPY_W*DPY_H)/8)
> +		return NOPAGE_SIGBUS;
> +

To make it generic, this can simply be:

	if (offset >= info->fix.smem_len)
		return NOPAGE_SIGBUS.

> +	page = vmalloc_to_page(info->screen_base + offset);
> +	if (!page)
> +		return NOPAGE_OOM;
> +
> +	get_page(page);
> +	if (type)
> +		*type = VM_FAULT_MINOR;
> +	return page;
> +}
> +
> 

> +static struct fb_deferred_io hecubafb_defio = {
> +	.delay		= HZ,
> +	.deferred_io	= hecubafb_dpy_deferred_io,
> +};

Leaving the drivers to just fill up the above. This would result in a
decrease of code duplication and it will be easier for driver writers.


> diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
> index 2822526..863126a 100644
> --- a/drivers/video/fbmem.c
> +++ b/drivers/video/fbmem.c
> @@ -1325,6 +1325,7 @@ register_framebuffer(struct fb_info *fb_info)
>  
>  	event.info = fb_info;
>  	fb_notifier_call_chain(FB_EVENT_FB_REGISTERED, &event);
> +	fb_deferred_io_init(fb_info);
>  	return 0;
>  }
>  
> @@ -1355,6 +1356,7 @@ unregister_framebuffer(struct fb_info *fb_info)
>  	fb_destroy_modelist(&fb_info->modelist);
>  	registered_fb[i]=NULL;
>  	num_registered_fb--;
> +	fb_deferred_io_cleanup(fb_info);
>  	fb_cleanup_device(fb_info);
>  	device_destroy(fb_class, MKDEV(FB_MAJOR, i));
>  	event.info = fb_info;

I would prefer to have the init and cleanup functions called by the
driver themselves, instead of piggy-backing them to the
framebuffer_register/unregister.


> +static void hecubafb_dpy_update(struct hecubafb_par *par)
> +{
> +	int i;
> +	unsigned char *buf = par->info->screen_base;
> +
> +	apollo_send_command(par, 0xA0);
> +
> +	for (i=0; i < (DPY_W*DPY_H/8); i++) {
> +		apollo_send_data(par, *(buf++));
> +	}
> +

This basically dumps the entire framebuffer to the hardware, doesn't it?
This framebuffer has only 2 pages at the most, so it doesn't matter. But
for hardware with MB's of RAM, I don't think this is feasible.

Is there a way to selectively update only the touched pages, ie from the
fbdevio->pagelist? struct page has a field (pgoff_t index), is this
usable? If not, can we just create a bit array, just to tell the driver
which are the dirty pages?

Tony


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
