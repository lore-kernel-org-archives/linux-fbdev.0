From: James Simmons <jsimmons@transvirtual.com>
Subject: Re: Re: [PATCH] fbdev updates.
Date: Fri, 5 Jul 2002 12:57:29 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0207051246490.30731-100000@www.transvirtual.com>
References: <20020705204107.H27920@flint.arm.linux.org.uk>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from www.transvirtual.com ([206.14.214.140])
	by usw-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 17QZD1-0002la-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 05 Jul 2002 12:57:40 -0700
In-Reply-To: <20020705204107.H27920@flint.arm.linux.org.uk>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Russell King <rmk@arm.linux.org.uk>
Cc: Ani Joshi <ajoshi@shell.unixbox.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> > It is and has started to got into the mainline kernel. The thing was I was
> > bending over backwards to not break peoples drivers.
>
> If it's something small, then driver people don't mind having their
> drivers fixed.
>
> However, if its something large, just break them and let the driver people
> fix up the pieces (assuming you've got adequate documentation either in
> code or elsewhere for people to see both the reasons for the breakage,
> the direction you're heading in, and an example driver to follow.)
> Chances are that they'll know their driver better than anyone else.  If
> it stays broken through the next stable series, then start considering
> dropping the driver.
>
> That's how it works in the other subsystems.

Thinking about it I realized I did the wrong approach. Should I back out
all fbdev driver changes I did or leave some? In this case next week I
will start breaking the upper layer. First to go is the old fbgen code.
Then fields in struct display will start going away. Then get_fix and
stuff will go away.

> (FYI, you'll probably find that most people who didn't use the fbgen layer
> decided not to use it because of the fix <-> par <-> var mess it forced
> into the driver design.)

    I don't like it much either but at the same time I don't want to
break userland. I hate the converting back and forth. I want to make
it better.
    The idea was to make the drivers focused on a par but still generate
a var and fix and update struct fb_info for the upper layer to use. Par is
the main focus and it can be anything. Fix,var and struct fb_info are
only things to generate for the upper layer. We still want some kind of
data struct independent of the driver so we have a common code base for
fbcon. That was the whole idea.




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Bringing you mounds of caffeinated joy.
http://thinkgeek.com/sf
