From: James Simmons <jsimmons@infradead.org>
Subject: Re: [RFC][PATCH][FBDEV]: Setting fbcon's windows
 size
Date: Fri, 10 Jan 2003 18:18:24 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0301092140020.5660-100000@phoenix.infradead.org>
References: <1042000922.1049.101.camel@localhost.localdomain>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from phoenix.infradead.org ([195.224.96.167])
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 18X3kE-000388-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 10 Jan 2003 10:19:03 -0800
In-Reply-To: <1042000922.1049.101.camel@localhost.localdomain>
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel List <linux-kernel@vger.kernel.org>


> Here's an improved GTF implementation.  I was a bit delayed because I
> was trying to find a way to do square roots without using floating
> point.  The diff is against linux-2.5.54 + your latest fbdev.diff.

Applied. 

> but is more or less usable.  Tested with i810fb and rivafb. (For rivafb,
> I have to use a hacked version. The latest one does not work for the
> riva128).

What hack did you do? That is based on the latest riva driver from 2.4.2X.
 
> BTW, I downloaded the source code of read-edid, and it seems that the
> following monitor limits are parsable from the EDID block: HorizSync,
> VertRefresh, DotClock, and GTF capability. We may change info->monspecs
> to match that. Also, the EDID contains a list of supported modes, but
> there's only 4 of them(?).  

I figured monspec would have to be improved. I'm looking into the EDID 
info right now. I'm also looking at read-edid. Next I need to figure out 
how to use i2c to get this info.





-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
