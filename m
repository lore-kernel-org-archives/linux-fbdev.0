From: John Zielinski <grim@undead.cc>
Subject: Re: [PATCH] radeonfb(): memmove() fix -- this
 one works ;-)
Date: Tue, 27 Apr 2004 18:41:58 -0400
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <408EE1B6.9010707@undead.cc>
References: <Pine.LNX.4.44.0404240035400.5826-100000@phoenix.infradead.org> <1083025364.11575.4.camel@gaston> <Pine.GSO.4.58.0404271050540.14434@waterleaf.sonytel.be> <Pine.LNX.4.58.0404271119001.31905@rosencrantz.theboonies.us> <Pine.GSO.4.58.0404271156250.14434@waterleaf.sonytel.be> <1083060569.16473.2.camel@gaston> <Pine.GSO.4.58.0404271319210.14434@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BIbHE-000063-5f
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 27 Apr 2004 15:42:08 -0700
Received: from mail.undead.cc ([216.126.84.18])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1BIbHD-0003Ne-ED
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 27 Apr 2004 15:42:07 -0700
In-Reply-To: <Pine.GSO.4.58.0404271319210.14434@waterleaf.sonytel.be>
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
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Eger <eger@theboonies.us>, James Simmons <jsimmons@infradead.org>, "Antonino A. Daplas" <adaplas@hotpop.com>, eger-dated-1082943669.d79d33@theboonies.us, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Geert Uytterhoeven wrote:

>>On the other hand, I tend to think that if you have a KD_TEXT console,
>>accel is under fbcon control, if you have a KD_GRAPHICS console, then
>>the accel engine is under you control. I don't think any else make any
>>sense in fact
>>    
>>
>
>You're right, I forgot about that.
>  
>
That's a good idea.  I'm tinkering with the idea that when an app 
switches to KD_GRAPHICS that it lock out all other attempts to access 
the framebuffer.  I ran two copies of fbtest about 5 seconds apart and 
the results were interesting....  :)

So using KD_TEXT/KD_GRAPHICS as the access control mechanism between 
multiple applications and fbcon might be the way to go.  It already 
tells the console to not to write to the screen so it seems like a 
natural extension of the concept.

John




-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE. 
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
