From: Antonino Daplas <adaplas@pol.net>
Subject: Re: Re: [PATCH]: image.depth fix to accomodate
	monochrome cards
Date: 11 Jan 2003 21:47:18 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1042292794.1389.91.camel@localhost.localdomain>
References: <Pine.GSO.4.21.0301111422040.18570-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from willow.compass.com.ph ([202.70.96.38])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18XM8j-0007DF-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 11 Jan 2003 05:57:33 -0800
In-Reply-To: <Pine.GSO.4.21.0301111422040.18570-100000@vervain.sonytel.be>
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
Cc: James Simmons <jsimmons@infradead.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Sat, 2003-01-11 at 21:24, Geert Uytterhoeven wrote:
> > 
> > Do you think this will work?  The only problem I can think of is a color
> > expansion request where both bg and fg is 0.
> 
> And that can happen, try <ESC>[31m<ESC>[41m to set both to red.
> 
> > Or to totally eliminate the above possibility, add an extra field in
> > struct fb_image to denote color expansion vs logo drawing.  Again, only
> > mono cards will need to do this test.
> 
> Ugh, why invent a new field if we can use an existing field? depth == 0 is
> invalid for image blitting anyway.
> 

No argument here.

Tony



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
