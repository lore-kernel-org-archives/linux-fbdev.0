From: Antonino Daplas <adaplas@pol.net>
Subject: Re: fb_imageblit()
Date: 09 Jan 2003 19:44:22 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1042112591.1037.30.camel@localhost.localdomain>
References: <Pine.GSO.4.21.0301091038390.25052-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from willow.compass.com.ph ([202.70.96.38])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18WbI8-0005z7-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 09 Jan 2003 03:56:08 -0800
In-Reply-To: <Pine.GSO.4.21.0301091038390.25052-100000@vervain.sonytel.be>
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
Cc: James Simmons <jsimmons@infradead.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Thu, 2003-01-09 at 17:50, Geert Uytterhoeven wrote:
> On 9 Jan 2003, Antonino Daplas wrote:
> > On Wed, 2003-01-08 at 23:15, Geert Uytterhoeven wrote:
> > > > c. Read color information from pseudopalette if directcolor/truecolor. 
> > > 
> > > Hoever, pseudopalette has entries for the first 16 colors only!
> > > Hence you are limited to the 16 color for directcolor/truecolor modes.
> > 
> > That's why there's an fb_set_logo_directpalette(), for directcolor
> > visuals >= 24bpp, and fb_set_logo_truepalette(), for truecolor, in
> > fb_set_logo().  Basically, it temporarily replaces info->pseudo_palette
> > with one that has 256 entries to match linux_logo.  Logo drawing, using
> > cfb_imageblit() has always worked for me in directcolor and truecolor
> > modes.
> 
> I see a small inconsistency here, which may cause problems with some exotic
> hardware: info->pseudo_palette is always initialized by the fbdev driver itself
> (which knows the hardware), except for logo drawing, where it's done by the
> generic code in fbmem.
> 
> On virtually all hardware that will work fine. But on some hardware the exact
> pixel format cannot be represented by the {red,green,blue,transp} bitfields in
> fb_var_screeninfo.
> 
> E.g. the Amiga CyberVision64 card has a S3Trio64. Since Amigas are little
> endian and PCI is big endian, they swapped the data bus to simplify 256-color
> modes. However, this also means that 16-bit pixel values have to be swapped. So
> in depth 15, the pixel format is not ARRRRRGGGGGBBBBB, but GGGBBBBBARRRRRGG.
> This can be handled fine in cyberfb by setting up a byteswapped pseudo palette,
> but the fb_set_logo_{direct,true}palette() don't know about this. And of course
> user space doesn't know about this neither.
> 

This will be a problem only for DirectColor at >= 24 bpp.  At bpp's less
than that, linux_logo_16 will be used.

Another possible solution (in case it supports 24bpp) is to have 2
pseudo_palettes, one which is 16 entries long and public, and another
256-entries long and private.  Then if image.depth is < 24, it's safe to
use cfb_imageblit. Otherwise, it has to use it's own imageblit, one that
will use the private pseudo_palette.  The driver will have the
opportunity to build this because fb_set_cmap() is called for
directcolor modes >= 24bpp, and pseudocolor == 8bpp.

Hopefully, exotics such as this will not export their visuals as
truecolor or static pseudocolor because fb_set_cmap() will not be
called. Otherwise, we'll just make it mandatory to call fb_set_cmap()
for all visual modes requiring linux_logo.
  
> One possible solution is to extend the pseudo palette to 256+1 entries if the
> depth is at least 8. To save memory, we can still use a 16+1 entry pseudo
> palette if depth < 8, but then we have to move the cursor inversion value from
> index 16 to index -1.
> 

I believe the cursor inversion value is unused anymore(?), since
fbcon_revc is gone. It has been replaced by the new cursor API which
allows the driver more intimate handling of the cursor.

Tony



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
