From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] neofb patches
Date: Wed, 28 Apr 2004 13:18:27 +1000
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1083122306.20091.33.camel@gaston>
References: <Pine.LNX.4.44.0404280019070.23153-100000@phoenix.infradead.org>
	 <408EF0D9.6000403@undead.cc> <1083109849.20091.1.camel@gaston>
	 <408EFD18.7070702@undead.cc> <1083112862.20474.14.camel@gaston>
	 <408F0B61.5090806@undead.cc>
	 <52520.64.139.3.221.1083122220.squirrel@www.foogod.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BIfgW-0006TH-Sx
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 27 Apr 2004 20:24:32 -0700
Received: from gate.crashing.org ([63.228.1.57] ident=root)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30)
	id 1BIfgV-0003G4-IN
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 27 Apr 2004 20:24:31 -0700
In-Reply-To: <52520.64.139.3.221.1083122220.squirrel@www.foogod.com>
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
To: Alex Stewart <alex@foogod.com>
Cc: grim@undead.cc, James Simmons <jsimmons@infradead.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> Firstly, all of the graphical apps you're describing should be VT-aware. 
> If they aren't, you shouldn't be using them on anything other than
> dedicated framebuffers anyway, really.  It's not hard to make an app work
> with VTs and it really is the correct way to do things for anything that
> is likely to be run in a VT-console environment.

A good idea would be to produce a library that implement most of the
ground VT handling work in fact... That would simplify things for
apps tremendously. Though it should probably sit between the app
and the kernel for console input as well.

It would basically callback into the app for things like beeing swithout
out and back in.

> With this issue solved, all that needs to be done is to make it so that
> apps which open up a new VT, automatically get it on the same framebuffer
> as the currently active console (or better yet, the console associated
> with the app) is on (which is really the most intuitive thing anyway, and
> should probably be done on general principle).  Problem solved.
> 
> You really don't need all the complex machinations of a magic /dev/fb
> device to achieve this.  If the rest of the system is designed well the
> right behavior should be automatic without this extra effort.
> 
> -alex
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>



-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE. 
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
