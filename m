From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Some questions
Date: Thu, 6 Mar 2003 11:14:15 +0100 (MET)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0303061113520.28248-100000@vervain.sonytel.be>
References: <1046944674.1332.68.camel@localhost.localdomain>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail2.sonytel.be ([195.0.45.172] helo=mail.sonytel.be)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18qsQ7-0007zz-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 06 Mar 2003 02:16:12 -0800
In-Reply-To: <1046944674.1332.68.camel@localhost.localdomain>
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
To: Antonino Daplas <adaplas@pol.net>
Cc: Thomas Winischhofer <thomas@winischhofer.net>, James Simmons <jsimmons@infradead.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On 6 Mar 2003, Antonino Daplas wrote:
> On Thu, 2003-03-06 at 17:12, Geert Uytterhoeven wrote:
> > What if fbcon implements a text console _on top of_ fbdev? I.e. it uses the
> > current resolution?
> > 
> > If you use stty to change the number of cols/rows, or change the font, or use
> > fbset, your text console may end up being smaller or larger than the real
> > screen size, in which case margins are cleared, or columns/lines are lost.
> > (Optionally, we can center the text console if it's smaller than the real
> >  screen size.)
> > 
> 
> Which is basically what stty does for the standard console (except that
> lines are not lost, but wrapped, and margins are not cleared).
> 
> So, we need to reimplement the clipping code.

In fbcon, I hope?

> > IMHO this is the most orthogonal approach. Fbcon takes care of the text
> > console, fbdev takes care of the graphics hardware and the video mode. Both
> > parts do (try to) not influence each other.
> > 
> > Optionally, fbset can call stty to change the number of cols/rows, if the user
> > wants that.
> 
> Or even a simple script that basically does "fbset 1024x768-60 && stty
> cols 128 rows 48". Of course, adding this to fbset itself will make it
> transparent to the user.
> 
> Sounds very logical to me :-)

Yep ;-)

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
