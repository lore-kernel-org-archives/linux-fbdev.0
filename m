From: James Simmons <jsimmons@infradead.org>
Subject: Re: Compiling Rage xlinit.c
Date: Wed, 19 May 2004 23:20:24 +0100 (BST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0405192024370.28783-100000@phoenix.infradead.org>
References: <40AB7102.5080803@bitworks.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BQZQO-0001B9-9Y
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 19 May 2004 15:20:32 -0700
Received: from phoenix.infradead.org ([213.86.99.234])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1BQZQN-0007Xm-Hh
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 19 May 2004 15:20:32 -0700
In-Reply-To: <40AB7102.5080803@bitworks.com>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Richard Smith <rsmith@bitworks.com>
Cc: stevel@mvista.com, fb-devel <linux-fbdev-devel@lists.sourceforge.net>, source@mvista.com


> > Sorry about the delayed response. I recieved that patch along time ago. 
> > It was ported to 2.6.X and I placed it into the BK repo for fbdev.
> > Xui from tyan sent me a patch to get it going. Since you have the specs to 
> > boot from scratch I really like to work with you on this. The code for the 
> > mach64 is old. I have newer code in my BK repos. If you need a patch I can 
> > send it to you.
> 
> Cool.  Hook me up.  Does the stuff in your BK contain all the M1 mods 
> from recient 2.4?  I've tried your fbdiff patch but it wouldn't apply to 
> 2.6.6 so I just used what was stock in 2.6.6.

Yes. Plus a few extra features like power management.
 
> I don't think the newer Mach64 code will make any difference right now 
> though.  If I run xlinit (with my mods) on a chip with only POR I don't 
> get a sync yet.
> 
> So I'm  still missing something.  I've got some questions pending with 
> ATI dev support and thier supposed to be trying to get me some info 
> (other than the bios source) on bringing up the chip from scratch.

Okay. I will send you a patch soon for your use.





-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
