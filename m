From: James Simmons <jsimmons@infradead.org>
Subject: Re: clipping
Date: Thu, 9 Jan 2003 21:24:04 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0301092122450.5660-100000@phoenix.infradead.org>
References: <1042043066.982.118.camel@localhost.localdomain>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from phoenix.mvhi.com ([195.224.96.167] helo=phoenix.infradead.org)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 18WkAL-00049l-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 09 Jan 2003 13:24:41 -0800
In-Reply-To: <1042043066.982.118.camel@localhost.localdomain>
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
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>


> So perhaps, a function something like this:
> 
> void fb_clip(struct fb_fillrect *region, struct fb_fillrect *clip);
> 
> This should not be difficult to implement, and I'll code it if everyone
> agrees.
 
I thought about this. Originally I did have this function but removed it.
WHat do you think Geert?

> The other option (which I don't like) is just to check the passed
> fb_var_screeninfo in the put_var ioctl against the current console
> window size.  But this is not foolproof as we will not be sure of the
> resulting window size _after_ the fb_set_var() call.

Yuck!!! The other way is better.



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
