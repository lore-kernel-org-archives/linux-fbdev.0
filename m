From: John Zielinski <grim@undead.cc>
Subject: Re: [PATCH] radeonfb(): memmove() fix -- this
 one works ;-)
Date: Tue, 27 Apr 2004 18:28:25 -0400
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <408EDE89.2050305@undead.cc>
References: <Pine.LNX.4.44.0404240035400.5826-100000@phoenix.infradead.org>	 <1083025364.11575.4.camel@gaston>	 <Pine.GSO.4.58.0404271050540.14434@waterleaf.sonytel.be>	 <Pine.LNX.4.58.0404271119001.31905@rosencrantz.theboonies.us> <1083060616.16475.4.camel@gaston>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BIb4B-0005i9-69
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 27 Apr 2004 15:28:39 -0700
Received: from mail.undead.cc ([216.126.84.18])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1BIb4A-0000Zm-Gq
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 27 Apr 2004 15:28:38 -0700
In-Reply-To: <1083060616.16475.4.camel@gaston>
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
Cc: David Eger <eger-dated-1083663529.7e8c27@theboonies.us>, Geert Uytterhoeven <geert@linux-m68k.org>, James Simmons <jsimmons@infradead.org>, "Antonino A. Daplas" <adaplas@hotpop.com>, eger-dated-1082943669.d79d33@theboonies.us, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Benjamin Herrenschmidt wrote:

>The whole var thing is too messy right now. Especially, the lack of a
>per-VT var right now makes things even more difficult
>  
>
I'm currently in the middle of adding a per-VT var to my kernel.  
They'll be in addition to the fb's current var so that when a fb using 
program releases the frame buffer I can restore the VT's var instead of 
depending on the app to do it right.  I'll post some patches when I get 
things working properly. 

John




-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE. 
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
