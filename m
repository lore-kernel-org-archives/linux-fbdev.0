From: James Simmons <jsimmons@infradead.org>
Subject: Re: [BK FBDEV] A few more updates.
Date: Tue, 25 Mar 2003 18:44:42 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0303251843121.4568-100000@phoenix.infradead.org>
References: <1048616901.10476.3.camel@zion.wanadoo.fr>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from phoenix.infradead.org ([195.224.96.167])
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 18xtQE-00068V-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 25 Mar 2003 10:45:19 -0800
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
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linus Torvalds <torvalds@transmeta.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>


> You "fixed" it by using GFP_ATOMIC but didn't test the result of
> kmalloc. That is very bad. GFP_ATOMIC can fail (return NULL), thus
> you will crash the kernel under high memory pressure.
> 
> I think the proper fix is, as you asked me, using a workqueue,
> that way, you can both use GFP_KERNEL allocations, and avoid
> the spinlock you added to fbmem.c, thus letting the fb_sync()
> ops on fbdev's be able to block.

Ug! The quick fix was a bad idea. I will work on the workqueue idea 
instead. Ignore the pull. 





-------------------------------------------------------
This SF.net email is sponsored by:
The Definitive IT and Networking Event. Be There!
NetWorld+Interop Las Vegas 2003 -- Register today!
http://ads.sourceforge.net/cgi-bin/redirect.pl?keyn0001en
