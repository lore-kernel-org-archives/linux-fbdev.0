From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: radeon_pm.c locking problem
Date: Mon, 05 Jul 2004 08:44:53 -0500
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1089035092.3014.7.camel@gaston>
References: <40E59B82.7000807@undead.cc>
	 <20040702185241.GA25832@dreamland.darkstar.lan>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BhTmM-0007D6-Dj
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 05 Jul 2004 06:45:06 -0700
Received: from gate.crashing.org ([63.228.1.57])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.34)
	id 1BhTmM-0005Wh-1q
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 05 Jul 2004 06:45:06 -0700
In-Reply-To: <20040702185241.GA25832@dreamland.darkstar.lan>
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
To: Kronos <kronos@people.it>
Cc: John Zielinski <grim@undead.cc>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> is expanded in:
> 
> do {
>         unsigned long flags;
>         spin_lock_irqsave(&rinfo->reg_lock, flags);
>         __OUTPLL(pllPIXCLKS_CNTL, INPLL(pllPIXCLKS_CNTL) & ~PIXCLKS_CNTL__PIX2CLK_SRC_SEL_MASK);
>         spin_unlock_irqrestore(&rinfo->reg_lock, flags);
> } while(0)
> 
> and INPLL will try to reacquire the lock ->reg_lock. We could either use
> __INPLL (which does not take the lock) or make OUTPLL an inline function
> (in this way INPLL is called before entering the function).

Make it an inline function...

Ben.




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
