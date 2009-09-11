From: Daniel Mack <daniel@caiaq.de>
Subject: Re: [PATCH] video: add PXA3xx accelerator ID
	[v2]
Date: Fri, 11 Sep 2009 17:20:19 +0200
Message-ID: <20090911152019.GZ18340@buzzloop.caiaq.de>
References: <20090910132630.GZ9410@buzzloop.caiaq.de>
	<Pine.LNX.4.64.0909101530120.4458@axis700.grange>
	<20090910133327.GA9410@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <daniel@caiaq.de>) id 1Mm7vQ-00014Z-VH
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 11 Sep 2009 15:20:36 +0000
Received: from buzzloop.caiaq.de ([212.112.241.133])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Mm7vK-0002pp-Hl
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 11 Sep 2009 15:20:36 +0000
Content-Disposition: inline
In-Reply-To: <20090910133327.GA9410@buzzloop.caiaq.de>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Sven Neumann <s.neumann@raumfeld.com>, linux-fbdev-devel@lists.sourceforge.net, Eric Miao <eric.y.miao@gmail.com>, Dennis Oliver Kropp <dok@directfb.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

On Thu, Sep 10, 2009 at 03:33:27PM +0200, Daniel Mack wrote:
> On Thu, Sep 10, 2009 at 03:31:34PM +0200, Guennadi Liakhovetski wrote:
> > > +	if (cpu_is_pxa3xx() && inf->acceleration_enabled)
> > > +		fbi->fb.fix.accel = FB_ACCEL_PXA3XX;
> > > +
> > 
> > Ok, now remove 'cpu_is_pxa3xx() && ' above and you should be good to go:-) 
> > What if tomorrow pxa4xx comes (ok, Eric will disagree, but wtill:-))
> 
> Don't know. I left it in there intentionally, but I'm fine to remove it.
> Or Eric does it when applying ;) Eric?

What I was considering are cases where a kernel binary that works on
both PXA3xx and other PXAs shares the same pxafb_mach_info struct across
different board support code. The accel flag would then be set for wrong
platforms.

But this might be academic, that's why I don't have a strong opinion on
that :)

Daniel


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
