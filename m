From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Re: New logo code (fwd)
Date: Wed, 12 Feb 2003 21:51:25 +0100 (MET)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0302122149470.14562-100000@vervain.sonytel.be>
References: <Pine.LNX.4.44.0302122026550.31435-100000@phoenix.infradead.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail2.sonytel.be ([195.0.45.172] helo=mail.sonytel.be)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18j3rp-0006hr-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 12 Feb 2003 12:52:29 -0800
In-Reply-To: <Pine.LNX.4.44.0302122026550.31435-100000@phoenix.infradead.org>
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
To: James Simmons <jsimmons@infradead.org>
Cc: Christoph Hellwig <hch@infradead.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Development <linux-kernel@vger.kernel.org>

On Wed, 12 Feb 2003, James Simmons wrote:
> > > > All comments are welcomed! Thanks!
> > > 
> > > Come on, is there really no one to comment on this??
> > 
> > Except a question why it's not merged yet? :)
> 
> Looking for work has keot me busy. I merged it. One change I did do was 
> changed the CONFIG_FB_LOGO_* to CONFIG_LOGO_. In theory any one can use 
> the logo (i.e newport console). It is a much welcomed improvement. I 

OK.

> removed the hgafb logo code in the latest tree. It should use the standard 
> logo code. Also how should we go about for personal logos. Companies might 
> want to throw in there own thing which I have no issue with.

An option CONFIG_LOGO_USER, and a path CONFIG_LOGO_USER_PATH to a logo? Or
multiple user-specific logos (one of each type)?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
