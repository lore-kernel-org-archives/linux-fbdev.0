From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: Re: [PATCH 4/5][RFC] fbdev: Clean up framebuffer  initialization
Date: Sat, 4 Sep 2004 20:37:16 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200409042037.16923.adaplas@hotpop.com>
References: <200409041108.40276.adaplas@hotpop.com> <200409041453.01644.adaplas@hotpop.com> <413972D0.EAC13CC4@orpatec.ch>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C3Zna-000458-1f
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 04 Sep 2004 05:37:42 -0700
Received: from smtp-out.hotpop.com ([38.113.3.71])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1C3ZnW-0000WX-5x
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 04 Sep 2004 05:37:39 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id EB2D710C3F49
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat,  4 Sep 2004 12:37:31 +0000 (UTC)
In-Reply-To: <413972D0.EAC13CC4@orpatec.ch>
Content-Disposition: inline
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: linux-fbdev-devel@lists.sourceforge.net, Otto Wyss <otto.wyss@orpatec.ch>

On Saturday 04 September 2004 15:46, Otto Wyss wrote:
> "Antonino A. Daplas" wrote:
> > Mainly cleanup, but also point #5.  The i810fb, for instance, depends on
> > agpgart, but agpgart gets initialized way after fbdev.  The workaround is
> > for i810fb to explicitly call intel_agp_init().  Besides the ugliness,
> > forcibly initializing the agpgart subsystem out of sequence may cause
> > problems.
>
> Sorry if I interrupt without deeper knowledge but doesn't this sound
> very strange?

Yes, it was confusing the first time I noticed this.

> Why is a subsystem initialized much later than the one
> which depends on it? Doesn't this look like a design error?
>

I don't know about the design error part, but this is due to explicit
initialization.

The framebuffer system gets initialized quite early in the boot process.
This is because fbmem_init() is called by drivers/char/mem.c:chr_dev_init(),
then each of the fbdev's xxxfb_init(), in turn, are called by fbmem_init().
If you look at drivers/char/Makefile, you'll see that mem.o is the very
first in the list, while agp is one of the last. For i810fb, it will always
get initialized first before agp, and it doesn't have any choice on the
matter.

Anyway, if you look at drivers/char/agp/intel-agp.c, you'll see this
comment:

/* intel_agp_init() must not be declared static for explicit
   early initialization to work (ie i810fb) */

In theory, with the patch, the above hack will not be needed. The explicit
initializations of fbmem, fbcon, and xxxfb are removed.  Each will have
their own module_init(), meaning their initialization order will now depend
on their link order (basically Makefile order). I can then choose to move
i810fb to load after agp.

Tony




-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
