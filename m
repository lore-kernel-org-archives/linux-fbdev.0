From: James Simmons <jsimmons@infradead.org>
Subject: Re: fb_imageblit()
Date: Fri, 10 Jan 2003 18:47:26 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0301101843530.18287-100000@phoenix.infradead.org>
References: <1042112591.1037.30.camel@localhost.localdomain>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from phoenix.mvhi.com ([195.224.96.167] helo=phoenix.infradead.org)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 18X4CL-0008Sx-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 10 Jan 2003 10:48:05 -0800
In-Reply-To: <1042112591.1037.30.camel@localhost.localdomain>
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


> Hopefully, exotics such as this will not export their visuals as
> truecolor or static pseudocolor because fb_set_cmap() will not be
> called. Otherwise, we'll just make it mandatory to call fb_set_cmap()
> for all visual modes requiring linux_logo.

Personally I think the best solution is to always call fb_set_cmap. Also 
the other issue is the 256 versus 16 length of pseudo_palette. We might 
have to have pseudo_palette either at the highest value, usually 256, or 
make pseudo_palette dynamic and change its size if the color depth 
changes.

> I believe the cursor inversion value is unused anymore(?), since
> fbcon_revc is gone. It has been replaced by the new cursor API which
> allows the driver more intimate handling of the cursor.

Correct. We don't need the 17th value now :-)



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
