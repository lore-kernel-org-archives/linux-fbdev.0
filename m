From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: [2.6 patch] make savagefb one module
Date: Sun, 6 Mar 2005 04:49:17 +0800
Message-ID: <200503060449.24256.adaplas@hotpop.com>
References: <20050301024118.GF4021@stusta.de> <Pine.LNX.4.62.0503041017000.22831@numbat.sonytel.be> <20050305011241.GO3327@stusta.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D7gDX-0005XG-Rc
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 05 Mar 2005 12:49:43 -0800
Received: from smtp-out.hotpop.com ([38.113.3.51])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1D7gDW-0006Iv-83
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 05 Mar 2005 12:49:43 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id C965071AC5
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat,  5 Mar 2005 20:49:29 +0000 (UTC)
In-Reply-To: <20050305011241.GO3327@stusta.de>
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
To: Adrian Bunk <bunk@stusta.de>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, adaplas@pol.net, Linux Kernel Development <linux-kernel@vger.kernel.org>

On Saturday 05 March 2005 09:12, Adrian Bunk wrote:
> On Fri, Mar 04, 2005 at 10:17:17AM +0100, Geert Uytterhoeven wrote:
> > On Fri, 4 Mar 2005, Adrian Bunk wrote:
> > > This patch links all selected files under drivers/video/savagefb/ into
> > > one module.
> > >
> > > This required a renaming of savagefb.c to savagefb_driver.c .
> > >
> > > As a side effect, the EXPORT_SYMBOL's in this directory are no longer
> > > required.
> > >
> > > ---
> > >
> > > Other names than savagefb_driver.c (e.g. savagefb_main.c) are easily
> > > possible - I do not claim being good at picking names...
> >
> > savagefb_core.c?
>
> Antonino, what's your opinion?

I'll take your patch as is.

Tony




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
