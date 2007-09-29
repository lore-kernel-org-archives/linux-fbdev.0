From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 06/17] platinumfb: Fix
	resource	management
Date: Sun, 30 Sep 2007 07:53:05 +1000
Message-ID: <1191102785.28637.2.camel@pasglop>
References: <46FDAA91.4080205@gmail.com>
	<Pine.LNX.4.64.0709291115300.10965@anakin>
Reply-To: benh@kernel.crashing.org,
	linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IbkFN-0000O6-PY for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 29 Sep 2007 14:53:14 -0700
Received: from gate.crashing.org ([63.228.1.57]
	ident=[U2FsdGVkX18Uo9pnCUJ6cBtd7/s6fq6eAAsve/9tADw=])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IbkFM-0006Xb-CT
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 29 Sep 2007 14:53:13 -0700
In-Reply-To: <Pine.LNX.4.64.0709291115300.10965@anakin>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Andrew Morton <akpm@osdl.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Andy Whitcroft <apw@uk.ibm.com>


> Probably scripts/checkpatch.pl should be taught to complain about
> `#undef DEBUG'.

Why ? Whenever I have things that are #ifdef DEBUG in the file (such as
dev_dbg statements), I always leave a #undef DEBUG statement at the top.

That way, I know I can enable debug in that file by flicking it.

Ben.



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
