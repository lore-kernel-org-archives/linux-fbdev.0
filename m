From: Otto Solares <solca@guug.org>
Subject: Re: Redesign of kernel graphics interface
Date: Tue, 11 May 2004 15:17:56 -0600
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040511211756.GC14431@guug.org>
References: <Pine.LNX.4.44.0405101708310.4338-100000@phoenix.infradead.org> <20040510182940.14049.qmail@web14924.mail.yahoo.com> <20040510223950.B2268@armor.freesurf.fr> <20040510204742.GA12863@guug.org> <20040511225711.A7384@armor.freesurf.fr>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BNecp-0006Uy-3X
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 11 May 2004 14:17:19 -0700
Received: from guug.galileo.edu ([168.234.203.30] helo=guug.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1BNeco-0001NQ-Pb
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 11 May 2004 14:17:18 -0700
Content-Disposition: inline
In-Reply-To: <20040511225711.A7384@armor.freesurf.fr>
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
Content-Transfer-Encoding: 7bit
To: Nicolas Souchu <nsouch@free.fr>
Cc: Jon Smirl <jonsmirl@yahoo.com>, James Simmons <jsimmons@infradead.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, fb-devel <linux-fbdev-devel@lists.sourceforge.net>

On Tue, May 11, 2004 at 10:57:11PM +0000, Nicolas Souchu wrote:
> On Mon, May 10, 2004 at 02:47:42PM -0600, Otto Solares wrote:
> 
> > They just lack DRI integrated into KGI and it will
> > rock from my user perspective.
> 
> It's not DRI but GGI+KGI accel resource management. Mesa can work
> with GGI backend (the code has to be refreshed though).

Mesa's GGI backend was software only last time I check, I mean
hardware acceleration into mesa via KGI+DRI would be nice,
something like linux-solo but instead of the fbdev using the
KGI layer.

-otto



-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to 
deliver higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
