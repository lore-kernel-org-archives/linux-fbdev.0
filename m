From: James Simmons <jsimmons@infradead.org>
Subject: Re: Re: FBdev updates.
Date: Wed, 5 Mar 2003 20:23:45 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0303052023110.27760-100000@phoenix.infradead.org>
References: <1046727094.1279.27.camel@localhost.localdomain>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from carisma.slowglass.com ([195.224.96.167] helo=phoenix.infradead.org)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 18qfR7-0004an-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 05 Mar 2003 12:24:22 -0800
In-Reply-To: <1046727094.1279.27.camel@localhost.localdomain>
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
Cc: Petr Vandrovec <vandrove@vc.cvut.cz>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> >   And one (or two...) generic questions: why is not pseudo_palette
> > u32* pseudo_palette, or even directly u32 pseudo_palette[17] ?
> 
> Yes, all drivers should treat the pseudo_palette as u32* anyway, so why
> not change pseudo-palette from void* to u32*?

See other email.

> > And why we do not fill this pseudo_palette with
> > i * 0x01010101U for 8bpp pseudocolor and i * 0x11111111U for 4bpp
> > pseudocolor? This allowed me to remove couple of switches and tests
> > from acceleration fastpaths (and from cfb_imageblit and cfb_fillrect,
> > but I did not changed these two in my benchmarks below).
> 
> I also agree for a different reason.  Cards with unconventional formats
> (such as monochrome at 8 bpp - 0 for black , 0xff for white) will not
> work with the current code.

Isn't that the job of setcolreg?



-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
