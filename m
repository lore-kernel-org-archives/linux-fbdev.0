From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] neofb patches
Date: Tue, 27 Apr 2004 10:49:45 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.58.0404271047520.14434@waterleaf.sonytel.be>
References: <10078.171.72.5.226.1083003170.squirrel@www.foogod.com>
 <Pine.LNX.4.44.0404261933130.5302-100000@phoenix.infradead.org>
 <10682.171.72.5.133.1083028534.squirrel@www.foogod.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BIOI4-000268-5G
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 27 Apr 2004 01:50:08 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BIOI3-0005C6-OZ
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 27 Apr 2004 01:50:07 -0700
In-Reply-To: <10682.171.72.5.133.1083028534.squirrel@www.foogod.com>
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
To: Alex Stewart <alex@foogod.com>
Cc: James Simmons <jsimmons@infradead.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, Benjamin Herrenschmidt <benh@kernel.crashing.org>

On Mon, 26 Apr 2004, Alex Stewart wrote:
> I've never been too clear on what direction these FB_ACCELF things (and
> related values) are supposed to be going.  Are they something set by the
> driver to indicate what it can support, or are they something set by the
> higher level systems (or the user) to tell the driver what they would like
> to do?
>
> I had figured from the previous code that these flags should be set when
> calling check_var if the higher-level stuff wanted acceleration for the
> particular mode setting, and the driver would unset any it wasn't able to
> support.  This changes the behavior to automatically turning it on
> whenever the hardware is capable of it, regardless of what the higher
> level stuff asks for (which is actually probably a better protocol, but is
> it the way all the other stuff is expecting it to work?).

It's used to indicate that the frame buffer device uses hardware acceleration
for rectangle fill/copy and imageblit.

It must be explicitly disabled before a user space application can mmap the
MMIO registers to do its own hardware acceleration, to avoid accelerator access
conflicts.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
This SF.net email is sponsored by: The Robotic Monkeys at ThinkGeek
For a limited time only, get FREE Ground shipping on all orders of $35
or more. Hurry up and shop folks, this offer expires April 30th!
http://www.thinkgeek.com/freeshipping/?cpg=12297
