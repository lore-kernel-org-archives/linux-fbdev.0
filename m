From: James Simmons <jsimmons@infradead.org>
Subject: Re: [PATCH] Interlace for rivafb driver
Date: Thu, 30 Jan 2003 19:34:23 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0301301849220.8852-100000@phoenix.infradead.org>
References: <1043893542.1052.130.camel@localhost.localdomain>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from phoenix.infradead.org ([195.224.96.167])
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 18eKSu-0005yO-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 30 Jan 2003 11:35:13 -0800
In-Reply-To: <1043893542.1052.130.camel@localhost.localdomain>
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
Cc: Fredrik Noring <noring@nocrew.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> >    To Tony. I applied your patches as well. The only patch I didn't was 
> > the DIRECTCOLOR patch. The X server freaked out for my card when the video 
> > mode was in a DIRECTCOLOR state.
> > 
> 
> Yes I'm not sure about this too.  Also the patch I submitted is untested
> for RGB565, tested only for RGB555 and RGB8888.  So, does X work for
> rivafb?  It does not work in my hardware unless I add the directcolor
> patch.

I applied your direct color patch. The X server has issues without it as 
well. For some reason the screen is cut in half and the colors are wrong.
Even when I leave X. The only solution is to switch back to 8 bpp mode.



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
