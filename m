From: James Simmons <jsimmons@www.infradead.org>
Subject: Re: Re: Radeon framebuffer weirdness in -mm2
Date: Fri, 21 Jan 2005 00:24:43 +0000 (GMT)
Message-ID: <Pine.LNX.4.56.0501210024010.14061@pentafluge.infradead.org>
References: <20050120232122.GF3867@waste.org>  <20050120153921.11d7c4fa.akpm@osdl.org>
  <20050120234844.GF12076@waste.org> <1106265837.18397.19.camel@gaston>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Crmbc-0000gH-QX
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 20 Jan 2005 16:24:52 -0800
Received: from pentafluge.infradead.org ([213.146.154.40])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1Crmbb-0000wy-0s
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 20 Jan 2005 16:24:52 -0800
In-Reply-To: <1106265837.18397.19.camel@gaston>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>
Cc: Matt Mackall <mpm@selenic.com>, Andrew Morton <akpm@osdl.org>, Linux Kernel list <linux-kernel@vger.kernel.org>


> > > > I'm seeing radeonfb on my ThinkPad T30 go weird on reboot (lots of
> > > > horizontal lines) and require powercycling to fix. Worked fine with 2.6.10.
> > > 
> > > Which radeon driver? CONFIG_FB_RADEON_OLD or CONFIG_FB_RADEON?
> > 
> > FB_RADEON.
> > 
> > > (cc Ben, who is the likely cuprit ;)
> > 
> > Btw, ajoshi's address from MAINTAINERS is bouncing.
> 
> The file should be updated, I am the radeonfb maintainer now.

Speaking of. Should we nuke the old radeonfb driver?
 


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
