From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [Linux-fbdev-devel] Re: FBdev updates.
Date: Fri, 21 Feb 2003 10:04:19 +0100 (MET)
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <Pine.GSO.4.21.0302211003250.9232-100000@vervain.sonytel.be>
References: <1045791900.21577.5.camel@rth.ninka.net>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <1045791900.21577.5.camel@rth.ninka.net>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@redhat.com>
Cc: James Simmons <jsimmons@infradead.org>, Petr Vandrovec <vandrove@vc.cvut.cz>, Dave Jones <davej@codemonkey.org.uk>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On 20 Feb 2003, David S. Miller wrote:
> On Thu, 2003-02-20 at 11:58, James Simmons wrote:
> > > (3) persuade me that I want to write matroxcon and forget about fbcon at all, or
> > 
> > This is the best solution. 

Huh?

> And then we will have sbuscon as well, thus two places where
> putcs() is necessary.
> 
> I don't understand, but I do hope that at some point it will be
> realized that maybe allowing fbcon to generically handle putcs()
> hardware is beneficial.
> 
> I can dream. :-)

Don't worry, tile blitting will be there (eventually)...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
