From: Antonino Daplas <adaplas@pol.net>
Subject: Re: [Patch 2] Console Rotation
Date: 09 Sep 2002 23:06:46 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1031583916.736.30.camel@daplas>
References: <Pine.GSO.4.21.0209091634380.12337-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from [203.167.79.9] (helo=willow.compass.com.ph)
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17oQ75-0006xe-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 09 Sep 2002 08:06:07 -0700
In-Reply-To: <Pine.GSO.4.21.0209091634380.12337-100000@vervain.sonytel.be>
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
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: fbdev <linux-fbdev-devel@lists.sourceforge.net>

On Mon, 2002-09-09 at 22:35, Geert Uytterhoeven wrote:
> On 9 Sep 2002, Antonino Daplas wrote:
> > cfbcopyarea.c is just a 'copy 'n paste' of Geert's version I leached
> > from fbutils (I hope this is okay with you, Geert :)  The only changes
> > are using FB_WRITEL and FB_READL where appropriate. 
> 
> Of course (actually that was my intention ;-)
Thanks.

> 
> Did you measure any noticeable differences (performance-wise) with the old
> routines?
> 
Yes, but not by much, something like less than a second.  But I haven't
really done a test where the primary operation is copyarea...  Will this
be affected by the the setting of display->scrollmode?  I use
SCROLL_YREDRAW.

> BTW, expect a fillrect() for arbitrary bitdepths soon...
This is good :)  The one I included should do that too, but it is
terribly inefficient.  

Tony



-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
