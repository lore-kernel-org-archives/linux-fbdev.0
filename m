From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] radeonfb(): memmove() fix -- this
	one works ;-)
Date: Thu, 22 Apr 2004 09:08:27 +1000
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1082588907.2077.89.camel@gaston>
References: <Pine.LNX.4.44.0404211851520.9207-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BGQqt-0007zI-2k
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 21 Apr 2004 16:09:59 -0700
Received: from gate.crashing.org ([63.228.1.57] ident=root)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30)
	id 1BGQqs-0001c5-KZ
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 21 Apr 2004 16:09:58 -0700
In-Reply-To: <Pine.LNX.4.44.0404211851520.9207-100000@phoenix.infradead.org>
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
Cc: David Eger <eger-dated-1082943669.d79d33@theboonies.us>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>


> Struct fb_pixmap. We have data pointer *addr. The only problem is using 
> the memory space to the right of the visible framebuffer
> 
> ------------|
> |	|   |
> |	|   |
> --------------
> 
> At the bottom of the framebuffer it would be no problem. We could even use 
> struct fb_pixmap with texture maps. Store fonts as texture maps and just 
> draw them to a surface. You can do lots of fancy tricks. The only issue I 
> have thought about is we might need to had a hook for fb_get_buffer_offset.
> Not to big a deal.

The choice of where to allocate that pixmap may not be trivial. It would
be interesting to have a call to the fbdev to deal with that. If we call
this pixmap the "work area" for example (or whatever fancy name you can
find), we could have a call "prepare_work_area" to the fbdev, giving it
the size requested by the client (based on the font size).

That should stay optional as it's not interesting for drivers without a
fast copyarea of course.

Ben.




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
