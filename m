From: Antonino Daplas <adaplas@pol.net>
Subject: Re: fb_imageblit()
Date: 09 Jan 2003 00:25:13 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1042043058.982.115.camel@localhost.localdomain>
References: <Pine.GSO.4.21.0301081613510.21171-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from willow.compass.com.ph ([202.70.96.38])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18WJCU-0000Yh-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 08 Jan 2003 08:37:06 -0800
In-Reply-To: <Pine.GSO.4.21.0301081613510.21171-100000@vervain.sonytel.be>
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

On Wed, 2003-01-08 at 23:15, Geert Uytterhoeven wrote:
> > c. Read color information from pseudopalette if directcolor/truecolor. 
> 
> Hoever, pseudopalette has entries for the first 16 colors only!
> Hence you are limited to the 16 color for directcolor/truecolor modes.

That's why there's an fb_set_logo_directpalette(), for directcolor
visuals >= 24bpp, and fb_set_logo_truepalette(), for truecolor, in
fb_set_logo().  Basically, it temporarily replaces info->pseudo_palette
with one that has 256 entries to match linux_logo.  Logo drawing, using
cfb_imageblit() has always worked for me in directcolor and truecolor
modes.

Tony




-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
