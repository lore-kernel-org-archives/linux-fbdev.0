From: Antonino Daplas <adaplas@pol.net>
Subject: Re: bits_per_pixel query
Date: 09 Sep 2002 22:23:57 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1031580939.632.17.camel@daplas>
References: <20020908163936.31266.qmail@webmail30.rediffmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from [203.167.79.9] (helo=willow.compass.com.ph)
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17oPRa-0003sh-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 09 Sep 2002 07:23:14 -0700
In-Reply-To: <20020908163936.31266.qmail@webmail30.rediffmail.com>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Linux PPC <linuxppc@rediffmail.com>
Cc: fbdev <linux-fbdev-devel@lists.sourceforge.net>

On Mon, 2002-09-09 at 00:39, Linux PPC wrote: 

> 
> If the display is 8 bit, then it would require only
> a byte to represent the value of the pixel. If it were 24 bit, 
> then it would require 3 bytes, and so
> on. Is that right? What would happen, to the size required for the 
> buffer, if the display
> requires, say 12 bits per pixel, or 18 bits?
Just pad the pitch/line_length/stride of the buffer to the next byte
alignment your hardware is capable of.  It is acceptable to have excess
bits/bytes which theoretically your hardware will ignore. Then the
framebuffer size is line_length*yres_virtual. 
> 
> So, if I were to set all the bytes after screen_base
> uptil screen_base + (hres*vres*bits_per_pixel/8) to
> zeros, then I would get a black screen. Is that right?
> 
For static pseudocolor and truecolor, that is true, since 0 is hardwired
to black.  For pseudocolor and directcolor, that depends on how the
DAC/palette is loaded. In most cases, it will produce a black screen. 

Tony 





-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
