From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/2 2.6.24] fbdev: platforming
	metronomefb and am200epd
Date: Thu, 3 Apr 2008 15:32:26 -0700
Message-ID: <20080403153226.71ce93df.akpm@linux-foundation.org>
References: <20080403051908.29628.86131.sendpatchset@apodmy1>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JhXz1-0008QX-5Y for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 03 Apr 2008 15:32:35 -0700
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JhXyz-0004P0-SQ
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 03 Apr 2008 15:32:35 -0700
In-Reply-To: <20080403051908.29628.86131.sendpatchset@apodmy1>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
Cc: jayakumar.lkml@gmail.com, linux-fbdev-devel@lists.sourceforge.net

On Thu, 03 Apr 2008 01:19:08 -0400
Jaya Kumar <jayakumar.lkml@gmail.com> wrote:

> Hi Tony, Geert, Andrew, fbdev,
> 
> This patchset has 2 patches. They are are in order to split metronomefb and
> hecubafb into platform independent (platform drivers) and platform specific
> (platform devices) drivers which are am200epd (arm) and n411 (x86). The
> improvement over the last time I posted this is that I've now added module
> refcount handling in the platform drivers and so module loading/unloading
> works.
> 
> I would be grateful for any feedback on this.
> 
> Thanks,
> jaya
> 
> This patch splits metronomefb into the platform independent metronomefb and
> the platform dependent am200epd. It also includes some comment cleanup and
> a bugfix for the use of cfb_* functions instead of sys_* functions. The 
> Kconfig and Makefile changes include the changes needed for hecubafb and
> n411.
> 

argh.

Please don't mix huge code-motion changes into the same patch with bugfixes!

a) we want to be able to look at and review that bugfix in isolation

b) what happens if someone (eg a distro) is shipping 2.6.23 and wants to
backport your bugfix?


-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
