From: John Zielinski <grim@undead.cc>
Subject: Re: [PATCH] neofb patches
Date: Tue, 27 Apr 2004 20:38:48 -0400
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <408EFD18.7070702@undead.cc>
References: <Pine.LNX.4.44.0404280019070.23153-100000@phoenix.infradead.org>	 <408EF0D9.6000403@undead.cc> <1083109849.20091.1.camel@gaston>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BId6I-0005wy-3f
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 27 Apr 2004 17:38:58 -0700
Received: from ghoul.undead.cc ([216.126.84.18] helo=mail.undead.cc)
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1BId6H-0000a8-KM
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 27 Apr 2004 17:38:57 -0700
In-Reply-To: <1083109849.20091.1.camel@gaston>
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
Cc: James Simmons <jsimmons@infradead.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Alex Stewart <alex@foogod.com>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

Benjamin Herrenschmidt wrote:

>Hrm... I'm not fully confortable with this. I don't see why we need
>anything different but what we had today.
>
>  
>
For stuff like X, MacOnLinux, etc that totally take over it doesn't make 
too much sense.  But for framebuffer programs like picture viewers, 
movie players, games, and other non desktop single purpose applications 
it makes a lot of sense.

For example lets say I have odd numbered consoles mapped on my AGP 
Radeon card and even numbered consoles mapped to my PCI Riva card.  I 
switch to console 1 and fire up a fb dvd player app.  It opens /dev/fb 
(29,255) and switches to KD_GRAPHICS.   LOTR starts playing on my big 
21" monitor hooked up to the Radeon.  As a user I didn't have to know 
that /dev/fb0 was really my 21" monitor and didn't have to give any 
command line switches to do this.  The cursor was blinking on my 21" and 
all I had to do is type dvdplay and away I went.  I would also be 
prevented from switching to odd numbered consoles now.

No problem.  ALT-F2 and now my 19" monitor has a blinking cursor.  I 
type in picview and again the jpeg viewing program opens /dev/fb and 
switches to KD_GRAPHICS and now I'm looking a vacation photos on my old 
riva card.  Again, I didn't have to know that /dev/fb1 is my 19" monitor 
and no command line arguments.  The app fires up on the monitor that had 
the focus (forground console doesn't sound right on multi monitor setups 
IMHO).

Now I can only switch between console 1 and 2.  Consoles 3 and up can't 
be switched to as both fb devices are in use.

BTW, this is just an example.  I don't know if a fb dvd player is out 
there but I do belive there's a picture viewing fb app.

>Nah, software like X, MacOnLinux, etc... should open a VT and trigger a
>console switch. Or at least switch to KD_GRAPHICS if they don't, but
>then, having a user doing that to your console is only a matter of
>setting the proper permissions. Again, I don't see what problem you
>are trying to solve.
>  
>

Normally yes.  But let's say a switch was added to X or X's fb driver to 
tell it to not open a new VT and just start on the current console.  If 
I fire it up on console 1 X starts on my 21" monitor but if I start it 
on console 2 it fires up on my 19" monitor.  The other monitor would 
still have a console.

This was just a fun thought to see if it would actually work.  But the 
dvd/picture example above is very practical.

John




-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE. 
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
