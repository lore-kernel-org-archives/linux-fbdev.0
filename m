From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: Is framebufer driver a replacement for video driver?
Date: Sat, 6 Nov 2004 05:48:22 +0800
Message-ID: <200411060548.23261.adaplas@hotpop.com>
References: <4EE0CBA31942E547B99B3D4BFAB348111ECB8A@mail.esn.co.in>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CQBxR-0004wI-34
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 05 Nov 2004 13:49:21 -0800
Received: from smtp-out.hotpop.com ([38.113.3.71])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CQBxQ-0007an-3D
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 05 Nov 2004 13:49:21 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id BA0E811BEB4F
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri,  5 Nov 2004 21:48:22 +0000 (UTC)
In-Reply-To: <4EE0CBA31942E547B99B3D4BFAB348111ECB8A@mail.esn.co.in>
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
Cc: adaplas@pol.net, tonnerre@thundrix.ch

On Friday 05 November 2004 19:44, Mukund JB. wrote:
> Hi Geert,
>
> Thanks for that.
> Please, try to give me more clarity on the framebuffer driver by solving
> the below quires?
>
> > > Are you talking about the vesafb driver? This being  a generic
>
> driver,
>
> > > Will this driver work on any video card?
> >
> > Yep, `VESA' means the vesafb driver. It works on any video card with a
> > VESA 2.0
> > compliant BIOS.
>
> If vesafb module works for any card, what are the situations that make
> me write a new framebuffer driver for a new video hardware in the
> market?
>
> Is it like, the vesafb driver does not explore the card to the fullest
> extent?
> A framebuffer driver specific to Video card is just to explore the card
> features to maximum.
>
> Can u please tell me why to call "scr_readw" in accel.c file of riva
> directory doing?
> Also, I found NO readl, writel calls in the riva directory( framebuffer
> driver). Then, who is responsible for accessing the hardware here?
>

Because the supposedly OS-agnostic file uses direct pointer manipulation, which
does imply that this file is not trully OS-agnostic.

The rivafb in 2.6.10-rc1-mm3 is already ported to use readl/writel.
.
Tony




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
