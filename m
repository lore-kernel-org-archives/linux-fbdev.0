From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: Patch to add mode setting to sysfs
Date: Sat, 19 Feb 2005 05:59:02 +0800
Message-ID: <200502190559.07162.adaplas@hotpop.com>
References: <9e4733910502161430ff1dad1@mail.gmail.com> <200502181542.50162.adaplas@hotpop.com> <9e473391050218084629ad0935@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D2GAZ-0006P5-DK
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 18 Feb 2005 14:00:15 -0800
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1D2GAX-0006hZ-TD
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 18 Feb 2005 14:00:15 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 08D46E6FC91
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 18 Feb 2005 21:59:14 +0000 (UTC)
In-Reply-To: <9e473391050218084629ad0935@mail.gmail.com>
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
To: Jon Smirl <jonsmirl@gmail.com>, adaplas@pol.net
Cc: linux-fbdev-devel@lists.sourceforge.net, James Simmons <jsimmons@www.infradead.org>

On Saturday 19 February 2005 00:46, Jon Smirl wrote:
> On Fri, 18 Feb 2005 15:42:50 +0800, Antonino A. Daplas
>
> <adaplas@hotpop.com> wrote:
> > On Friday 18 February 2005 15:27, Jon Smirl wrote:
> > > Next version of sysfs patch. Fills out more attributes. Feel free to
> > > add code for missing implementations. Modifies fbcon to copy mode
> > > structure instead of taking a reference to it. Modular fbdev is
> > > separate patch. Ultimately we should be able to eliminate the IOCTL
> > > code from fb_core and move it to a compatibility module.
> >
> > Okay, I think I can start coding starting from this patch.
>
> Do you want to take over the sysfs support? If so, I will make some
> changes to the radeonfb driver that I need. That will keep up from
> conflicting.

Actually, I plan to do the fbcon part only, capturing the event. I'll use
yours as the test bed, but you and James will have to agree on the best way
to add sysfs support to the fb core.

Tony




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
