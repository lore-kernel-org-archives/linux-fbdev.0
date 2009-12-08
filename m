From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 2/4] da850/omap-l138: Add callback
 to control LCD panel power
Date: Tue, 8 Dec 2009 12:25:51 -0800
Message-ID: <20091208122551.f632c665.akpm@linux-foundation.org>
References: <1259304249-19439-1-git-send-email-chaithrika@ti.com>
	<871vj52vyt.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <akpm@linux-foundation.org>) id 1NI6dR-0004Dg-W6
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 08 Dec 2009 20:26:13 +0000
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NI6dI-0002Ia-HN
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 08 Dec 2009 20:26:13 +0000
In-Reply-To: <871vj52vyt.fsf@deeprootsystems.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: davinci-linux-open-source@linux.davincidsp.com, linux-fbdev-devel@lists.sourceforge.net

On Tue, 08 Dec 2009 09:53:46 -0800
Kevin Hilman <khilman@deeprootsystems.com> wrote:

> Chaithrika U S <chaithrika@ti.com> writes:
> 
> > Add the platform specific callback to control LCD panel and
> > backlight power.
> >
> > Signed-off-by: Chaithrika U S <chaithrika@ti.com>
> > ---
> > This patch applies to DaVinci GIT tree at
> > http://git.kernel.org/?p=linux/kernel/git/khilman/linux-davinci.git;a=summary
> 
> Andrew,
> 
> I see you have pulled this series into -mm.  Thanks.  The
> drivers/video/* changes in patches 1,3 and 4 should go upstream
> through you, but I'd like to request that you drop this patch (PATCH
> 2/4) from your queue, and I will queue it in davinci-next.

I autodrop patches when they turn up in linux-next.  So if you want to
merge something then please just merge away, then I'll drop my copy.

This way patches don't get lost, and I get to check whether the patch
which was in linux-next matches the version I had, and whether the patch
which was merged into linux-next is missing any followup patches which
I had accumulated against the original.


------------------------------------------------------------------------------
Return on Information:
Google Enterprise Search pays you back
Get the facts.
http://p.sf.net/sfu/google-dev2dev
