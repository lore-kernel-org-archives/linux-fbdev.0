From: Kronos <kronos@people.it>
Subject: Re: radeon_pm.c locking problem
Date: Fri, 2 Jul 2004 20:52:41 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040702185241.GA25832@dreamland.darkstar.lan>
References: <40E59B82.7000807@undead.cc>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BgT9e-0006V0-AM
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 02 Jul 2004 11:52:58 -0700
Received: from mail-relay-2.tiscali.it ([212.123.84.92])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1BgT9d-0006Ga-M5
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 02 Jul 2004 11:52:58 -0700
Content-Disposition: inline
In-Reply-To: <40E59B82.7000807@undead.cc>
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
To: John Zielinski <grim@undead.cc>
Cc: linux-fbdev-devel@lists.sourceforge.net, Benjamin Herrenschmidt <benh@kernel.crashing.org>

Il Fri, Jul 02, 2004 at 01:29:38PM -0400, John Zielinski ha scritto: 
> *This message was transferred with a trial version of CommuniGate(tm) Pro*
> There's a post in the lkml from a Stanford researcher working on a tool 
> to sniff out locking problems.  In his post he gave an example from the 
> radeon_pm.c file.  Just want to make sure the appropriate people noticed 
> the post.  It's subject is "[BUGS] [CHECKER] 99 synchronization bugs and 
> a lock summary database".

Hum, it seems a real bug because OUTPLL is a macro. The following line
(radeon_pm.c:323, but there are more of them):

OUTPLL(pllPIXCLKS_CNTL, INPLL(pllPIXCLKS_CNTL) & ~PIXCLKS_CNTL__PIX2CLK_SRC_SEL_MASK);

is expanded in:

do {
        unsigned long flags;
        spin_lock_irqsave(&rinfo->reg_lock, flags);
        __OUTPLL(pllPIXCLKS_CNTL, INPLL(pllPIXCLKS_CNTL) & ~PIXCLKS_CNTL__PIX2CLK_SRC_SEL_MASK);
        spin_unlock_irqrestore(&rinfo->reg_lock, flags);
} while(0)

and INPLL will try to reacquire the lock ->reg_lock. We could either use
__INPLL (which does not take the lock) or make OUTPLL an inline function
(in this way INPLL is called before entering the function).

Ben?

Luca
-- 
Home: http://kronoz.cjb.net
#include <stdio.h> 
int main(void) {printf("\t\t\b\b\b\b\b\b");
printf("\t\t\b\b\b\b\b\b");return 0;}


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
