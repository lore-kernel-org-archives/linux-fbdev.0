From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Subject: Re: Re: FBdev updates.
Date: Wed, 5 Mar 2003 21:31:05 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <11EC6AF51A4E@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Content-Transfer-Encoding: 7BIT
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mailgw.cvut.cz ([147.32.3.235])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18qfY1-0006wL-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 05 Mar 2003 12:31:29 -0800
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: James Simmons <jsimmons@infradead.org>
Cc: Antonino Daplas <adaplas@pol.net>, linux-kernel@vger.kernel.org, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On  5 Mar 03 at 20:22, James Simmons wrote:
>  
> >   And one (or two...) generic questions: why is not pseudo_palette
> > u32* pseudo_palette, or even directly u32 pseudo_palette[17] ?
> 
> pseudo_palette was originally designed to be a pointer to some kind of 
> data for color register programming. For example many PPC graphics cards 
> have a color register region. Now you could have that point to 
> pseudo_palette.  Note pseudo_palette is only visiable in fbmem.c for the 
> logo drawing code. Personally I liek to see that hidden.

cfbfillrect? cfbimageblit? Both use pseudo_palette, and both convert
it to u32*.
 
> > And why we do not fill this pseudo_palette with
> > i * 0x01010101U for 8bpp pseudocolor and i * 0x11111111U for 4bpp
> > pseudocolor? This allowed me to remove couple of switches and tests
> > from acceleration fastpaths (and from cfb_imageblit and cfb_fillrect,
> > but I did not changed these two in my benchmarks below).
> 
> ??? Does your accel engine require these kinds of values?

Yes. It is 32bit engine, and so it wants 32bit value. And even if 
not, code doing

if (p->fix.visual == FB_VISUAL_TRUECOLOR ||
    p->fix.visual == FB_VISUAL_DIRECTCOLOR)
      fg = p->pseudo_palette[rect->color];
else
      fg = rect->color;

is horrible. Two conditional jumps on each rectangle. If you'll do
always lookup through pseudo_palette, not only that you get rid of
these jumps, you can also remove calls to pixel_to_pat32 (and accompanying
tables & lookups), as you do this expansion at set_var time,
instead of at blit/clear time.
                                            Best regards,
                                                Petr Vandrovec
                                                vandrove@vc.cvut.cz
                                                



-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
