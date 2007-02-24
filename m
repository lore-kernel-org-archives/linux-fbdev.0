From: "Jaya Kumar" <jayakumar.lkml@gmail.com>
Subject: Re: [RFC 2.6.20 1/1] fbdev,
	mm: Deferred IO and hecubafb driver
Date: Sat, 24 Feb 2007 03:14:21 -0500
Message-ID: <45a44e480702240014p52c98667tf06626b52716b3e7@mail.gmail.com>
References: <20070223063228.GA9906@localhost> <1172299914.4109.47.camel@daplas>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HKs2x-00021w-Fm for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 24 Feb 2007 00:14:23 -0800
Received: from nf-out-0910.google.com ([64.233.182.187])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HKs2w-0002zw-MG
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 24 Feb 2007 00:14:23 -0800
Received: by nf-out-0910.google.com with SMTP id c31so2072656nfb
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sat, 24 Feb 2007 00:14:21 -0800 (PST)
In-Reply-To: <1172299914.4109.47.camel@daplas>
Content-Disposition: inline
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
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: linux-mm@kvack.org, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

On 2/24/07, Antonino A. Daplas <adaplas@gmail.com> wrote:
> On Fri, 2007-02-23 at 07:32 +0100, Jaya Kumar wrote:
> Can you create 2 separate patches, one for the deferred_io and another
> for the driver that uses it?

Will do.

> > +static struct vm_operations_struct hecubafb_vm_ops = {
> > +     .nopage         = hecubafb_vm_nopage,
> > +     .page_mkwrite   = fb_deferred_io_mkwrite,
> > +};
> > +
>
> It would seem to me that the above can be made generic, so we have this
> instead:

We could. But I think fb_deferred_io_vm_nopage would then have to
handle the different types or possible combinations of framebuffer
allocations, if they kmalloced or vmalloced or maybe combinations. Ok.
I'll try to implement that. Maybe we'll need a flag where the driver
informs us of the type of allocation.

>
> > +static struct fb_deferred_io hecubafb_defio = {
> > +     .delay          = HZ,
> > +     .deferred_io    = hecubafb_dpy_deferred_io,
> > +};
>
> Leaving the drivers to just fill up the above. This would result in a
> decrease of code duplication and it will be easier for driver writers.

I agree it'll be much cleaner that way but was worried if having
fb_defio do that would prevent driver writers from having their own
nopage and controlling other vm related functionality. Looking at
drivers/video/* shows no one touching vm_ops, so I guess we'll be
fine. If fb_defio takes ownership of the driver's nopage, vm_ops, etc,
then it could be just the above struct and the
fb_deferred_io_init/cleanup functions that are exposed to the driver.
ie: if an fbdev driver calls fb_deferred_io_init, we setup their mmap,
vm_ops and the necessary bits. I'll give that a shot.

>
> I would prefer to have the init and cleanup functions called by the
> driver themselves, instead of piggy-backing them to the
> framebuffer_register/unregister.
>

Understood. I had done it that way originally but changed just before
posting. I'll revert back. :)

> This basically dumps the entire framebuffer to the hardware, doesn't it?
> This framebuffer has only 2 pages at the most, so it doesn't matter. But
> for hardware with MB's of RAM, I don't think this is feasible.

Yup, hecuba doesn't have clean partial update functionality. But the
callback exposed to drivers is:

+       void (*deferred_io)(struct fb_info *info, struct list_head *pagelist);

which gives the drivers the list of dirty pages in pagelist. So other
drivers for hardware with the right capabilities can implement
selective or partial updates. As you mentioned, I imagine that the
drivers internally could have a bit array to enable them to mark and
find sequential partial updates. I would leave the page bitmap for
drivers to do since it would be specific to their hardware.

Thanks,
jaya

>
> Is there a way to selectively update only the touched pages, ie from the
> fbdevio->pagelist? struct page has a field (pgoff_t index), is this
> usable? If not, can we just create a bit array, just to tell the driver
> which are the dirty pages?
>
> Tony
>
>

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
