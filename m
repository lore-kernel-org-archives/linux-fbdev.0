From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Some questions
Date: Wed, 5 Mar 2003 17:06:54 +0100 (MET)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0303051704040.23176-100000@vervain.sonytel.be>
References: <3E661EE3.8060108@winischhofer.net>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail2.sonytel.be ([195.0.45.172] helo=mail.sonytel.be)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18qbRQ-0001Kk-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 05 Mar 2003 08:08:25 -0800
In-Reply-To: <3E661EE3.8060108@winischhofer.net>
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
To: Thomas Winischhofer <thomas@winischhofer.net>
Cc: Antonino Daplas <adaplas@pol.net>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Wed, 5 Mar 2003, Thomas Winischhofer wrote:
> Geert Uytterhoeven wrote:
> > On Wed, 5 Mar 2003, Thomas Winischhofer wrote:
> >>Antonino Daplas wrote:
> >>>>Ack. Is 16 fuzzy enough, what do you think?
> >>>
> >>>I think you should only accept modes where the difference is a fraction
> >>>of a character width or height.  A difference more than that and
> >>>clear_margins() will not work correctly.  
> >>
> >>How do I - from a low level fb driver - determine the character size?
> > 
> > 
> > You cannot. That's called fbcon-fbdev separation.
> 
> My question was, basically, meant ironic.
> 
> But this is funny: You tell me that the difference should not exceed the 
> fraction of a character, but it is impossible to find out how wide/tall 
> characters are.
> 
> Guys, that won't work. I have to deal with LCD displays and TV output as 
> well (not to say "mainly") and I can't just set up odd modes like 
> 800x592, or mode resolutions based on calculations with any possible odd 
> font dimension.

Indeed. That's why fbcon should adapt to fbdev, and not vice versa (IMHO).

I've always been a bit skeptical about the fbcon-driven fbdev-resizing...
I don't mind that you change the resolution or fontsize, but it should not
influence the fbdev too much.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds



-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
