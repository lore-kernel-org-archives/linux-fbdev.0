From: James Simmons <jsimmons@infradead.org>
Subject: Re: Re: fbdev changes.
Date: Fri, 18 Oct 2002 11:02:35 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0210181059450.10832-100000@maxwell.earthlink.net>
References: <Pine.GSO.4.21.0210141020550.9580-100000@vervain.sonytel.be>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from swan.mail.pas.earthlink.net ([207.217.120.123])
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 182bYe-0008QE-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 18 Oct 2002 11:09:12 -0700
In-Reply-To: <Pine.GSO.4.21.0210141020550.9580-100000@vervain.sonytel.be>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Petr Vandrovec <vandrove@vc.cvut.cz>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>


> > And what is meaning of image when mask is 1? For b&w cursors
> > we need 0, 1, transparent and inverse.
>
> Note that not all hardware supports inverse.

Hm. The best solution to this is support the flag but we need to know if
the hardware supports it. The best thing to do is use the a GETCURSOR
ioctl call that returns what we can do.

> And on some hardware the cursor palette is shared with the screen palette,
> that's why I had fb_fix_cursorinfo.crsr_color[12] in the original cursor API.

In this case the provided cursor function would use puedopalette in
fb_info then.

> Yes, it can be difficult to find a _good_ API ;-)

We can but we need to provide a way to say we can't do that.



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
