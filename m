From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 0/3] fb accel capabilities (aka
	fast radeon fb, the right way)
Date: Fri, 14 May 2004 08:52:58 +1000
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1084488777.29107.114.camel@gaston>
References: <Pine.LNX.4.58.0405130131460.2282@rosencrantz.theboonies.us>
	 <Pine.GSO.4.58.0405131309030.9790@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BOP72-0007SM-GM
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 13 May 2004 15:55:36 -0700
Received: from gate.crashing.org ([63.228.1.57] ident=root)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30)
	id 1BOP72-0005T0-7x
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 13 May 2004 15:55:36 -0700
In-Reply-To: <Pine.GSO.4.58.0405131309030.9790@waterleaf.sonytel.be>
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
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: David Eger <eger-dated-1085010079.06feaf@theboonies.us>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, James Simmons <jsimmons@infradead.org>


> Well, we still need a way to know when the fbdev has to reinitialize its accel
> engine, when switching the console from graphics mode (user space does accel)
> to text mode (kernel uses accel). Currently this is done when FB_ACCELF_TEXT is
> set.

Current fbcon should do a set_var with FB_ACTIVATE_FORCE (thus forcing a
call to set_par) when switching from KD_TEXT to KD_GRAPHICS

> BTW, we've been talking about allowing kernel messages (mainly oops and panic)
> to show up under X. Since we cannot use the accel engine for that, perhaps we
> need different routines for fb_{fillrect,copyarea,imageblit}() for the
> accelerated vs. non-accelerated cases? And fbcon could compare the function
> pointers, instead of looking at .hwaccel.
> 
> (Yes, I know it's still possible to lock up your card when using unaccelerated
>  drawing while an accelerated operation is in progress on some cards).

Comparing function pointers ? That's evil ;)

Ben.




-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
