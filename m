From: John Zielinski <grim@undead.cc>
Subject: Re: [PATCH] radeonfb(): memmove() fix -- this
 one works ;-)
Date: Tue, 27 Apr 2004 19:54:49 -0400
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <408EF2C9.4020707@undead.cc>
References: <Pine.LNX.4.44.0404280013210.23153-100000@phoenix.infradead.org> <1083108311.16476.56.camel@gaston>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BIcPg-0006HQ-PC
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 27 Apr 2004 16:54:56 -0700
Received: from ns2.undead.cc ([216.126.84.18] helo=mail.undead.cc)
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1BIcPg-0008Kw-AY
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 27 Apr 2004 16:54:56 -0700
In-Reply-To: <1083108311.16476.56.camel@gaston>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: James Simmons <jsimmons@infradead.org>, David Eger <eger-dated-1083663529.7e8c27@theboonies.us>, Geert Uytterhoeven <geert@linux-m68k.org>, "Antonino A. Daplas" <adaplas@hotpop.com>, eger-dated-1082943669.d79d33@theboonies.us, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Benjamin Herrenschmidt wrote:

>>1) Color depth.
>>2) Frequency.
>>3) Over scan color.
>>    
>>
>
>No, no, no ... We don't need those, we need a var structure, that's all.
>  
>

Yes, we need a var structure.  How else would you set one console to 
1920x540p and another to 1920x1080i (540 doublescan)?  Or try different 
timings?  I want my first console at a sane video mode like 480p while 
the others can I can play with.  If the HDTV I'm testing looses sync I 
can always switch to console one and restore all the consoles back to 
480p and try again without having to shell in via serial or over a 
network.  A second computer may not always be close at hand.

John




-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE. 
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
