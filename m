From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: radeonfb on pegasos powerpc motherboard and
 X endianess problem
Date: Fri, 6 Jun 2003 08:35:49 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0306060834350.864-100000@vervain.sonytel.be>
References: <20030606063040.GC1173@iliana>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail2.sonytel.be ([195.0.45.172] helo=witte.sonytel.be)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19OAqR-0005wE-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 05 Jun 2003 23:36:59 -0700
In-Reply-To: <20030606063040.GC1173@iliana>
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
To: Sven Luther <sven.luther@wanadoo.fr>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Fri, 6 Jun 2003, Sven Luther wrote:
> On Fri, Jun 06, 2003 at 08:02:23AM +0200, Geert Uytterhoeven wrote:
> > On Thu, 5 Jun 2003, Sven Luther wrote:
> > > Actually, the OF has a x86 emulator which runs the x86 bios of the
> > > graphic card. 
> > 
> > Aha, so you get VGA text mode on bootup instead of linear graphics?
> 
> Yep, Ralph (who wrote the OF or something such) is telling me that the
> linear fb apperture doesn't fit in the vga aperture or something such,
> and that graphic mode would need vesa 3.x cards.

What about a similar solution to vesafb? Or does VESA 3.x mode switching
requires much more BIOS emulation code?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds



-------------------------------------------------------
This SF.net email is sponsored by:  Etnus, makers of TotalView, The best
thread debugger on the planet. Designed with thread debugging features
you've never dreamed of, try TotalView 6 free at www.etnus.com.
