From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Subject: Re: [PATCH 1/3: FBDEV: VGA State Save/Restore module
Date: Wed, 4 Dec 2002 23:33:58 +0100
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <96665BC46B2@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: Antonino Daplas <adaplas@pol.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On  5 Dec 02 at 6:05, Antonino Daplas wrote:
> On Wed, 2002-12-04 at 23:41, Petr Vandrovec wrote:
> > On  4 Dec 02 at 22:26, Antonino Daplas wrote:
> [...]
> > And if my VGA documentation is correct, you are saving random
> > data into vga_text: first 8192 chars interleaved with
> > 8192 bytes of garbage, plus attributes from chars 8192-16383 interleaved
> > with 8192 bytes of garbage. 
> >
> Right, I'm not sure about this part too.  The docs say that this is true
> for EGA compatible hardware.  How about non-compliant hardware?  

Like non-VGA? Like CGA/MDA? I thought that non-VGA/non-EGA adapters are 
out of scope of this document ;-)
  
> > And if you are using standard hardware, then font data live only in
> > plane 2, plane 3 is unused on VGA hardware in text mode. I think that
> > you should either save whole 256KB of memory, without deeper understanding,
> > or you should just save FONT 0 (first 32*256 bytes from plane 2) if you

> Only if saving the first character map in plane 2.  Hardware can have as
> much as 8 character maps per plane, each 8K in size for 64K.  The same
> setup is true for plane 3 fonts.

How you select them? Mine doc says that font block 0 begins in plane 2
at offset 0, block 1 at offset 16KB, 2 at 32K, 3 at 48K, 4 at 8K, 5 at 24K,
6 at 40K, and last, 7th, at 56KB, and sequencer has two threebit fields...

> > want to save memory and you know that console was driven by vgacon in
> > text mode.
> To save memory, apps can explicitly choose what to save, but I don't
> want to go finer than that, ie. save character maps 2,3,5  of plane 2
> and 1,2,3 of plane 3.  The current way of saving the text mode map may
> be a bit wasteful, but better than being bitten by hardware that's
> non-EGA compliant.  

Look at vgacon. Uses font block 0,2,3 from plane 2 when built
without BROKEN_GRAPHICS_PROGRAMS, or 0,1 when built with 
BROKEN_GRAPHICS_PROGRAMS. So if you want just restore vgacon environment,
save only these 4 blocks (4*8K = 32K). Or you want to save whole
VGA memory, and then save whole 256KB, without tricks while saving
planes 0 & 1.
                                            Petr Vandrovec
                                            vandrove@vc.cvut.cz
                                            
