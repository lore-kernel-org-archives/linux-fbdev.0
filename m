From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/1 2.6.25] fbdev: bugfix for
	multiprocess defio
Date: Wed, 30 Apr 2008 13:37:59 -0700
Message-ID: <20080430133759.e39bf34c.akpm@linux-foundation.org>
References: <20080428020140.8662.66707.sendpatchset@hit-nxdomain.opendns.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JrJ4M-0007fd-V3 for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 30 Apr 2008 13:38:27 -0700
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JrJ4L-00060S-M3
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 30 Apr 2008 13:38:26 -0700
In-Reply-To: <20080428020140.8662.66707.sendpatchset@hit-nxdomain.opendns.com>
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
Cc: jayakumar.lkml@gmail.com, bernard@largestprime.net, linux-fbdev-devel@lists.sourceforge.net

On Sun, 27 Apr 2008 22:01:40 -0400
Jaya Kumar <jayakumar.lkml@gmail.com> wrote:

> Hi Tony, Geert, Andrew, fbdev,
> 
> This patch is a bugfix for how defio handles multiple processes manipulating
> the same framebuffer. Thanks to Bernard Blackham for identifying this bug.
> It occurs when two applications mmap the same framebuffer and concurrently
> write to the same page. Normally, this doesn't occur since only a single
> process mmaps the framebuffer. The symptom of the bug is that the mapping
> applications will hang. The cause is that defio incorrectly tries to add the
> same page twice to the pagelist. The solution I have is to walk the pagelist
> and check for a duplicate before adding. Since I needed to walk the
> pagelist, I now also keep the pagelist in sorted order.
> 
> Thanks,
> jaya
> 
> Signed-off-by: Jaya Kumar <jayakumar.lkml@gmail.com>
> 
> diff --git a/drivers/video/fb_defio.c b/drivers/video/fb_defio.c
> index 24843fd..59df132 100644
> --- a/drivers/video/fb_defio.c
> +++ b/drivers/video/fb_defio.c
> @@ -74,6 +74,7 @@ static int fb_deferred_io_mkwrite(struct vm_area_struct *vma,
>  {
>  	struct fb_info *info = vma->vm_private_data;
>  	struct fb_deferred_io *fbdefio = info->fbdefio;
> +	struct page *cur;
>  
>  	/* this is a callback we get when userspace first tries to
>  	write to the page. we schedule a workqueue. that workqueue
> @@ -83,7 +84,24 @@ static int fb_deferred_io_mkwrite(struct vm_area_struct *vma,
>  
>  	/* protect against the workqueue changing the page list */
>  	mutex_lock(&fbdefio->lock);
> -	list_add(&page->lru, &fbdefio->pagelist);
> +
> +	/* we loop through the pagelist before adding in order
> +	to keep the pagelist sorted */
> +	list_for_each_entry(cur, &fbdefio->pagelist, lru) {
> +		/* this check is to catch the case where a new
> +		process could start writing to the same page
> +		through a new pte. this new access can cause the
> +		mkwrite even when the original ps's pte is marked
> +		writable */
> +		if (unlikely(cur == page))
> +			goto page_already_added;
> +		else if (cur->index > page->index)
> +			break;
> +	}
> +
> +	list_add_tail(&page->lru, &cur->lru);
> +
> +page_already_added:
>  	mutex_unlock(&fbdefio->lock);
>  

Did you consider using !list_empty(&page->lru) to avoid the linear search?

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
