From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Re: Framebuffer console not working with
	matroxfb on 2.6
Date: Sun, 26 Sep 2004 18:29:34 +1000
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1096187374.576.305.camel@gaston>
References: <3B9599C3EB4@vcnet.vc.cvut.cz>
	 <200409171921.50273.adaplas@hotpop.com>
	 <Pine.GSO.4.58.0409171349430.19914@waterleaf.sonytel.be>
	 <200409172138.29021.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CBUR1-0006gd-G4
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 26 Sep 2004 01:31:07 -0700
Received: from gate.crashing.org ([63.228.1.57])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1CBUQy-0001lf-F0
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 26 Sep 2004 01:31:07 -0700
In-Reply-To: <200409172138.29021.adaplas@hotpop.com>
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
To: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Antonino Daplas <adaplas@pol.net>


> Indeed it does.  So why didn't radeonfb not use the mode?  Is it a problem
> with fb_find_mode() or radeonfb?

I suspect my radeonfb is bad at using mode paremeters to the module,
does it work with fbdev afterward ?

I need to work on it, I did a pretty good job with digital panels but
I think I may have broken a few stuffs useful with analog, like boot mode
setting...

Ben.




-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
