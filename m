From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] radeonfb: remove reg_lock nonsense
Date: Tue, 06 Jul 2004 07:08:47 -0500
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1089115727.1899.27.camel@gaston>
References: <200407051043.i65AhCG13509@mail.osdl.org>
	 <Pine.LNX.4.58.0407051028250.1764@ppc970.osdl.org>
	 <20040706081037.GA9036@havoc.gtf.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BholM-0004uR-Vc
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 06 Jul 2004 05:09:28 -0700
Received: from gate.crashing.org ([63.228.1.57])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.34)
	id 1BholM-0001oO-Ih
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 06 Jul 2004 05:09:28 -0700
In-Reply-To: <20040706081037.GA9036@havoc.gtf.org>
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
To: David Eger <eger@havoc.gtf.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> I agree, the patch is horrid.  In fact, now that I really look at it,
> it seems that the spinlock is totally bogus.  This patch removes it.
> Details below.
> 
> BenH: thoughts, objections?

The lock is meant to keep writes to the PLL index register followed
with a read/write of the PLL data register together. It is necessay
for OUTPLL/INPLL as long as radeonfb can be re-entered.

I recently fixed a whole bunch of races at the VT & fbdev level that
would cause such re-entering, but we still, I think, have a potential
issue with the cursor code, maybe the blanking code, and with the
timer I setup for the LVDS updates.

Ben.




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
