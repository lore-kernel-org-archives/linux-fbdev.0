From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: w100 fb driver
Date: Fri, 26 Nov 2004 03:55:19 +0800
Message-ID: <200411260355.19360.adaplas@hotpop.com>
References: <021601c4ce58$1111a730$0f01a8c0@max> <200411200610.08802.adaplas@hotpop.com> <032501c4d302$3970ddf0$0f01a8c0@max>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CXPjK-0000C4-SK
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 25 Nov 2004 11:56:38 -0800
Received: from smtp-out.hotpop.com ([38.113.3.71])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CXPjJ-0002wy-3E
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 25 Nov 2004 11:56:38 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id D68E912301FC
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 25 Nov 2004 19:55:25 +0000 (UTC)
In-Reply-To: <032501c4d302$3970ddf0$0f01a8c0@max>
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
To: linux-fbdev-devel@lists.sourceforge.net, Richard Purdie <rpurdie@rpsys.net>

On Thursday 25 November 2004 23:19, Richard Purdie wrote:
> Antonino A. Daplas:
> [re: inclusion of the w100 driver in the kernel]
>
> > Should be okay, just wondering why not use the kernel i2c algo's instead
> > of using your own.
>
> The kernel's i2c algo's require two way communication and expect the data
> to be ack'ed. In this case, we have no way to read the data back from the
> spp interface so we can't implement all the functions the kernel interface
> would need.
>
> > Submit patch inline to this list and CC me.  Preferrably break the patch
> > down into several, hopefully standalone patches.  Add a changelog, and a
> > signed-off line.
>
> That sounds fine. I've taken your comments (and those made by Geert
> Uytterhoeven) onboard and revised the driver. For various reasons, I've
> moved the driver over the to new device structure which allows me to pass a
> structure with some hardware specific details to the driver. This means I
> need to include the header file elsewhere in the kernel. Should/can I move
> that file to drivers/video in whole or in part (or do something else)?

The current placement is fine.

Place things that are used or have the potential to be used by other kernel
subsystems in include/video (ie register definitions) and those that should
be private to the driver in include/video.

>
> An updated version of the driver is at:
>
> http://www.rpsys.net/openzaurus/arm/w100-r1.patch
>
> (its using two header files until I know which approach is preferred)

Nothing wrong with using 2 headers.

Tony




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
