From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: Default timings in vga16fb driver
Date: Thu, 25 Nov 2004 00:16:23 +0800
Message-ID: <200411250016.25813.adaplas@hotpop.com>
References: <41A36DA5.8090200@fujitsu-siemens.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CWzpu-0003ta-85
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 24 Nov 2004 08:17:42 -0800
Received: from smtp-out.hotpop.com ([38.113.3.71])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CWzpt-0000mW-9d
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 24 Nov 2004 08:17:42 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 987CB11EC74B
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 24 Nov 2004 16:16:30 +0000 (UTC)
In-Reply-To: <41A36DA5.8090200@fujitsu-siemens.com>
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
To: linux-fbdev-devel@lists.sourceforge.net, Martin Wilck <martin.wilck@fujitsu-siemens.com>

On Wednesday 24 November 2004 01:04, Martin Wilck wrote:
> Hello,
>
> I am wondering about the standard mode timings for the 640x480@60 mode
> in vga16fb driver (vga16fb_defined):
>
> 	.pixclock	= 39721,
> 	.left_margin	= 48,
> 	.right_margin	= 16,
> 	.upper_margin	= 39,
> 	.lower_margin	= 8,
> 	.hsync_len 	= 96,
> 	.vsync_len	= 2,
> 	.vmode		= FB_VMODE_NONINTERLACED,
>
> IMO this corresponds to a total screen height of 529 which is different
> from the value 525 which is normally used (eg in X Windows). What is the
> reason for this? Is it possible that the value for "upper_margin" should

Possibly, because nobody really complained that the modeline is slightly
off.  Most users have variable sync displays and should have no problem
display a slightly off modeline.

>
> be 35 rather than 39?
> I am asking because we have encountered a video device that obviously
> has problems displaying the standard mode of the vga16fb driver.
>

Did the device work correctly after changing the modeline?

> More detail:
>
> Unless I'm  mistaken, the above translates into an XFree86 modeline
>    ModeLine "640x480" 25.175 640 656 752 800 480 488 490 529

Yes, the above does give a slightly off vert refresh rate of 59.49
(800*529)/25175000

>
> The standard XFree86 modeline for this mode, however, looks like this:
> (same in drivers/video/modedb.c)
>    ModeLine "640x480" 25.175 640 664 760 800 480 491 493 525

This one gives a refresh rate of 59.94 which is the closest we can get to a
60 Hz refresh. 

>
> The description at http://www.epanorama.net/documents/pc/vga_timing.html.
> would suggest:
>    ModeLine "640x480" 25.175 640 656 752 800 480 490 492 525

And this one too.

>
> I apologize if I'm overlooking something.

I don't think you overlooked anything. The default modeline of vga16fb
should be corrected.

Tony




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
