From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: fb_imageblit semantic
Date: Mon, 17 Mar 2003 15:46:59 +0100 (MET)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0303171545040.17453-100000@vervain.sonytel.be>
References: <1047911032.2684.79.camel@localhost.localdomain>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail2.sonytel.be ([195.0.45.172] helo=mail.sonytel.be)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18uvuz-0002Si-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 17 Mar 2003 06:48:50 -0800
In-Reply-To: <1047911032.2684.79.camel@localhost.localdomain>
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
Cc: Petr Vandrovec <vandrove@vc.cvut.cz>, James Simmons <jsimmons@infradead.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On 17 Mar 2003, Antonino Daplas wrote:
> On Mon, 2003-03-17 at 21:47, Geert Uytterhoeven wrote:
> > BTW, I just realized there's no need to distinguish between monochrome copy and
> > monochrome-to-color expansion. The monochrome logo code just has to write the
> > correct values to fb_image.[fb]gcolor. I.e. all zeroes or all ones (number of
> > bits = var.bits_per_pixel, so it works for 8-bit monochrome, too).
> > 
> 
> I remember mentioning this to you before, and you said that there might
> be rare cases that fgcolor can be equal to bgcolor.  However, using -1
> instead for bg_color/fg_color may work, at least for the current setup
> and only for monochrome, (except perhaps 32-bit monochrome, if there is
> such a thing)

No, you wanted to distinguish between monochrome expansion and color copy by
setting fb_image.[fb]gcolor to -1.

> I still prefer splitting fb_imageblit() into two though, and still keep
> image->depth for logo drawing only, to allow for future expansion.

OK.

> > > Do we still use the LUT?  
> > 
> > Yes. An alternative is to enlarge the pseudo palette to 256 entries (if there
> 
> Yes.  Which also means logo drawing will also work for quirky drivers,
> and the upper layer will be finally totally independent of the low level
> drivers.
> 
> > are enough number of colors). But since imageblit is done for the logo only,
> > doing the transform from LUT index to pixel value in imageblit is OK, I think.
> > 
> 
> Yes, I also prefer referring to the LUT whatever the format even for
> character drawing.  I don't expect any noticeable performance penalty
> except for logo drawing.  The way it's currently done is because,
> looking at all drivers, not one fills up the pseudo_palette when bpp <=
> 8.

There are some, that have RGB332 truecolor.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds



-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
