From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: Fb rotation 2.6.x
Date: Wed, 16 Mar 2005 04:50:48 +0800
Message-ID: <200503160450.48352.adaplas@hotpop.com>
References: <20050315085827.56051.qmail@web53603.mail.yahoo.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DBJ0A-00012u-RB
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 15 Mar 2005 12:50:54 -0800
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DBJ09-0001cG-1u
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 15 Mar 2005 12:50:54 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id AE847F9C8A3
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 15 Mar 2005 20:50:40 +0000 (UTC)
In-Reply-To: <20050315085827.56051.qmail@web53603.mail.yahoo.com>
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
To: linux-fbdev-devel@lists.sourceforge.net, Komal Shah <komal_shah802003@yahoo.com>

On Tuesday 15 March 2005 16:58, Komal Shah wrote:
> Hi All,
>
> We have added the code for hardware rotation in the
> framebuffer driver for omap242x processor from TI
> [2.6.x kernel].
>
> It has been reported to work on 2.4.x.
>
> But when I had made it changed for 2.6.x follwoing
> behaviour is seen:
>
> 1. When I rotate the framebuffer ( Linux logo screen)
> by 180 degree then it shows only Linux logo image for
> a second only and then it disappears.
>
> 2. Whereas while doing in 90 degree rotation, it shows
> the black square of Linux logo size on the 270 degree
> rotation position.
>
> The reasons we found are as below:
>
> -----------------snip-----------------
> That is because in 2.4, the fb_display's var structure
> is updated by the driver - which we do consistently.
> In 2.6, on the other hand, the fb_info's var structure
> is
> updated by the driver, and all the fb_displays are
> updated by either fb_mem or fb_con - which I think is
> not done correctly. Also the set_par function is
> called so many times - I don't understand why.

Sometimes people use multiple fbdevs mapped to different consoles, so a
set_par() is called for each fb_info mapped for each console.

I guess I can add an "already_initialized" flag so fbcon doesn't do multiple
set_pars().

>
> What is happening is that, first, fb_info's var
> structure is updated, which rotates the display. But
> this var does not get passed to the current
> fb_display's var. Then when the fbcon_switch function
> is called, the current fb_display's var settings are
> affected - which 'unrotates' the display.

What fields do you use in var that is important for rotation? Is it
var->rotate? If that is the case, just add those fields in struct display in
fbcon.h, and update the functions display_to_var() and var_to_display() in
fbcon.c to also include the said fields.

Tony




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
