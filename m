From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: Reworking sysfs attributes for fbdev
Date: Wed, 16 Mar 2005 04:27:04 +0800
Message-ID: <200503160427.04940.adaplas@hotpop.com>
References: <200503111331.41352.ajax@nwnk.net> <200503151449.59874.adaplas@hotpop.com> <Pine.LNX.4.62.0503150954500.30569@numbat.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DBIdP-00081H-GW
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 15 Mar 2005 12:27:23 -0800
Received: from smtp-out.hotpop.com ([38.113.3.71])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DBIdN-0007pL-PM
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 15 Mar 2005 12:27:23 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 0838314AE91A
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 15 Mar 2005 20:27:07 +0000 (UTC)
In-Reply-To: <Pine.LNX.4.62.0503150954500.30569@numbat.sonytel.be>
Content-Disposition: inline
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
Content-Type: text/plain; charset="us-ascii"
To: linux-fbdev-devel@lists.sourceforge.net, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Jon Smirl <jonsmirl@gmail.com>, dri-egl@lists.freedesktop.org

On Tuesday 15 March 2005 16:55, Geert Uytterhoeven wrote:
> On Tue, 15 Mar 2005, Antonino A. Daplas wrote:
> > On Tuesday 15 March 2005 11:43, Jon Smirl wrote:
> > > Some discussion on the dri-egl list points out that the new mode
> > > setting sysfs attributes for fbdev are too limited. Below is a
> > > proposal I made on the dri-egl list.
> > >
> > > To implement this for fbdev I need to know the right set of of
> > > attribute value pairs. Some obvious ones are:
> > >
> > > name=string
> > > width=number
> > > height=number
> > > depth=number
> > > refresh=number
> > > interlace= yes | no | double
> > > type = detailed|standard|vesa|user
> > > sync = horizonatal_high | vertical_high | external | composite |
> > > broadcast | green
> > > left=number
> > > right=number
> > > lower=number
> > > upper=number
> > > hsync=number
> > > vsync=number
> > > pixclock=number
> > >
> > > Right now fb0/modes is set by passing in an array of fb_videomode
> > > structs. To convert this to attribute value pair I needs the full set
> > > so that no info is lost.
> > >
> > > If the mode and depth are independent variables we can end up with a
> > > combo that exceeds monitor or hardware bandwidth. Would it be better
> > > to combine the depth into the modes list? or if you try to set a
> >
> > We can do that, vesa's mode id's are like that. Although I prefer that
> > mode setting should be separated from the framebuffer format setting (ie,
> > depth), it's currently difficult to make this work safely the reason
> > being that not all check_var() functions can be relied upon.
>
> So should we separate into geometry, timings, visual (cfr. fbutils)?

Ideally, yes, but the problem with fbsysfs is that a regular user can change
the mode. Once we do the separation, combinations will exist that can be 
illegal.

ie echo 1024x768@60 > fb0/mode
   echo 32 > fb0/depth

The second set may not be compatible with the preceeding one.  Although
drivers do have a check_var(), I don't think all are robust enough to 
screen out illegal combinations.

Tony




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
