From: John Zielinski <grim@undead.cc>
Subject: Re: [PATCH] radeonfb(): memmove() fix -- this
 one works ;-)
Date: Wed, 28 Apr 2004 19:00:58 -0400
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <409037AA.5@undead.cc>
References: <Pine.LNX.4.44.0404281709260.1187-100000@phoenix.infradead.org> <Pine.GSO.4.58.0404281948260.11982@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BIy38-0006Oq-Tl
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 28 Apr 2004 16:01:06 -0700
Received: from ghoul.undead.cc ([216.126.84.18] helo=mail.undead.cc)
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1BIy38-0007B8-FH
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 28 Apr 2004 16:01:06 -0700
In-Reply-To: <Pine.GSO.4.58.0404281948260.11982@waterleaf.sonytel.be>
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
Cc: James Simmons <jsimmons@infradead.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Eger <eger-dated-1083663529.7e8c27@theboonies.us>, "Antonino A. Daplas" <adaplas@hotpop.com>, eger-dated-1082943669.d79d33@theboonies.us, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Geert Uytterhoeven wrote:

>So I cannot have a mode that's not in modedb, since it won't survive switching
>VTs.
>
>  
>
It would be possible.  Let's say that the future fbset can modify the 
kernels modedb and that the vt driver can also swtich to a mode by an 
alias string.  All fbset would have to do is create a new modedb entry 
called "vt02_temp_mode" and then tell the vt to switch VT 2 to 
"vt02_temp_mode".  The vt driver remembers that VT 2 is now set to 
"vt02_temp_mode" (via a pointer or a numeric modedb index or something) 
so when you switch to back to VT 2 you get your custom mode again.

The VT's vc_data struct would have an extra pointer/index variable.  If 
it's non zero it uses that to reference the proper modedb entry.  If 
it's zero then it uses it's x,y,Hz,bpp variables to reference the proper 
modedb.  This way you could also have multiple modes with the same 
x,y,Hz,bpp but different timing and sync options.

This approach would also get rid of the need for a special mode set api 
for fbset to tweak the current mode timing.  It would just use the 
standard kernel modedb editing API.

John




-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE. 
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
