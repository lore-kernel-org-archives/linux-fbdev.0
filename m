From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: Rivafb won't work with DVI connector
Date: Fri, 26 Nov 2004 05:16:43 +0800
Message-ID: <200411260516.43777.adaplas@hotpop.com>
References: <200411250807.32040.adaplas@hotpop.com> <200411251527.15141.andrew@walrond.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CXRg1-0001Ku-CM
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 25 Nov 2004 14:01:21 -0800
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CXRfq-00029n-Bf
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 25 Nov 2004 14:01:20 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 32437A556C2
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 25 Nov 2004 22:00:52 +0000 (UTC)
In-Reply-To: <200411251527.15141.andrew@walrond.org>
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
To: linux-fbdev-devel@lists.sourceforge.net, Andrew Walrond <andrew@walrond.org>

On Thursday 25 November 2004 23:27, Andrew Walrond wrote:
> On Thursday 25 Nov 2004 00:07, Antonino A. Daplas wrote:
> > That's assuming 0x31b is supported by your card.  Why not
> > try:
> >
> > vga=ask
> >
> > Choose 'scan', choose the highest size, and check if the panel
> > size changed again.
>
> vesafb 'scan' can only find 80xwhatever text modes with dvi connnection,
> and upto 132xwhatever text modes with dsub. It does not display any
> graphics modes at all, and rejects them if I try. (I also tried with vesafb
> only, nvidafb removed - same result).
>
> > Well, checking the latest Xorg again, it seems that the nv driver also
> > depends on the BIOS for the panel size.  And they are the people who does
> > have access to the docs.
>
> Ok; But remember that I can run this screen with DVI connection at
> 1600x1200 just fine with the proprietary nvidia driver. (Infact I routinely

I'm pretty sure it's not a hardware limitation or I would have mentioned that
before.

> run it dual head with both TFTs at 1600x1200, one on dvim one on dsub) so
> its not the case that it can't be done. Iff the Xorg guys have docs,
> perhaps they can work out how to do it.
>
> > Sure, no harm in asking.  But I would rather ask the Xorg people first. 
> > If
>
> Ok, go ask Xorg. If you don't have any luck, I'll get in touch with Nvidia
> directly and see if they will help.

I sent mail to devel@xfree86.org.  Particularly one member Mark Vojkovich
actually works for nvidia and helps in the development of both the open and
closed source driver.

Tony




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
