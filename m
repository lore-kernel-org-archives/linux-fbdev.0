From: Antonino Daplas <adaplas@pol.net>
Subject: Re: [PATCH] Interlace for rivafb driver
Date: 31 Jan 2003 06:59:51 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1043966131.1041.5.camel@localhost.localdomain>
References: <Pine.LNX.4.44.0301301849220.8852-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from willow.compass.com.ph ([202.70.96.38])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18eNtM-0006OI-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 30 Jan 2003 15:14:44 -0800
In-Reply-To: <Pine.LNX.4.44.0301301849220.8852-100000@phoenix.infradead.org>
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
To: James Simmons <jsimmons@infradead.org>
Cc: Fredrik Noring <noring@nocrew.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Fri, 2003-01-31 at 03:34, James Simmons wrote:
> 
> > >    To Tony. I applied your patches as well. The only patch I didn't was 
> > > the DIRECTCOLOR patch. The X server freaked out for my card when the video 
> > > mode was in a DIRECTCOLOR state.
> > > 
> > 
> > Yes I'm not sure about this too.  Also the patch I submitted is untested
> > for RGB565, tested only for RGB555 and RGB8888.  So, does X work for
> > rivafb?  It does not work in my hardware unless I add the directcolor
> > patch.
> 
> I applied your direct color patch. The X server has issues without it as 
> well. For some reason the screen is cut in half and the colors are wrong.
> Even when I leave X. The only solution is to switch back to 8 bpp mode.
> 

I get this too.  For some reason, X fails to dynamically set rivafb to
the mode it wants to use.  So, I have to use fbset first to set rivafb
to the mode and visual X is going to use.  After doing this, I get
XFBdev working nicely (at Depth 15).

I have no problems with DirectFB though.

Tony



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
