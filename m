From: James Simmons <jsimmons@infradead.org>
Subject: Re: tdfx & multiple voodoo cards : supposed to
 work ?
Date: Wed, 29 Oct 2003 22:19:47 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0310292216410.21040-100000@phoenix.infradead.org>
References: <20031029202544.GA8953@dreamland.darkstar.lan>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AEyfP-0006a6-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 29 Oct 2003 14:19:51 -0800
Received: from [213.86.99.234] (helo=phoenix.infradead.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.24)
	id 1AEyfO-00017f-LY
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 29 Oct 2003 14:19:51 -0800
Received: from localhost.localdomain ([127.0.0.1] helo=localhost)
	by phoenix.infradead.org with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.22)
	id 1AEyfM-0006MC-7T
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 29 Oct 2003 22:19:48 +0000
In-Reply-To: <20031029202544.GA8953@dreamland.darkstar.lan>
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
To: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> > > > Is the tdfx fbdev supposed to be able to handle dual card setups, or not ?
> > > 
> > > No, the driver has a statically allocated fb_info. It will blow up.
> > 
> > Ok, thought so, i am not sure though.
> 
> BTW, looking  at 2.6 it  seems that the  driver will work  with multiple
> cards.  Static vars have been removed so this problem is solved. I'm not
> sure that the  driver itself can handle more than  one card though. Give
> it a try.

Nope. It uses the VGA core. It is possible to make the hardware boot 
indepenedent of the firmware. I haven't got around to doing this.







-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
