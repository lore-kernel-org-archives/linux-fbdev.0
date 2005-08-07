From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Choosing the correct framebuffer
	configuration
Date: Sun, 07 Aug 2005 18:14:59 +0200
Message-ID: <1123431300.30257.116.camel@gaston>
References: <9e473391050805184756f055ea@mail.gmail.com>
	 <Pine.LNX.4.62.0508071145100.31010@gorilla.sonytel.be>
	 <9e473391050807083327b190f9@mail.gmail.com>
	 <1123430435.3848.332.camel@localhost>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E1nsS-0003Re-FW
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 07 Aug 2005 09:19:56 -0700
Received: from gate.crashing.org ([63.228.1.57])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1E1nsQ-00020D-Se
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 07 Aug 2005 09:19:56 -0700
In-Reply-To: <1123430435.3848.332.camel@localhost>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
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
To: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Cc: linux-fbdev-devel@lists.sourceforge.net, Geert Uytterhoeven <geert@linux-m68k.org>


> > The problem is that the radeonfb driver sees bpp = 32 and then sets
> > rgbt = 8/8/8/8. It stomps rgbt without looking at it.
> 
> Looks like a radeonfb bug.

It's not a bug :) radeonfb doesn't support anything but that format for
now. If you want to do something else, implement it :)
> 
> > The basic problem is what happens if bpp and rgbt are set in
> > conflicting ways. For example bpp = 16 and rgbt = 8/8/8/8. Which one
> > should win?
> 
> Read what you quoted from Geert above.
> 
> 



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
