From: Antonino Daplas <adaplas@pol.net>
Subject: Re: [PATCH] Interlace for rivafb driver
Date: 30 Jan 2003 10:35:33 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1043893542.1052.130.camel@localhost.localdomain>
References: <Pine.LNX.4.44.0301281927590.12076-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from willow.compass.com.ph ([202.70.96.38])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18e4gh-0007EP-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 29 Jan 2003 18:44:29 -0800
In-Reply-To: <Pine.LNX.4.44.0301281927590.12076-100000@phoenix.infradead.org>
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

On Wed, 2003-01-29 at 03:29, James Simmons wrote:
> On 26 Jan 2003, Fredrik Noring wrote:
> 
> > Attached patch implements interlace for the rivafb driver and
> > the hardware that supports it (Riva 128, TNT, TNT2, some GeForce 
> > cards and possibly others).
> > 
> > It's a patch against 2.4.21-pre2 (with polarity and sync patches)
> > but it should fit with 2.5.x too skipping riva_hw.c and riva_hw.h 
> > which already are adopted from XFree86.
> 
> Applied. 
> 
> 
> P.S
>    To Tony. I applied your patches as well. The only patch I didn't was 
> the DIRECTCOLOR patch. The X server freaked out for my card when the video 
> mode was in a DIRECTCOLOR state.
> 

Yes I'm not sure about this too.  Also the patch I submitted is untested
for RGB565, tested only for RGB555 and RGB8888.  So, does X work for
rivafb?  It does not work in my hardware unless I add the directcolor
patch.

Tony





-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
