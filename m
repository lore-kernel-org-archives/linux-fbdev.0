From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] neofb patches
Date: Wed, 28 Apr 2004 10:26:34 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.58.0404281025440.3644@waterleaf.sonytel.be>
References: <Pine.LNX.4.44.0404280019070.23153-100000@phoenix.infradead.org>
  <408EF0D9.6000403@undead.cc> <1083109849.20091.1.camel@gaston>
 <408EFD18.7070702@undead.cc>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BIkPC-00021G-JF
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 28 Apr 2004 01:26:58 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1BIkPC-00084X-0Z
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 28 Apr 2004 01:26:58 -0700
In-Reply-To: <408EFD18.7070702@undead.cc>
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
To: John Zielinski <grim@undead.cc>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, James Simmons <jsimmons@infradead.org>, Alex Stewart <alex@foogod.com>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Tue, 27 Apr 2004, John Zielinski wrote:
> For example lets say I have odd numbered consoles mapped on my AGP
> Radeon card and even numbered consoles mapped to my PCI Riva card.  I
> switch to console 1 and fire up a fb dvd player app.  It opens /dev/fb
> (29,255) and switches to KD_GRAPHICS.   LOTR starts playing on my big
> 21" monitor hooked up to the Radeon.  As a user I didn't have to know
> that /dev/fb0 was really my 21" monitor and didn't have to give any
> command line switches to do this.  The cursor was blinking on my 21" and
> all I had to do is type dvdplay and away I went.  I would also be
> prevented from switching to odd numbered consoles now.
>
> No problem.  ALT-F2 and now my 19" monitor has a blinking cursor.  I
> type in picview and again the jpeg viewing program opens /dev/fb and
> switches to KD_GRAPHICS and now I'm looking a vacation photos on my old
> riva card.  Again, I didn't have to know that /dev/fb1 is my 19" monitor
> and no command line arguments.  The app fires up on the monitor that had
> the focus (forground console doesn't sound right on multi monitor setups
> IMHO).
>
> Now I can only switch between console 1 and 2.  Consoles 3 and up can't
> be switched to as both fb devices are in use.

So you break the virtualization layer of the VTs. I still want to be able to
switch to consoles 3 and up.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE. 
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
