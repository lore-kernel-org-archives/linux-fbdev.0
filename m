From: Antonino Daplas <adaplas@pol.net>
Subject: Re: Re: FBdev updates.
Date: 06 Mar 2003 09:18:29 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1046913418.1206.189.camel@localhost.localdomain>
References: <Pine.LNX.4.44.0303052023110.27760-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from pine.compass.com.ph ([202.70.96.37])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18qk0Z-0007FE-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 05 Mar 2003 17:17:15 -0800
In-Reply-To: <Pine.LNX.4.44.0303052023110.27760-100000@phoenix.infradead.org>
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
Cc: Petr Vandrovec <vandrove@vc.cvut.cz>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Thu, 2003-03-06 at 04:23, James Simmons wrote:
> 
> > >   And one (or two...) generic questions: why is not pseudo_palette
> > > u32* pseudo_palette, or even directly u32 pseudo_palette[17] ?
> > 
> > Yes, all drivers should treat the pseudo_palette as u32* anyway, so why
> > not change pseudo-palette from void* to u32*?
> 
> See other email.
> 
> > > And why we do not fill this pseudo_palette with
> > > i * 0x01010101U for 8bpp pseudocolor and i * 0x11111111U for 4bpp
> > > pseudocolor? This allowed me to remove couple of switches and tests
> > > from acceleration fastpaths (and from cfb_imageblit and cfb_fillrect,
> > > but I did not changed these two in my benchmarks below).
> > 
> > I also agree for a different reason.  Cards with unconventional formats
> > (such as monochrome at 8 bpp - 0 for black , 0xff for white) will not
> > work with the current code.
> 
> Isn't that the job of setcolreg?
> 
setcolreg does that for directcolor and truecolor modes, because they're
the only ones that uses the pseudo_palette.  See all driver codes, the
pseudo_palette is never initialized if in pseudo_color.

The purpose of the pseudo_palette is to enable to write pixels to the
framebuffer without knowing the color format at all.  So, if you have
monochrome, then black is 0 and white is 1.  But for monochrome 8bpp,
black is 0 and white is 0xff. 

fbcon will send 0's and 1's, thus 0 and 1 will be written to the
framebuffer.  If the drawing functions referred to the pseudo_palette,
whatever the visual format, then 0 and 0xff will be written, as it
should be.

Tony
> 
> 
> -------------------------------------------------------
> This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
> for complex code. Debugging C/C++ programs can leave you feeling lost and 
> disoriented. TotalView can help you find your way. Available on major UNIX 
> and Linux platforms. Try it free. www.etnus.com
> _______________________________________________
> Linux-fbdev-devel mailing list
> Linux-fbdev-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel




-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
