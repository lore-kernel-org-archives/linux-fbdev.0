From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: FramBuffer for ep9310 ARM Board
Date: Tue, 8 Apr 2008 09:28:08 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0804080927400.20606@anakin>
References: <f63322490804072316g447cf528m5bd402f1b8f77645@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Jj8Fa-0007wy-GE for Linux-fbdev-devel@lists.sourceforge.net;
	Tue, 08 Apr 2008 00:28:14 -0700
Received: from winston.telenet-ops.be ([195.130.137.75])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Jj8FZ-0001Yg-2r
	for Linux-fbdev-devel@lists.sourceforge.net;
	Tue, 08 Apr 2008 00:28:14 -0700
In-Reply-To: <f63322490804072316g447cf528m5bd402f1b8f77645@mail.gmail.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Bhaskar <abc.bhaskar@gmail.com>
Cc: Linux-fbdev-devel@lists.sourceforge.net

On Tue, 8 Apr 2008, Bhaskar wrote:
> I need to modify modify Frame Buffer for ep9310 ARM board.  The
> original frame buffer was provided by Cirrus Logic.  For the debugging
> purpose, I introduced trace messages in frame buffer operation
> functions like imageblit, fillrect, etc.
> 
> These messages appear only during Linux boot up and shutdown.  When I
> move the window, none of the trace messages from the frame buffer
> appears.  The Xserver used is XOrg-6.9

The in-kernel frame buffer operation functions like imageblit, fillrect,
etc. are not used from userspace. X does all drawing itself.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Register now and save $200. Hurry, offer ends at 11:59 p.m., 
Monday, April 7! Use priority code J8TLD2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
