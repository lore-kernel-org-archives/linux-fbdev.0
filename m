From: John Zielinski <grim@undead.cc>
Subject: Re: [PATCH] neofb patches
Date: Wed, 28 Apr 2004 18:00:46 -0400
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <4090298E.8090004@undead.cc>
References: <Pine.LNX.4.44.0404280019070.23153-100000@phoenix.infradead.org>  <408EF0D9.6000403@undead.cc> <1083109849.20091.1.camel@gaston> <408EFD18.7070702@undead.cc> <Pine.GSO.4.58.0404281025440.3644@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BIx6s-0001QB-Ke
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 28 Apr 2004 15:00:54 -0700
Received: from ns2.undead.cc ([216.126.84.18] helo=mail.undead.cc)
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1BIx6s-0003Dg-5r
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 28 Apr 2004 15:00:54 -0700
In-Reply-To: <Pine.GSO.4.58.0404281025440.3644@waterleaf.sonytel.be>
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
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, James Simmons <jsimmons@infradead.org>, Alex Stewart <alex@foogod.com>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

Geert Uytterhoeven wrote:

>>Now I can only switch between console 1 and 2.  Consoles 3 and up can't
>>be switched to as both fb devices are in use.
>>    
>>
>
>So you break the virtualization layer of the VTs. I still want to be able to
>switch to consoles 3 and up.
>  
>
Nope, nothing is broken.  The limitation is the fb application.  If the 
app using the framebuffer knows how to handle being switched away from 
(releasing the fb after getting the switch away signal and reacquiring 
the fb and repainting when getting the switch to signal) then switching 
to the other consoles would work.

John




-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE. 
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
