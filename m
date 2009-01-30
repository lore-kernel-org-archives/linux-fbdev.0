From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [RFC 2.6.28 1/1] fbdev: defio pagelist to
	pagemap
Date: Fri, 30 Jan 2009 20:07:59 +0900
Message-ID: <aec7e5c30901300307i4d1eeb7cmcf83bef39e14b855@mail.gmail.com>
References: <12329361431140-git-send-email-jayakumar.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <magnus.damm@gmail.com>) id 1LSrED-0007MH-Dy
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 30 Jan 2009 11:08:05 +0000
Received: from fk-out-0910.google.com ([209.85.128.189])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1LSrEA-0000XN-1G for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 30 Jan 2009 11:08:05 +0000
Received: by fk-out-0910.google.com with SMTP id 19so406192fkr.10
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Fri, 30 Jan 2009 03:07:59 -0800 (PST)
In-Reply-To: <12329361431140-git-send-email-jayakumar.lkml@gmail.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Jaya Kumar <jayakumar.lkml@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, adaplas@gmail.com, armbru@redhat.com, lethal@linux-sh.org, Geert Uytterhoeven <geert@linux-m68k.org>

On Mon, Jan 26, 2009 at 11:15 AM, Jaya Kumar <jayakumar.lkml@gmail.com> wrote:
> Hi Magnus, fbdev friends,
>
> As discussed previously, this is version 2 of converting pagelist use
> in defio over to pagemap. Thanks to Magnus for ideas and discussion.
> The primary change is the use of bitmap ops rather than manual setting
> of bits. If everyone is okay with the idea, then we will also need to
> convert xen-pvfb, sh and any other drivers using defio. Let me know
> your thoughts.

I hope the sh changes will be trivial. Any change that you can include
it in your patch?

> The defio implementation was using a list structure in order to
> track which pages had been written to. Basically, that was a poor
> choice and this had been correctly raised as an issue by Tony
> a while back and Magnus more recently. This patch is an attempt to
> rectify the issue. These changes aren't tested yet, just compiles.

Hm, what are the requirements for this patch? It doesn't apply to
2.6.28 or latest git.

> @@ -82,37 +82,14 @@ int fb_deferred_io_fsync(struct file *file, struct dentry *dentry, int datasync)
>  EXPORT_SYMBOL_GPL(fb_deferred_io_fsync);
>
>  /*
> - * Adds page to list of dirty pages, keeps it in sorted order and handles
> - * checking for duplicates.
> + * Set page to mark it dirty in our pagemap
>  */
> -static void fb_defio_pagelist_add(struct fb_deferred_io *fbdefio,
> +static void fb_defio_set_pagemap(struct fb_deferred_io *fbdefio,
>                                        struct page *page)
>  {
> -       struct page *cur;
> -       /* protect against the workqueue changing the page list */
> +       /* protect against the workqueue changing the pagemap */
>        mutex_lock(&fbdefio->lock);

I don't think the mutex is needed since you now are using atomic bitops.

Can you please post up-port your patch to a more recent kernel? I'll
have a look at your code again late next week.

Cheers,

/ magnus

------------------------------------------------------------------------------
This SF.net email is sponsored by:
SourcForge Community
SourceForge wants to tell your story.
http://p.sf.net/sfu/sf-spreadtheword
