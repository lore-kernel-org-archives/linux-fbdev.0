From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] FB deffered io: keep pagelist sorted
Date: Sat, 12 Jul 2008 18:56:23 -0700
Message-ID: <20080712185623.0444478d.akpm@linux-foundation.org>
References: <1215787849-25580-1-git-send-email-jekhor@gmail.com>
	<1215788071-25764-1-git-send-email-jekhor@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KHqpG-0006yf-HX for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 12 Jul 2008 18:56:34 -0700
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KHqpG-0000O6-8H
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 12 Jul 2008 18:56:34 -0700
In-Reply-To: <1215788071-25764-1-git-send-email-jekhor@gmail.com>
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
To: Yauhen Kharuzhy <jekhor@gmail.com>
Cc: Jaya Kumar <jayakumar.lkml@gmail.com>, Ingo Molnar <mingo@redhat.com>, linux-fbdev-devel@lists.sourceforge.net

On Fri, 11 Jul 2008 17:54:30 +0300 Yauhen Kharuzhy <jekhor@gmail.com> wrote:

> eInk display drivers will do less work if list of
> changed pages will be sorted.
> 
> Apollo controller has 'Partial Update' feature ---
> updating only a part of a image, which can be done in
> small time.
> 
> Signed-off-by: Yauhen Kharuzhy <jekhor@gmail.com>
> ---
>  drivers/video/fb_defio.c |    7 ++++++-
>  1 files changed, 6 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/video/fb_defio.c b/drivers/video/fb_defio.c
> index 24843fd..5517e51 100644
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
> @@ -83,7 +84,11 @@ static int fb_deferred_io_mkwrite(struct vm_area_struct *vma,
>  
>  	/* protect against the workqueue changing the page list */
>  	mutex_lock(&fbdefio->lock);
> -	list_add(&page->lru, &fbdefio->pagelist);
> +	list_for_each_entry(cur, &fbdefio->pagelist, lru) {
> +		if (cur->index > page->index)
> +			break;
> +	}
> +	list_add(&page->lru, cur->lru.prev);
>  	mutex_unlock(&fbdefio->lock);
>  
>  	/* come back after delay to process the deferred IO */

We just merged the below:

From: Jaya Kumar <jayakumar.lkml@gmail.com>

This patch is a bugfix for how defio handles multiple processes manipulating
the same framebuffer.

Thanks to Bernard Blackham for identifying this bug.

It occurs when two applications mmap the same framebuffer and concurrently
write to the same page.  Normally, this doesn't occur since only a single
process mmaps the framebuffer.  The symptom of the bug is that the mapping
applications will hang.  The cause is that defio incorrectly tries to add the
same page twice to the pagelist.  The solution I have is to walk the pagelist
and check for a duplicate before adding.  Since I needed to walk the pagelist,
I now also keep the pagelist in sorted order.

Signed-off-by: Jaya Kumar <jayakumar.lkml@gmail.com>
Cc: Bernard Blackham <bernard@largestprime.net>
Cc: <stable@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/video/fb_defio.c |   20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff -puN drivers/video/fb_defio.c~fbdev-bugfix-for-multiprocess-defio drivers/video/fb_defio.c
--- a/drivers/video/fb_defio.c~fbdev-bugfix-for-multiprocess-defio
+++ a/drivers/video/fb_defio.c
@@ -74,6 +74,7 @@ static int fb_deferred_io_mkwrite(struct
 {
 	struct fb_info *info = vma->vm_private_data;
 	struct fb_deferred_io *fbdefio = info->fbdefio;
+	struct page *cur;
 
 	/* this is a callback we get when userspace first tries to
 	write to the page. we schedule a workqueue. that workqueue
@@ -83,7 +84,24 @@ static int fb_deferred_io_mkwrite(struct
 
 	/* protect against the workqueue changing the page list */
 	mutex_lock(&fbdefio->lock);
-	list_add(&page->lru, &fbdefio->pagelist);
+
+	/* we loop through the pagelist before adding in order
+	to keep the pagelist sorted */
+	list_for_each_entry(cur, &fbdefio->pagelist, lru) {
+		/* this check is to catch the case where a new
+		process could start writing to the same page
+		through a new pte. this new access can cause the
+		mkwrite even when the original ps's pte is marked
+		writable */
+		if (unlikely(cur == page))
+			goto page_already_added;
+		else if (cur->index > page->index)
+			break;
+	}
+
+	list_add_tail(&page->lru, &cur->lru);
+
+page_already_added:
 	mutex_unlock(&fbdefio->lock);
 
 	/* come back after delay to process the deferred IO */
_


-------------------------------------------------------------------------
Sponsored by: SourceForge.net Community Choice Awards: VOTE NOW!
Studies have shown that voting for your favorite open source project,
along with a healthy diet, reduces your potential for chronic lameness
and boredom. Vote Now at http://www.sourceforge.net/community/cca08
