From: Nicolas Souchu <nsouch@free.fr>
Subject: Re: Redesign of kernel graphics interface
Date: Tue, 11 May 2004 22:57:11 +0000
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040511225711.A7384@armor.freesurf.fr>
References: <Pine.LNX.4.44.0405101708310.4338-100000@phoenix.infradead.org> <20040510182940.14049.qmail@web14924.mail.yahoo.com> <20040510223950.B2268@armor.freesurf.fr> <20040510204742.GA12863@guug.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BNe7P-0007qi-0v
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 11 May 2004 13:44:51 -0700
Received: from fidel.freesurf.fr ([212.43.206.16])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BNe7O-0005wn-My
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 11 May 2004 13:44:50 -0700
Received: from smtp.freesurf.fr (62-240-249-21.adsl.freesurf.fr [62.240.249.21])
	by fidel.freesurf.fr (Postfix) with SMTP id 136D32A5F6D
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 11 May 2004 22:44:41 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20040510204742.GA12863@guug.org>; from solca@guug.org on Mon, May 10, 2004 at 02:47:42PM -0600
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
To: Otto Solares <solca@guug.org>
Cc: Jon Smirl <jonsmirl@yahoo.com>, James Simmons <jsimmons@infradead.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, fb-devel <linux-fbdev-devel@lists.sourceforge.net>

On Mon, May 10, 2004 at 02:47:42PM -0600, Otto Solares wrote:
> On Mon, May 10, 2004 at 10:39:50PM +0000, Nicolas Souchu wrote:
> > Do apps manage their swap? No. I think the OS should be responsible for
> > placing the data (vertices, textures, commands) at the right/best place
> > for the HW 3D engine and the client should only fill virtual memory.
> 
> > http://www.freebsd.org/~nsouch/kgi4BSD
> 
> Browsing through kgi.sf.net I found that they have proper multihead
> and DDC2 support.

True.

> They just lack DRI integrated into KGI and it will
> rock from my user perspective.

It's not DRI but GGI+KGI accel resource management. Mesa can work
with GGI backend (the code has to be refreshed though).

> Is true that the BSDs are adopting KGI as their unified kernel
> graphics layer?

It's a project, yes.

-- 
Nicholas Souchu - nsouch@free.fr - nsouch@FreeBSD.org
http://www.freebsd.org/~nsouch/kgi4BSD


-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to 
deliver higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
