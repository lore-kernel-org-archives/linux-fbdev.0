From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Re: [PATCH] radeonfb: remove reg_lock
	nonsense
Date: Wed, 07 Jul 2004 10:35:11 -0500
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1089214511.2026.25.camel@gaston>
References: <200407051043.i65AhCG13509@mail.osdl.org>
	 <Pine.LNX.4.58.0407051028250.1764@ppc970.osdl.org>
	 <20040706081037.GA9036@havoc.gtf.org> <1089115727.1899.27.camel@gaston>
	 <20040707072441.GA13160@havoc.gtf.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BiETg-0000T4-Si
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 07 Jul 2004 08:36:56 -0700
Received: from gate.crashing.org ([63.228.1.57])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.34)
	id 1BiETg-0000Lp-F2
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 07 Jul 2004 08:36:56 -0700
In-Reply-To: <20040707072441.GA13160@havoc.gtf.org>
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

>  radeonfb can be re-entered.
> 
> Hmmm :-/
> 
> In that case, I have a patch which implements both of Linus's suggestions,
> making OUTPLL()/INPLL() inlines and making the caller responsible for
> taking the register lock when calling OUTPLL()/INPLL().
> 
> On the upside, the number of lockings goes down from 159 to 24.  
> On the downside, that means about 70 more lines of code via:
> from 48 spin lock & unlock lines and 17 'flags' decls
> 
> I'll leave it up to your discretion whether to apply.

It's probably better to move to such locking, indeed. Just make sure
you don't keep the lock on the wait_for_* loops though (haven't looked
at the code in detail yet).

Ben.




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
