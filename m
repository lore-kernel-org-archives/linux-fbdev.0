From: Kevin Hilman <khilman@mvista.com>
Subject: Re: Use of 'reserved' fields in var_screeninfo
Date: Mon, 14 Nov 2005 11:46:31 -0800
Message-ID: <4378E997.50208@mvista.com>
References: <4378E2CB.3080902@mvista.com> <Pine.LNX.4.62.0511142029340.15023@numbat.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EbkHi-0002O1-VJ
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 14 Nov 2005 11:46:34 -0800
Received: from gateway-1237.mvista.com ([12.44.186.158] helo=hermes.mvista.com)
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EbkHh-0003vM-SV
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 14 Nov 2005 11:46:35 -0800
Received: from [127.0.0.1] (godzilla.mvista.com [10.0.0.2])
	by hermes.mvista.com (Postfix) with ESMTP id 472711A6F1
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 14 Nov 2005 11:46:32 -0800 (PST)
In-Reply-To: <Pine.LNX.4.62.0511142029340.15023@numbat.sonytel.be>
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
To: linux-fbdev-devel@lists.sourceforge.net

Geert Uytterhoeven wrote:
> On Mon, 14 Nov 2005, Kevin Hilman wrote:
> 
>>I've got a question about the purpose of the reserved fields in the
>>var_screeninfo struct:
>>
>>struct fb_var_screeninfo {
>>	[ ... ]
>>	__u32 reserved[5];		/* Reserved for future compatibility */
>>};
>>
>>What are these reserved for?  Is it appropriate for drivers to use these for
> 
> 
> They are reserved for future expansion.
> 
> 
>>additional, HW-specific values that are then made available to the VSCREENINFO
>>ioctls?
> 
> 
> Not really, only for generic info that's useful for multiple drivers.
> What do you want to export there?
> 

I'm just weighing the options of whether I should just add a new
device-specific ioctl, or try to export this as part of the var_screeninfo.

I've got some HW which has the ability display/blend up to 4 video/graphics
sources within a root display window.  I'd like to export this x,y offset
(which is independent of the xoffset,yoffset for the virtual/visual stuff).
Also, it has a per-source scaling factor I'd like to export.

Kevin




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
