From: "Jaya Kumar" <jayakumar.lkml@gmail.com>
Subject: Re: [PATCH 1/2 2.6.24] fbdev: platforming
	metronomefb and am200epd
Date: Thu, 3 Apr 2008 20:58:53 -0400
Message-ID: <45a44e480804031758t794dc55bh9a06d540eb534582@mail.gmail.com>
References: <20080403051908.29628.86131.sendpatchset@apodmy1>
	<20080403153226.71ce93df.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JhaGd-0005Q7-TZ for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 03 Apr 2008 17:58:56 -0700
Received: from [72.14.204.174] (helo=qb-out-0708.google.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JhaGd-0004wB-CG
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 03 Apr 2008 17:58:55 -0700
Received: by qb-out-0708.google.com with SMTP id k28so517927qba.0
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 03 Apr 2008 17:58:54 -0700 (PDT)
In-Reply-To: <20080403153226.71ce93df.akpm@linux-foundation.org>
Content-Disposition: inline
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fbdev-devel@lists.sourceforge.net

On Thu, Apr 3, 2008 at 6:32 PM, Andrew Morton <akpm@linux-foundation.org> wrote:
> On Thu, 03 Apr 2008 01:19:08 -0400
>  Jaya Kumar <jayakumar.lkml@gmail.com> wrote:
>
>  > Hi Tony, Geert, Andrew, fbdev,
>  >
>  > This patchset has 2 patches. They are are in order to split metronomefb and
>  > hecubafb into platform independent (platform drivers) and platform specific
>  > (platform devices) drivers which are am200epd (arm) and n411 (x86). The
>  > improvement over the last time I posted this is that I've now added module
>  > refcount handling in the platform drivers and so module loading/unloading
>  > works.
>  >
>  > I would be grateful for any feedback on this.
>  >
>  > Thanks,
>  > jaya
>  >
>  > This patch splits metronomefb into the platform independent metronomefb and
>  > the platform dependent am200epd. It also includes some comment cleanup and
>  > a bugfix for the use of cfb_* functions instead of sys_* functions. The
>  > Kconfig and Makefile changes include the changes needed for hecubafb and
>  > n411.
>  >
>
>  argh.
>
>  Please don't mix huge code-motion changes into the same patch with bugfixes!
>
>  a) we want to be able to look at and review that bugfix in isolation

Ok. I guess I need to figure out how to do this. I will do a separate
patch that only fixes the bug and then patches on top of that to
platformize.

>
>  b) what happens if someone (eg a distro) is shipping 2.6.23 and wants to
>  backport your bugfix?
>

My thinking in doing this as one set was practicality. But I agree
with the principle behind splitting the patches and so will do so.

Thanks,
jaya

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
