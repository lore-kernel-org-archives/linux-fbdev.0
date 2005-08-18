From: James Simmons <jsimmons@infradead.org>
Subject: Re: [PATCH] geode updates.
Date: Thu, 18 Aug 2005 21:00:47 +0100 (BST)
Message-ID: <Pine.LNX.4.56.0508182059520.16078@pentafluge.infradead.org>
References: <Pine.LNX.4.56.0508120103420.13219@pentafluge.infradead.org>
 <43032919.8090100@arcom.com> <Pine.LNX.4.56.0508171732370.18287@pentafluge.infradead.org>
 <20050817190259.65f220f5.akpm@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E5qZl-00016c-BP
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 18 Aug 2005 13:01:21 -0700
Received: from pentafluge.infradead.org ([213.146.154.40])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1E5qZH-0006uT-UN
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 18 Aug 2005 13:01:21 -0700
In-Reply-To: <20050817190259.65f220f5.akpm@osdl.org>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@osdl.org>
Cc: linux-fbdev-devel@lists.sourceforge.net, dvrabel@arcom.com, adaplas@hotpop.com, geert@linux-m68k.org


Yes. David authored the patch. I will signed off on it. 

On Wed, 17 Aug 2005, Andrew Morton wrote:

> James Simmons <jsimmons@infradead.org> wrote:
> >
> > Geode framebuffer driver updates:
> >    - Local mode list (taken from modedb.c) containing only relevant modes. This
> >      also makes the driver work as a module.
> >    - Make it a PCI driver (from James Simmons <jsimmons@infradead.org>).
> >    - A few other minor cosmetic bits and pieces.
> > 
> >  Signed-off-by: David Vrabel <dvrabel@arcom.com>
> 
> I've assumed that David authored this patch and that you wanted to do a
> signed-off-by on it.   Please let me know if that's inappropriate.
> 
> And please try to get this stuff right..
> 


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
