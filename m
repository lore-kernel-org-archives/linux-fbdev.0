From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: Is framebufer driver a replacement for video driver?
Date: Fri, 5 Nov 2004 04:49:12 +0800
Message-ID: <200411050449.14468.adaplas@hotpop.com>
References: <4EE0CBA31942E547B99B3D4BFAB348111ECB1B@mail.esn.co.in>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CPoY3-0006K6-1j
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 04 Nov 2004 12:49:35 -0800
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CPoY0-0004LL-8z
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 04 Nov 2004 12:49:34 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 9DF479A8688
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu,  4 Nov 2004 20:49:19 +0000 (UTC)
In-Reply-To: <4EE0CBA31942E547B99B3D4BFAB348111ECB1B@mail.esn.co.in>
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
To: linux-fbdev-devel@lists.sourceforge.net, "Mukund JB." <mukundjb@esntechnologies.co.in>
Cc: tonnerre@thundrix.ch

On Friday 05 November 2004 00:29, Mukund JB. wrote:
> Hi all,
>
> I have a small query. I may be silly, but please help by make it clear.
>
> Framebuffer definition :-
>
> The frame buffer device provides an abstraction for the graphics
> hardware. It represents the frame buffer of some video hardware and
> allows application software to access the graphics hardware through a
> well-defined interface, so the software doesn't need to know anything
> about the low-level (hardware register) stuff.
>
> Does a framebuffer driver directly interact with the hardware registers
> of the video card?

Yes.

> 					or
>
> Is there a generic low level driver that will interact with the
> hardware?

Yes and No. Yes, because there are platform drivers that may work with
many cards (VESA, VGA16, OF).  You can consider them as generic.

However, the hardware specific specific driver will work only with a
particular chipset.

>
> What happens when I say startx at command prompt with XF86Config-4 file
> configured for framebuffer driver?
>
> Is it like, When I say startx with XF86Config-4 file configured for
> framebuffer driver, the video we get is a result of X server using the
> framebuffer driver directly? Right?
>

Yes.

> In this case, Is there a video driver involved in getting the video
> apart from the framebuffer driver?
>

The framebuffer driver itself touches the hardware, and usually it's one
driver per chipset.  However, the interface that is used by the application
is standard.

Tony




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
