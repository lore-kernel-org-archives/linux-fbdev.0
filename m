From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [BK FBDEV] A few more updates.
Date: 25 Mar 2003 21:10:26 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1048623026.10476.17.camel@zion.wanadoo.fr>
References: <Pine.LNX.4.44.0303251947020.6228-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from amarseille-201-1-1-200.abo.wanadoo.fr ([193.252.38.200] helo=zion.wanadoo.fr)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18xuks-0007wH-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 25 Mar 2003 12:10:43 -0800
In-Reply-To: <Pine.LNX.4.44.0303251947020.6228-100000@phoenix.infradead.org>
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Tue, 2003-03-25 at 20:48, James Simmons wrote:

> > Well, actually, creating a workqueue would be overhead since
> > it involves one kernel thread per CPU. After more thinking &
> > discussion, I beleive you shall rather use keventd existing
> > workqueue (schedule_work() will do that)
> 
> Done. Can you look over this patch and test it. I tested it and it worked 
> fine.

I don't have a test config at hand right now. The patch looks better,
though you didn't remove the spinlock and replace it with some
"softer" sync. primitives.

Note that if fbcon is ever to be rmmod'ed, you need to properly
remove the timer and make sure all pending work queues have completed
(and make sure the timer won't be re-scheduled by one).

Ben.



-------------------------------------------------------
This SF.net email is sponsored by:
The Definitive IT and Networking Event. Be There!
NetWorld+Interop Las Vegas 2003 -- Register today!
http://ads.sourceforge.net/cgi-bin/redirect.pl?keyn0001en
