From: James Simmons <jsimmons@infradead.org>
Subject: Re: rotation.
Date: Fri, 10 Jan 2003 19:42:59 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0301101940460.18287-100000@phoenix.infradead.org>
References: <1042171520.933.126.camel@localhost.localdomain>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from phoenix.infradead.org ([195.224.96.167])
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 18X541-0001bJ-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 10 Jan 2003 11:43:34 -0800
In-Reply-To: <1042171520.933.126.camel@localhost.localdomain>
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>


> > Yes. Hardware rotation shouldn't also not effect the way accel 
> > operatations are done.
>  
> The main difference is if the hardware supports rotation, fbcon will
> present it with "normal" data.  With the generic implementation, fbcon
> will present the driver with rotated data.
> 
> So we need a driver capabilities field either in fb_info or
> fb_fix_screeninfo.

We can just test if the rotation hook exist for the fbdev driver. No hook 
then use generic code in fbcon. Also we have a angle field in var so we 
can see if the user wants the data rotated.

> Not really.  We can dynamically rotate the fontdata using the default
> display->fontdata into another buffer.  I believe I have functions that
> do that in the patch I submitted.  (Sorry, I lost it when one of my
> drives crashed :-(.

I have that patch. It just has to be updated to the latest changes.



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
