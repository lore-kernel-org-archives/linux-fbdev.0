From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 8/8] fbdev: Fix broken fb_blank() implementation.
Date: Mon, 08 Nov 2004 10:52:50 +1100
Message-ID: <1099871570.3884.138.camel@gaston>
References: <200411080526.50550.adaplas@hotpop.com>
	 <1099863581.10262.134.camel@gaston> <200411080723.39722.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CQwrS-0004jb-6E
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 07 Nov 2004 15:54:18 -0800
Received: from gate.crashing.org ([63.228.1.57])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1CQwrR-0000ue-Nk
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 07 Nov 2004 15:54:18 -0800
In-Reply-To: <200411080723.39722.adaplas@hotpop.com>
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
To: adaplas@pol.net
Cc: Andrew Morton <akpm@osdl.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Mon, 2004-11-08 at 07:23 +0800, Antonino A. Daplas wrote:

> I'm not too sure about this, but I think so, it is world callable and is
> called by bust_spinlocks() at least. What about putting fbcon_blank() in the
> workqueue...? (Or perhaps unblank/blank_screen in vt.c, but the code
> in vt.c is very fragile...)

Yah. I already fixed a bunch of vt.c so nowadays, at least, we do
everything with the console sem. held, so the driver doesn't have to
care about re-entrancy, though we still can be called at irq context.

A workqueue may not be a good idea. I don't like workqueue abuse, and
sleeping > 200ms there means that whatever other driver using workqueues
will suddenly have _huge_ latencies, it's not good.

I suppose I'll stick with my timer ...

Ben.




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
