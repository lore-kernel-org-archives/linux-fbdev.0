From: Otto Solares <solca@guug.org>
Subject: Re: ioremap problem on highmem
Date: Thu, 16 Oct 2003 10:56:54 -0600
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20031016165654.GA19795@guug.org>
References: <Pine.LNX.4.44.0310160008440.13660-100000@phoenix.infradead.org> <1066299353.1509.132.camel@gaston>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AABSN-00047P-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 16 Oct 2003 09:58:35 -0700
Received: from guug.galileo.edu ([168.234.203.30])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 1AABSM-0002Bp-IB
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 16 Oct 2003 09:58:34 -0700
Content-Disposition: inline
In-Reply-To: <1066299353.1509.132.camel@gaston>
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
Content-Transfer-Encoding: 7bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: James Simmons <jsimmons@infradead.org>, Jon Smirl <jonsmirl@yahoo.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Thu, Oct 16, 2003 at 12:15:53PM +0200, Benjamin Herrenschmidt wrote:
> On Thu, 2003-10-16 at 01:11, James Simmons wrote:
> 
> > Its is the userland responability to restore the console state after 
> > leaving KDGRAPHICS mode. You need to save the hardware state before you 
> > leave KDTEXT mode as well. 
> 
> That's a bit nasty as I just wrote, and very unpractical. Especially
> since it's really a _LOT_ simpler for the fbdev to just restore its
> state when going back to KDTEXT.

Agree.  fbcon should save it's state before leaving KDTEXT or
reinitialize when leaving KDGRAPHICS.

-solca



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
