From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Framebuffer overflow halts network (fwd)
Date: Fri, 14 Feb 2003 10:23:16 +0100 (MET)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0302141021450.2129-100000@vervain.sonytel.be>
References: <007e01c2d3c6$193feb80$6705a8c0@gina>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail2.sonytel.be ([195.0.45.172] helo=mail.sonytel.be)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18jc5W-00082z-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 14 Feb 2003 01:24:54 -0800
In-Reply-To: <007e01c2d3c6$193feb80$6705a8c0@gina>
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
To: Leif Neland <leif@neland.dk>
Cc: James Simmons <jsimmons@infradead.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Fri, 14 Feb 2003, Leif Neland wrote:
> From: "James Simmons" <jsimmons@infradead.org>
> > > I have set up my primary work machine (i.e. it is mostly used as a
> terminal
> > > to connect to other servers) with framebuffer and have 64 lines*160
> chars in
> > > a pretty font.
> > >
> > > I ssh to other servers from this machine.
> > >
> > > If I do something which create a lot of output, eg. ls -lR /, the remote
> > > machine sends more data than the framebuffer-terminal can handle. This
> > > blocks the network on the terminal machine, which also is nameserver,
> > > internal webserver and upsd server.
> 
> > Which kernel are you using and whcih video card?
> 
> Debian-version: 3.0
> 
> Linux 2.2.19

In 2.2.19, the console subsystem disables interrupts when outputting to the
console. This was fixed in 2.4.x.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds



-------------------------------------------------------
This SF.NET email is sponsored by: FREE  SSL Guide from Thawte
are you planning your Web Server Security? Click here to get a FREE
Thawte SSL guide and find the answers to all your  SSL security issues.
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0026en
