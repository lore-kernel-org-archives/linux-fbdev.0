From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Subject: Re: fb_imageblit semantic
Date: Mon, 17 Mar 2003 13:25:42 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1304562C67A8@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Content-Transfer-Encoding: 7BIT
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mailgw.cvut.cz ([147.32.3.235])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18utgp-0007ZG-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 17 Mar 2003 04:26:03 -0800
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
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: James Simmons <jsimmons@infradead.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, adaplas@pol.net

On 17 Mar 03 at 13:18, Geert Uytterhoeven wrote:
> 
> That depends... How do we draw the monochrome penguin? Using image->depth is 1
> or 8? The latter (current method) is slower, since we need to expand the
> monochrome logo to 8-bit first, and (usually) compress it to 1-bit in the fbdev
> driver afterwards.

As far as I can see, it gets monochromatic logo and converts it to
8bpp format ;-) (fb_set_logo, needs_logo = 1 or ~1) And then imageblit
converts it back to 1bpp.
 
> And perhaps we may want to draw 32-bit ARGB images later?
> 
> So I see the following possible valid values for image->depth:
>   - 8 (logo with up to 256 colors and LUT)
>   - optional 1 (monochrome logo, if we don't want to expand?)
>   - optional 32 (ARGB image, dithering left to the driver?)

I still do not understand 'if we don't want to expand'. This forces too
much knowledge on upper layer, as far as I can tell.
                                                    Petr Vandrovec
                                                    



-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
