From: James Simmons <jsimmons@infradead.org>
Subject: Re: ioremap problem on highmem
Date: Fri, 17 Oct 2003 17:58:52 +0100 (BST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0310171756560.966-100000@phoenix.infradead.org>
References: <20031016165654.GA19795@guug.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AAXwJ-0003c0-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 17 Oct 2003 09:58:59 -0700
Received: from [213.86.99.234] (helo=phoenix.infradead.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.22)
	id 1AAXwH-0005tw-Rh
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 17 Oct 2003 09:58:58 -0700
In-Reply-To: <20031016165654.GA19795@guug.org>
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
To: Otto Solares <solca@guug.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Jon Smirl <jonsmirl@yahoo.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> > > Its is the userland responability to restore the console state after 
> > > leaving KDGRAPHICS mode. You need to save the hardware state before you 
> > > leave KDTEXT mode as well. 
> > 
> > That's a bit nasty as I just wrote, and very unpractical. Especially
> > since it's really a _LOT_ simpler for the fbdev to just restore its
> > state when going back to KDTEXT.
> 
> Agree.  fbcon should save it's state before leaving KDTEXT or
> reinitialize when leaving KDGRAPHICS.

I agree. The way the console system does it now is just broken. Even VGA 
console should save and restore its state. It wouldn't be a huge leap to 
do that either since we have code to change the screen resolution when we 
use different font sizes. The pieces are there, it just a matter of 
putting them together. Of course this is a 2.7.X issue.




-------------------------------------------------------
This SF.net email sponsored by: Enterprise Linux Forum Conference & Expo
The Event For Linux Datacenter Solutions & Strategies in The Enterprise 
Linux in the Boardroom; in the Front Office; & in the Server Room 
http://www.enterpriselinuxforum.com
