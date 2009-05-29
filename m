From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH] [drivers] [fb] S3C-fb: PM fix
Date: Fri, 29 May 2009 09:16:39 +0200
Message-ID: <000001c9e02d$6bff66a0$43fe33e0$%szyprowski@samsung.com>
References: <E4D3F24EA6C9E54F817833EAE0D912AC0226526883@bssrvexch01.BS.local>
	<20090527233325.bb60a326.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <m.szyprowski@samsung.com>) id 1M9wMK-0000cX-JL
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 29 May 2009 07:18:32 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1M9wMI-000161-Ps for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 29 May 2009 07:18:32 +0000
Received: from epmmp1 (mailout1.samsung.com [203.254.224.24])
	by mailout1.samsung.com
	(iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
	with ESMTP id <0KKE00F9X9MPPF@mailout1.samsung.com> for
	linux-fbdev-devel@lists.sourceforge.net;
	Fri, 29 May 2009 16:18:25 +0900 (KST)
Received: from AMDC159 ([106.116.37.153])
	by mmp1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14
	2004)) with ESMTPA id <0KKE0041Y9ME1G@mmp1.samsung.com> for
	linux-fbdev-devel@lists.sourceforge.net;
	Fri, 29 May 2009 16:18:25 +0900 (KST)
In-reply-to: <20090527233325.bb60a326.akpm@linux-foundation.org>
Content-language: pl
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: 'Andrew Morton' <akpm@linux-foundation.org>
Cc: linux-fbdev-devel@lists.sourceforge.net, "'Antonino A. Daplas'" <adaplas@gmail.com>, kyungmin.park@samsung.com, 'Ben Dooks' <ben-linux@fluff.org>, linux-arm-kernel@lists.arm.linux.org.uk, Marek Szyprowski <m.szyprowski@samsung.com>

Hello,

On Thursday, May 28, 2009 8:33 AM Andrew Morton wrote:

> On Mon, 18 May 2009 08:05:46 +0200 Marek Szyprowski
> <m.szyprowski@samsung.com> wrote:
> 
> > Restore correctly FrameBuffer registers state in resume function.
> >
> > Reviewed-by: Kyungmin Park <kyungmin.park@samsung.com>
> > Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > [...]

> What are the consequences of the bug whcih you fixed?  Device
> inoperative after resume, I assume?  Does it affect all supported
> hardware, or just some particualr device(s)?

Yes, the framebuffer was inoperative after resume. This bug was triggered on
a system that has a power management circuit which disabled power in most
S3C SOC power domains in suspend mode. In such case drivers need to restore
all its registers state after resume.

> See, this is the sort of information whcih shuld be in the changelog,
> please, so I (and others) can make decisions about which kernel
> version(s) the patch should be merged into.

Ok. I will describe my patches more in detail in the future. Thanks for your
comments.

Best regards
--
Marek Szyprowski
Samsung Poland R&D Center



------------------------------------------------------------------------------
Register Now for Creativity and Technology (CaT), June 3rd, NYC. CaT 
is a gathering of tech-side developers & brand creativity professionals. Meet
the minds behind Google Creative Lab, Visual Complexity, Processing, & 
iPhoneDevCamp as they present alongside digital heavyweights like Barbarian 
Group, R/GA, & Big Spaceship. http://p.sf.net/sfu/creativitycat-com 
