From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: Re: [Fwd: AtyFB in 2.6.10, still not perfect]
Date: Wed, 16 Mar 2005 07:49:18 +0800
Message-ID: <200503160749.19151.adaplas@hotpop.com>
References: <200503151826.46073.adaplas@hotpop.com> <200503160439.05644.adaplas@hotpop.com> <1110928841.6491.0.camel@willis>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DBLmx-0005Ag-9j
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 15 Mar 2005 15:49:27 -0800
Received: from smtp-out.hotpop.com ([38.113.3.71])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DBLmv-0002TG-NS
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 15 Mar 2005 15:49:27 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 8BDE114A5A34
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 15 Mar 2005 23:49:08 +0000 (UTC)
In-Reply-To: <1110928841.6491.0.camel@willis>
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
To: Luigi Gangitano <luigi@debian.org>, adaplas@pol.net
Cc: linux-fbdev-devel@lists.sourceforge.net, Alexander Kern <alex.kern@gmx.de>

On Wednesday 16 March 2005 07:20, Luigi Gangitano wrote:
> Il giorno mer, 16-03-2005 alle 04:39 +0800, Antonino A. Daplas ha
>
> scritto:
> > working:
> > atyfb: 3D RAGE (XL) [0x4752 rev 0x27] 8M SDRAM, 29.498928 MHz XTAL, 230
> > MHz PLL, 100 Mhz MCLK
> >
> > not working:
> > atyfb: 3D RAGE XL (Mach64 GR, PCI-33MHz) [0x4752 rev 0x27]
> > atyfb: 8M SDRAM (1:1), 29.498928 MHz XTAL, 230 MHz PLL, 83 Mhz MCLK, 63
> > MHz XCLK
> >
> > The MCLK value is different.  Can you try booting with
> >
> > video=atyfb:mclk:100
> >
> > You can also experiment with xclk:
> >
> > video=atyfb:mclk:100,xclk:63
>
> No luck, with neither option.

Hmmn, let's just wait for the other developers to respond.

Tony




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
