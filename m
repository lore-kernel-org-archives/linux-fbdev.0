From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [PATCH] interlaced packed pixels
Date: Fri, 4 Apr 2003 16:39:31 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030404163931.E964@flint.arm.linux.org.uk>
References: <Pine.GSO.4.21.0304041310440.1720-100000@vervain.sonytel.be>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from caramon.arm.linux.org.uk ([212.18.232.186])
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 191TII-0003LI-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 04 Apr 2003 07:39:54 -0800
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0304041310440.1720-100000@vervain.sonytel.be>; from geert@linux-m68k.org on Fri, Apr 04, 2003 at 01:17:15PM +0200
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
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Development <linux-kernel@vger.kernel.org>

On Fri, Apr 04, 2003 at 01:17:15PM +0200, Geert Uytterhoeven wrote:
> I'd like to introduce a new frame buffer type to accommodate packed pixel frame
> buffers that store the even and odd fields separately. This is typically used
> in graphics hardware for TV output (e.g. set-top boxes).

While we're on the subject of framebuffers, one area which needs to be
looked into is the pixel layout for all of:

- little endian byte, little endian pixel
	1bpp: word 0 bit 31..0 = pixel 31..0)
	16bpp: word 0 bit 31..0 = pixel1 bits 15..0 pixel0 bits 15..0) 
- little endian byte, big endian pixel
	1bpp: word 0 bit 31..0 = pixel 24..31, 16..23, 8..15, 0..7)
	16bpp: word 0 bit 31..0 = pixel1 bits 15..0 pixel0 bits 15..0) 
- big endian byte, big endian pixel
	1bpp: word 0 bit 31..0 = pixel 0..31)
	16bpp: word 0 bit 31..0 = pixel0 bits 15..0 pixel1 bits 15..0) 

We currently do not support all these combinations, and so far I haven't
looked into it.  It is on my (great long) to do list.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html



-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
