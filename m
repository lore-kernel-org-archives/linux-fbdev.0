From: Antonino Daplas <adaplas@pol.net>
Subject: Re: fb_imageblit semantic
Date: 17 Mar 2003 22:24:31 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1047911032.2684.79.camel@localhost.localdomain>
References: <Pine.GSO.4.21.0303171436170.17453-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from pine.compass.com.ph ([202.70.96.37])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18uvax-00051V-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 17 Mar 2003 06:28:07 -0800
In-Reply-To: <Pine.GSO.4.21.0303171436170.17453-100000@vervain.sonytel.be>
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
Cc: Petr Vandrovec <vandrove@vc.cvut.cz>, James Simmons <jsimmons@infradead.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Mon, 2003-03-17 at 21:47, Geert Uytterhoeven wrote:
>
> IMHO always using an image depth of 8 is fine. That's a nice trade off between
> genericity and easy access of image data.
> 
> Except for monochrome, there I prefer a depth of 1, since doing 1->8 and 8->1
> in a row is a bit too wasteful.
> 

An exception to the rule :-)  Well, I guess if it will significantly
benefit monochrome drivers...

> BTW, I just realized there's no need to distinguish between monochrome copy and
> monochrome-to-color expansion. The monochrome logo code just has to write the
> correct values to fb_image.[fb]gcolor. I.e. all zeroes or all ones (number of
> bits = var.bits_per_pixel, so it works for 8-bit monochrome, too).
> 

I remember mentioning this to you before, and you said that there might
be rare cases that fgcolor can be equal to bgcolor.  However, using -1
instead for bg_color/fg_color may work, at least for the current setup
and only for monochrome, (except perhaps 32-bit monochrome, if there is
such a thing)

I still prefer splitting fb_imageblit() into two though, and still keep
image->depth for logo drawing only, to allow for future expansion.
. 
> > Do we still use the LUT?  
> 
> Yes. An alternative is to enlarge the pseudo palette to 256 entries (if there

Yes.  Which also means logo drawing will also work for quirky drivers,
and the upper layer will be finally totally independent of the low level
drivers.

> are enough number of colors). But since imageblit is done for the logo only,
> doing the transform from LUT index to pixel value in imageblit is OK, I think.
> 

Yes, I also prefer referring to the LUT whatever the format even for
character drawing.  I don't expect any noticeable performance penalty
except for logo drawing.  The way it's currently done is because,
looking at all drivers, not one fills up the pseudo_palette when bpp <=
8.

Tony



-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
