From: James Simmons <jsimmons@infradead.org>
Subject: Re: Re: mode setting and console locking, nvidia
 failure
Date: Mon, 17 May 2004 23:56:14 +0100 (BST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0405172351550.796-100000@phoenix.infradead.org>
References: <20040517050315.90926.qmail@web14926.mail.yahoo.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BPr1v-0006sK-GC
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 17 May 2004 15:56:19 -0700
Received: from phoenix.infradead.org ([213.86.99.234])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1BPr1v-0004Dg-32
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 17 May 2004 15:56:19 -0700
In-Reply-To: <20040517050315.90926.qmail@web14926.mail.yahoo.com>
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
To: Jon Smirl <jonsmirl@yahoo.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, fb-devel <linux-fbdev-devel@lists.sourceforge.net>


> There is nothing wrong with fbset on rivafb. It's the same problem I'm having
> with radeonfb. Swaping between text->gfx on the primary monitor mess up the chip
> registers of the secondary card. In this case the PLL reads zero after the VT
> swap and that causes the divide by zero.
> 
> This has got to be some problem in fb since I am sure my X does not have an
> Nvidia driver loaded.

Jon are you using a vanilla 2.6.6 kernel. If you are could you try this 
patch.

http://phoenix.infradead.org/~jsimmons/mode.diff

It might solve your problem. It might be a cons2fb mapping issue.





-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
