From: Kronos <kronos@kronoz.cjb.net>
Subject: Re: [RADEONFB] Cursor gone
Date: Wed, 9 Jul 2003 18:56:05 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030709165605.GA1881@dreamland.darkstar.lan>
References: <20030703155449.GA5399@dreamland.darkstar.lan> <Pine.LNX.4.44.0307090017130.32323-100000@phoenix.infradead.org>
Reply-To: kronos@kronoz.cjb.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail-2.tiscali.it ([195.130.225.148])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19aIFs-0000S4-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 09 Jul 2003 09:57:20 -0700
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0307090017130.32323-100000@phoenix.infradead.org>
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
To: James Simmons <jsimmons@infradead.org>
Cc: linux-fbdev-devel@lists.sourceforge.net

Il Wed, Jul 09, 2003 at 12:17:51AM +0100, James Simmons ha scritto: 
> > sometimes  when I  switch to  console from  X I  loose the  cursors. The
> > problem seems to be random (it doesn't appear if I don't start X though)
> > and I'm unable  to find a pattern to reproduce  it. I'm using 2.5.73 now
> > but I first  saw this bug in 2.5.70 (hadn't  tried previous kernel, I'll
> > check asap).
> > 
> Strange. DO you get this effect my latest patch.
> 
> http://phoenix.infradead.org/~jsimmons/fbdev.diff.gz


This is the patch that you announced on July  3rd, isn't it?
I see  the problem with  2.5.74 +  the patch posted  on July 3rd  but it
doesn't happen as often as with plain 2.5.74. Usualy switching back to X
and then to the console fixes the problem.

Luca
-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
Tentare e` il primo passo verso il fallimento.
Homer J. Simpson


-------------------------------------------------------
This SF.Net email sponsored by: Parasoft
Error proof Web apps, automate testing & more.
Download & eval WebKing and get a free book.
www.parasoft.com/bulletproofapps
