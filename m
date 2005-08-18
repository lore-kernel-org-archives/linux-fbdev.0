From: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] geode updates.
Date: Wed, 17 Aug 2005 19:02:59 -0700
Message-ID: <20050817190259.65f220f5.akpm@osdl.org>
References: <Pine.LNX.4.56.0508120103420.13219@pentafluge.infradead.org>
	<43032919.8090100@arcom.com>
	<Pine.LNX.4.56.0508171732370.18287@pentafluge.infradead.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E5pHv-0001Dc-00
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 18 Aug 2005 11:38:51 -0700
Received: from externalmx-1.sourceforge.net ([12.152.184.25])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1E5pB1-0004Ww-QI
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 18 Aug 2005 11:32:23 -0700
Received: from smtp.osdl.org ([65.172.181.4])
	by externalmx-1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1E5ZoA-0007ey-SD
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 17 Aug 2005 19:07:09 -0700
In-Reply-To: <Pine.LNX.4.56.0508171732370.18287@pentafluge.infradead.org>
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
Content-Type: text/plain; charset="us-ascii"
To: James Simmons <jsimmons@infradead.org>
Cc: linux-fbdev-devel@lists.sourceforge.net, dvrabel@arcom.com, adaplas@hotpop.com, geert@linux-m68k.org

James Simmons <jsimmons@infradead.org> wrote:
>
> Geode framebuffer driver updates:
>    - Local mode list (taken from modedb.c) containing only relevant modes. This
>      also makes the driver work as a module.
>    - Make it a PCI driver (from James Simmons <jsimmons@infradead.org>).
>    - A few other minor cosmetic bits and pieces.
> 
>  Signed-off-by: David Vrabel <dvrabel@arcom.com>

I've assumed that David authored this patch and that you wanted to do a
signed-off-by on it.   Please let me know if that's inappropriate.

And please try to get this stuff right..


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
