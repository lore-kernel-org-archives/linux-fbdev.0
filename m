From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Some questions
Date: Thu, 6 Mar 2003 10:12:19 +0100 (MET)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0303061006180.28248-100000@vervain.sonytel.be>
References: <3E670B82.30900@winischhofer.net>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail2.sonytel.be ([195.0.45.172] helo=mail.sonytel.be)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18qrRr-0002Uy-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 06 Mar 2003 01:13:56 -0800
In-Reply-To: <3E670B82.30900@winischhofer.net>
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
Cc: Antonino Daplas <adaplas@pol.net>, James Simmons <jsimmons@infradead.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Thu, 6 Mar 2003, Thomas Winischhofer wrote:
> Antonino Daplas wrote:
> > fbcon_resize() is not that broken, it's only trying to do what it's
> > supposed to do.  It is indeed limited because it is trying to outguess
> > the low-level drivers on the best resolution for a window size.
> > 
> > However, the brokenness is really on the driver side.  They are unable
> > to change the video mode unless they are supplied with the correct
> > timing parameters where in fact they actually have the best knowledge on
> > how to calculate them.  
> 
> Yes, BUT ONLY IF the driver has enough parameters to calculate it. This 
> requires at least x and y dimension AND A CLOCK (or a vertical refresh 
> rate, which I would prefer).
> 
> The driver is supposed to handle the "var"s it's fed. If that var is 
> like the ones that result from the current fbcon_resize, namely with a 
> new x and y res, but no valid clock, how on earth should the driver do 
> this then? It receives a var which looks correct, and in fact, *could* 
> be correct sometimes:
> 
> Suppose we have another application, say DirectFB, feeding the low level 
> drivers with complete and correct "var"s.
> 
> In both cases we have valid x any y resultions, and a non-zero clock field.
> 
> Should we then let the driver read the x and y resolution and forget 
> about the rest of that var? I hardly think that's what the public var is 
> for. It could be reduced to a struct { USHORT xres, USHORT yres } then.
> 
> > So the question:  Do we let fbcon spoonfeed the timings to fbdev, or do
> > we let the drivers calculate it for themselves?  I go for the latter, as
> > fbcon really should not have any business with hardware.
> 
> What about the following solution: What if fbcon_resize sets the clock 
> in the var to 0? We could use this to force low level drivers to decide 
> on the clock for themselves. Otherwise, ie if the clock field is 
> non-zero, they are supposed to take it as the desired clock.

What if fbcon implements a text console _on top of_ fbdev? I.e. it uses the
current resolution?

If you use stty to change the number of cols/rows, or change the font, or use
fbset, your text console may end up being smaller or larger than the real
screen size, in which case margins are cleared, or columns/lines are lost.
(Optionally, we can center the text console if it's smaller than the real
 screen size.)

IMHO this is the most orthogonal approach. Fbcon takes care of the text
console, fbdev takes care of the graphics hardware and the video mode. Both
parts do (try to) not influence each other.

Optionally, fbset can call stty to change the number of cols/rows, if the user
wants that.

What do you think?

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
