From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH][FBDEV]: fb_putcs() and fb_setfont()
 methods
Date: Thu, 9 Jan 2003 21:54:14 +0100 (MET)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0301092153150.8130-100000@vervain.sonytel.be>
References: <Pine.LNX.4.44.0301090034020.4976-100000@phoenix.infradead.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail2.sonytel.be ([195.0.45.172] helo=mail.sonytel.be)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18Wji3-00079L-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 09 Jan 2003 12:55:27 -0800
In-Reply-To: <Pine.LNX.4.44.0301090034020.4976-100000@phoenix.infradead.org>
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
Cc: Antonino Daplas <adaplas@pol.net>, Petr Vandrovec <vandrove@vc.cvut.cz>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel List <linux-kernel@vger.kernel.org>, davidm@redhat.com

On Thu, 9 Jan 2003, James Simmons wrote:
> > :-) I did not want prolong the discussion, but...
> > 
> > Geert is correct that the functions are generic. The fb_putcs() and
> > fb_setfont() can be compared to Tile blitting.  Tile blitting is a
> > common operation in some games such as Warcraft, Starcraft, and most
> > RPG's. I'm think there is Tile Blitting support in DirectFB.
> > 
> > In a tile-based game, the basic unit is a Tile which is just a bitmap
> > with a predefined width and height. The game has several tiles stored in
> > memory each with it's own unique id.  To draw the background/layer, a
> > TileMap is constructed which is basically another array.  Its format is
> > something like this -  TileMap[x] = y which means draw Tile y at screen
> > position x.
> > 
> > In the fbcon perspective, we can think of each character as a Tile, and
> > fontdata as the collection of tiles. fb_char.data is basically a
> > TileMap.  Of course, tile blitting in games is more complicated than
> > this, since games have multiple layers for the background, so layer
> > position, transparency, etc has to be considered.
> > 
> > So maybe if we can rename fb_putcs() to fb_tileblit(), fb_setfont() to
> > fb_loadtiles(), struct fb_chars to struct fb_tilemap and struct
> > fb_fontdata to struct fb_tiledata, maybe it will be more acceptable?
> > 
> > It can be even be expanded by including fb_tiledata.depth
> > fb_tiledata.cmap so we can support multi-colored tiled blitting.
> 
> This I have no problem with. I'm willing to accept this. As long as data 
> from the console layer is not touched. As for loadtiles one thing I like 
> to address is memory allocation. It probable is good idea to do things 
> like place the tile data in buffers allocated by pci_alloc_consistent.
> The other fear is it will only support so many tiles. 

I think it's best to let the driver allocate it. That way the driver can put it
where it's best suited. pci_alloc_consistent() is meant for PCI only.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
