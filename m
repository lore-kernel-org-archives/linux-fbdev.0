From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Patch for review and testing
Date: Wed, 28 Jan 2004 12:05:36 +1100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1075251935.6296.243.camel@gaston>
References: <Pine.LNX.4.44.0401272255180.19265-100000@phoenix.infradead.org>
	 <1075251694.30622.240.camel@gaston>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AleCW-0003XN-JM
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 27 Jan 2004 17:09:04 -0800
Received: from gate.crashing.org ([63.228.1.57] ident=root)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30)
	id 1AleCW-0002gW-74
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 27 Jan 2004 17:09:04 -0800
In-Reply-To: <1075251694.30622.240.camel@gaston>
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
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Andrew Morton <akpm@osdl.org>

On Wed, 2004-01-28 at 12:01, Benjamin Herrenschmidt wrote:
> > Yes. The code is run in real mode before linux is started. 
> 
> Ok, I've chatted with some x86 folks, it should still be
> possible to check the commandline (cmd_line_ptr defined
> in setup.S).

Actually, I discussed with Andi and he doesn't like the cmdline
neither...

He says that with an exception handler and an interrupt hooked
on the 8253 you can catch the crash and do a timeout :) Also,
we cna just blacklist those BIOSes... or find out how windows
calls this call and do the same (that would work :)

Ben




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
