From: John Zielinski <grim@undead.cc>
Subject: Re: fbcon & resize
Date: Sun, 23 May 2004 22:10:57 -0400
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <40B159B1.9050108@undead.cc>
References: <1085360912.15281.7.camel@gaston>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BS4vj-0005x8-7n
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 23 May 2004 19:11:07 -0700
Received: from ghoul.undead.cc ([216.126.84.18] helo=mail.undead.cc)
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1BS4vi-0004Hn-OC
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 23 May 2004 19:11:06 -0700
In-Reply-To: <1085360912.15281.7.camel@gaston>
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
Cc: James Simmons <jsimmons@infradead.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Benjamin Herrenschmidt wrote:

>I still think the whole resize stuff is broken, despite your latest
>changes. The main problem is blindly using the modedb and not whatever
>mode list is provided by the driver (but we need an interface for that).
>
>  
>
How about making the modedb more like a real database.  It would contain 
the built in standard, vesa, and macmodes lists as well as lists 
provided by the driver and custom lists from the user.  A temp list 
would contain any tweaked modes created by a tweak utility (fbset, etc) 
and also for modes for displays that can take any resolution.  The mode 
displayed on each VT and modes set by applications would just be 
pointers into the database so checking if a mode switch would be very easy.

And it need not be limited to geometries but could also include bit 
formats, supported virtual resolutions, etc.

This is the current approach I'm taking in my own project.

>We need to cleanup and generalize a function for matching a mode to
>the mode list to be used by drivers for validation in check_var() too,
>my current algorithm in radeonfb is a bit broken for CRTs for example,
>and has the nasty habit of refusing modes rather than "adapting" them.
>  
>
I'm curious as to what you mean by "adapting" them.

John




-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
