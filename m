From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH]: EDID parser
Date: Thu, 3 Apr 2003 18:33:17 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0304031831030.23642-100000@vervain.sonytel.be>
References: <1049383273.11742.0.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail2.sonytel.be ([195.0.45.172] helo=mail.sonytel.be)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 1917fQ-0000K4-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 03 Apr 2003 08:34:21 -0800
In-Reply-To: <1049383273.11742.0.camel@dhcp22.swansea.linux.org.uk>
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
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Sven Luther <luther@dpt-info.u-strasbg.fr>, Petr Vandrovec <VANDROVE@vc.cvut.cz>, James Simmons <jsimmons@infradead.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 3 Apr 2003, Alan Cox wrote:
> On Iau, 2003-04-03 at 15:15, Sven Luther wrote:
> > > Read is not enough. If you have connected one /dev/fbx to two monitors,
> > > you must find highest common denominator for them, and use this one.
> > 
> > Err, i don't understand this ? Do you mean you are outputing to two
> > monitors at the same time ?
> 
> I think you mean lowest common denominator.
> 
> > If that is so maybe you mean, speaking in graphic card terminology, and
> > not in fbdev one, that you are sharing one common framebuffer between
> > two outputs, right, possibly doing mirroring tricks or something such ?
> 
> Classic example is a SiS 6326 driving monitor and TV. You need to keep
> the display to TV acceptable ranges.

I don't know whether that's a good example...

I assume the signal for the TV is different from the signal for the monitor
(these days you don't find many monitors that do 15.6 kHz / 50 Hz)? In that
case it's just the resolution that has to be more or less compatible.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds



-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
