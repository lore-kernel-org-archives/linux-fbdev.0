From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: scrollmode, accel_flags, fbcon.c ...
Date: Tue, 30 Mar 2004 08:35:07 +1000
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1080599707.1210.44.camel@gaston>
References: <Pine.LNX.4.44.0403291824020.15706-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B85M5-0007Sa-27
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 29 Mar 2004 14:35:41 -0800
Received: from gate.crashing.org ([63.228.1.57] ident=root)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30)
	id 1B85M4-0003dK-Jm
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 29 Mar 2004 14:35:40 -0800
In-Reply-To: <Pine.LNX.4.44.0403291824020.15706-100000@phoenix.infradead.org>
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
To: James Simmons <jsimmons@infradead.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, David Eger <eger-dated-1080865620.ef4dea@theboonies.us>, Jakub Jelinek <jj@ultra.linux.cz>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Tue, 2004-03-30 at 03:50, James Simmons wrote:

> Why do we need a var for ever VC. The card is on one hardware state at 
> all times. The only times we nned to be concern with changes is for 
> setfont, resize and VC switching. These are not common occurs. If the 
> fbcon layer can't get the data it needs from struct vc_data then the upper
> console layer is broken.

I don't agree. If I set a special mode with fbset in one console I
wnat this mode to say in that console and only that console unless
I use -a. The vc_data doesn't carry enough informations to set a
mode. It would also make things a lot simpler for fbdev apps that
use a different mode. 

Anyway, for the current mecanism to work, we need picking a mode
properly when resized or mode switched, which isn't the case right
now. The "var" that fbcon_resize pass to the fbdev is at best bogus
currently. The FB_ACTIVATE_FIND thing I did helps if the fbdev can
properly lookup for a mode (though there are still some issues in
radeonfb implementation of this as you have noticed).

Ben.




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
