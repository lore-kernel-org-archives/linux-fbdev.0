From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [BK FBDEV] A few more updates.
Date: 25 Mar 2003 19:35:54 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1048617354.10476.6.camel@zion.wanadoo.fr>
References: <Pine.LNX.4.33.0303251031180.4272-100000@maxwell.earthlink.net>
	 <1048616901.10476.3.camel@zion.wanadoo.fr>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from amarseille-201-1-1-200.abo.wanadoo.fr ([193.252.38.200] helo=zion.wanadoo.fr)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18xtHc-0001OO-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 25 Mar 2003 10:36:24 -0800
In-Reply-To: <1048616901.10476.3.camel@zion.wanadoo.fr>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: James Simmons <jsimmons@infradead.org>
Cc: Linus Torvalds <torvalds@transmeta.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Tue, 2003-03-25 at 19:28, Benjamin Herrenschmidt wrote:

> You "fixed" it by using GFP_ATOMIC but didn't test the result of
> kmalloc. That is very bad. GFP_ATOMIC can fail (return NULL), thus
> you will crash the kernel under high memory pressure.
> 
> I think the proper fix is, as you asked me, using a workqueue,
> that way, you can both use GFP_KERNEL allocations, and avoid
> the spinlock you added to fbmem.c, thus letting the fb_sync()
> ops on fbdev's be able to block.

Well, actually, creating a workqueue would be overhead since
it involves one kernel thread per CPU. After more thinking &
discussion, I beleive you shall rather use keventd existing
workqueue (schedule_work() will do that)

Ben.



-------------------------------------------------------
This SF.net email is sponsored by:
The Definitive IT and Networking Event. Be There!
NetWorld+Interop Las Vegas 2003 -- Register today!
http://ads.sourceforge.net/cgi-bin/redirect.pl?keyn0001en
