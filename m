From: Richard Smith <rsmith@bitworks.com>
Subject: Re: Generic VESA framebuffer driver and Video
 card BOOT?
Date: Mon, 18 Oct 2004 19:18:09 -0500
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <41745D41.50306@bitworks.com>
References: <200410160946.32644.adaplas@hotpop.com>	 <4173B865.26539.117B09BD@localhost> <417428F2.2050402@bitworks.com>	 <9e47339104101814166bf4cfe5@mail.gmail.com>	 <41744505.4080507@bitworks.com> <9e47339104101816282ba385d2@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CJhhj-0000vU-D0
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 18 Oct 2004 17:18:19 -0700
Received: from [69.4.201.55] (helo=bitworks.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CJhhg-0005wV-Ij
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 18 Oct 2004 17:18:19 -0700
In-Reply-To: <9e47339104101816282ba385d2@mail.gmail.com>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: linux-fbdev-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org

Jon Smirl wrote:

> LinuxBIOS can do things the real kernel probably shouldn't be doing.
> For example on an x86 it can find the expansion ROMs and post all of
 > the video cards. On non-x86 it can embed emu86 and run the ROMs that
 > way. And for a few cards that we have the docs on it can directly
 > initialize them.  These options should be selected when LinuxBIOS is
 > built for the hardware.

Well we see it the other way around.  We want to do a little as possible 
and let Linux handle as much as possible.  Otherwise your bios turns 
into a mini-OS.  The path is littered with dead projects that went that 
route.  Keeping current with driver support kills them.

> But getting Int10 video up and running does not mean that the kernel
> framebuffer/DRM subsystem has to be up and running. Int10 or Open

Agreed.

> it, then it is the hardware manufacturer responsibility to acquire
> enough documentation from the graphics vendor so that a boot display
> can be implemented.

If only it were that easy. *grin*

Ok well I really don't want to start a off-topic argument here so I'll 
shut up after this. Especially since I'm not really argueing anything 
that hasn't already be thrashed over many times.

I and many others would like to see a unified int10 solution that could 
be used by as many projects that need it rather than the fragmented 
setup we have now.  The kernel proper may or may not be one of those.

-- 
Richard A. Smith




-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
