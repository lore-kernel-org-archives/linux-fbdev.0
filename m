From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: Question about radeon 3000 driver
Date: Mon, 1 Jun 2009 11:49:39 -0400
Message-ID: <a728f9f90906010849h394766d8yff547e2f2a3c80d0@mail.gmail.com>
References: <Pine.LNX.4.64.0906011805490.16330@diogenis.ceid.upatras.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <alexdeucher@gmail.com>) id 1MB9lf-0000tU-A2
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 01 Jun 2009 15:49:43 +0000
Received: from mail-fx0-f177.google.com ([209.85.220.177])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MB9lc-0000ZG-Ui for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 01 Jun 2009 15:49:43 +0000
Received: by fxm25 with SMTP id 25so7421174fxm.10
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 01 Jun 2009 08:49:39 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0906011805490.16330@diogenis.ceid.upatras.gr>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Stelios Xanthakis <sxanth@ceid.upatras.gr>
Cc: linux-fbdev-devel@lists.sourceforge.net

On Mon, Jun 1, 2009 at 11:13 AM, Stelios Xanthakis
<sxanth@ceid.upatras.gr> wrote:
> Hi.
>
> I have a PC with an integrated radeon 3000 gfx card
> (pci id 9616) and I'd really like to be able to use
> the linux framebuffer with a proper driver because
> vesafb has all sorts of problems.
>
> I plan to start with the usual procedure of copying
> stuff from the xf86-video-ati drivers, since this
> card is already supported by xf86-video-ati-12.
>
> The question is, are there any pending patches for
> the radeon drivers, or git trees that may have
> relevant work for the R600 chipsets?

Support for modesetting and hence fb devices is being added to the radeon drm:
http://git.kernel.org/?p=linux/kernel/git/airlied/drm-2.6.git;a=shortlog;h=drm-rawhide
http://cgit.freedesktop.org/~glisse/drm-next/log/?h=drm-next-radeon

We hope to get support for r1xx-r5xx chips into 2.6.31.  Modesetting
support for r6xx/r7xx chips is already in place, but they are still
missing some memory management bits.

Alex

------------------------------------------------------------------------------
Register Now for Creativity and Technology (CaT), June 3rd, NYC. CaT 
is a gathering of tech-side developers & brand creativity professionals. Meet
the minds behind Google Creative Lab, Visual Complexity, Processing, & 
iPhoneDevCamp as they present alongside digital heavyweights like Barbarian 
Group, R/GA, & Big Spaceship. http://p.sf.net/sfu/creativitycat-com 
