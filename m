From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: Fw: 2.6.11, framebuffer
Date: Tue, 15 Feb 2005 07:52:19 +0800
Message-ID: <200502150752.19379.adaplas@hotpop.com>
References: <20050214100348.3542b897.akpm@osdl.org> <4210F9A6.4060302@comcast.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D0q14-0003TG-E3
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 14 Feb 2005 15:52:34 -0800
Received: from smtp-out.hotpop.com ([38.113.3.71])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1D0q13-0002LU-1P
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 14 Feb 2005 15:52:34 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 5EDED13E672F
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 14 Feb 2005 23:52:16 +0000 (UTC)
In-Reply-To: <4210F9A6.4060302@comcast.net>
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
To: linux-fbdev-devel@lists.sourceforge.net, Zack Smith <plinius@comcast.net>

On Tuesday 15 February 2005 03:19, Zack Smith wrote:
> > I cannot start a frame buffer on 2.6,11x using
> > hardware with the
> >     intel 915g
> > chip. Either it crashes or nothing happens, depending on modules,
> > kernel compilation etc. Nothing works.
>
> Similarly:
>
> With kernel 2.6.9 using an Intel 82852/82855 (not sure which)
> and compiling the kernel with the VESA framebuffer, starting
> up with vga requested at 1024x768 16bit, the framebuffer
> console doesn't start.
>
> I also tried the Intel framebuffer and that didn't work either.
>
> Both start up as text.

Can you send your dmesg for both intelfb and vesafb enabled.

Tony




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
