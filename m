From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 06/17] platinumfb: Fix
	resource	management
Date: Sun, 30 Sep 2007 18:03:39 +1000
Message-ID: <1191139419.6310.0.camel@pasglop>
References: <46FDAA91.4080205@gmail.com>
	<Pine.LNX.4.64.0709291115300.10965@anakin>
	<1191102785.28637.2.camel@pasglop>
	<Pine.LNX.4.64.0709300910570.10965@anakin>
Reply-To: benh@kernel.crashing.org,
	linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IbtmD-0006uC-TO for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 30 Sep 2007 01:03:46 -0700
Received: from gate.crashing.org ([63.228.1.57]
	ident=[U2FsdGVkX1/o6070tWNk+EI9Z5iT/svnOxXxFXDDFdc=])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IbtmC-0002up-ED
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 30 Sep 2007 01:03:45 -0700
In-Reply-To: <Pine.LNX.4.64.0709300910570.10965@anakin>
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Andrew Morton <akpm@osdl.org>, Andy Whitcroft <apw@uk.ibm.com>


On Sun, 2007-09-30 at 09:11 +0200, Geert Uytterhoeven wrote:
> On Sun, 30 Sep 2007, Benjamin Herrenschmidt wrote:
> > > Probably scripts/checkpatch.pl should be taught to complain about
> > > `#undef DEBUG'.
> > 
> > Why ? Whenever I have things that are #ifdef DEBUG in the file (such as
> > dev_dbg statements), I always leave a #undef DEBUG statement at the top.
> 
> Because it overrides a -DDEBUG on the build command line.

Hrm... ok, I never play with the commandline :-)

> > That way, I know I can enable debug in that file by flicking it.
> 
> Just add #define DEBUG at the top?

Yeah well, it's really just a reminder that there's DEBUG stuff in that
file, but feel free to send a patch removing it :-)

Ben.



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
