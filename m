From: Thomas Molina <tmolina@cox.net>
Subject: Re: Much better framebuffer fixes.
Date: Thu, 27 Mar 2003 09:58:12 -0600 (CST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0303270949210.947-100000@localhost.localdomain>
References: <3E82CB28.8020001@aitel.hist.no>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from ip68-13-105-80.om.om.cox.net ([68.13.105.80] helo=localhost.localdomain)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 18yZli-0001jz-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 27 Mar 2003 07:58:19 -0800
In-Reply-To: <3E82CB28.8020001@aitel.hist.no>
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
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: James Simmons <jsimmons@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Thu, 27 Mar 2003, Helge Hafting wrote:

> James Simmons wrote:
> > Okay. Here are more framebuffer fixes. Please try these fixes and let me 
> > know how they work out for you.
> > 
> 
> The cursor line on radeonfb now is solid, instead of the broken line
> in 2.5.66.  It is still impossible to set the resolution.
> 
> The lilo approach:
> append="video=radeonfb:1280x1024-24@60"
> This seems to do nothing.  I get the same low resolution as
> plain 2.5.66, which looks bad as it don't match the flat screen resolution.

The framebuffer behaviour is back to "normal".  I'm not having the 
resolution problems, but I'm not using the same parameters.  My append 
line simply says vga=792.

Any idea of what will go to Linus and when it might make it into mainline?



-------------------------------------------------------
This SF.net email is sponsored by:
The Definitive IT and Networking Event. Be There!
NetWorld+Interop Las Vegas 2003 -- Register today!
http://ads.sourceforge.net/cgi-bin/redirect.pl?keyn0001en
