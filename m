From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] add mutex to fbdev for fb_mmap
	locking
Date: Mon, 1 Jun 2009 13:38:40 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0906011329400.3435@localhost.localdomain>
References: <200905282134.n4SLYNwv027999@imap1.linux-foundation.org>
	<alpine.LFD.2.01.0905290820510.3435@localhost.localdomain>
	<20090530121128.5f04179d.krzysztof.h1@poczta.fm>
	<alpine.LFD.2.01.0905300805350.3435@localhost.localdomain>
	<20090531162453.dff458cb.krzysztof.h1@poczta.fm>
	<alpine.LFD.2.01.0905311006070.3435@localhost.localdomain>
	<20090601222413.c2b57c9f.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <torvalds@linux-foundation.org>) id 1MBEHs-000443-0z
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 01 Jun 2009 20:39:16 +0000
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MBEHp-0003Te-OS
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 01 Jun 2009 20:39:16 +0000
In-Reply-To: <20090601222413.c2b57c9f.krzysztof.h1@poczta.fm>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Krzysztof Helt <krzysztof.h1@poczta.fm>
Cc: krzysztof.h1@wp.pl, Linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>, Peter Zijlstra <a.p.zijlstra@chello.nl>, geert@linux-m68k.org, akpm@linux-foundation.org, Ingo Molnar <mingo@elte.hu>, righi.andrea@gmail.com



On Mon, 1 Jun 2009, Krzysztof Helt wrote:
> 
> I will fix it. 

Thanks.

> If the revert to BKL is rejected this patch may wait till 2.6.31.

Ahh, so this one helps clean up locking, but doesn't fix any actual 
regressions? I was going to ask you about that.

Btw - one thing you could try on the whole lockdep front - and I realize 
that this is a _total_ hack - is to try the patch below.

The _only_ thing it does is to hide the sysfs_mutex -> mm_lock chain from 
lockdep, by using the (incorrect) __copy_to_user_inatomic() instead of the 
(correct) copy_to_user(). But I'd like to hear if that sysfs_mutex in 
readdir is the only way you can get a chain.

So this is in _no_ way meant to be a serious patch, and is literally just 
a test to see if "ok, readdir and sysfs_mutex is really the only real 
deadlock case" is true. Or are there possibly other cases that trigger 
this?

Because if it's really just this chain through sysfs_mutex, then the 
deadlock scenario should boil down to just the "two different fbcon's and 
really unlucky activity just as you register the second of them". Which is 
still a bug, of course - it's just not ever going to bite anybody in 
practice.

		Linus

---
 fs/readdir.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/readdir.c b/fs/readdir.c
index 7723401..431f647 100644
--- a/fs/readdir.c
+++ b/fs/readdir.c
@@ -172,7 +172,7 @@ static int filldir(void * __buf, const char * name, int namlen, loff_t offset,
 		goto efault;
 	if (__put_user(reclen, &dirent->d_reclen))
 		goto efault;
-	if (copy_to_user(dirent->d_name, name, namlen))
+	if (__copy_to_user_inatomic(dirent->d_name, name, namlen))
 		goto efault;
 	if (__put_user(0, dirent->d_name + namlen))
 		goto efault;
@@ -256,7 +256,7 @@ static int filldir64(void * __buf, const char * name, int namlen, loff_t offset,
 		goto efault;
 	if (__put_user(d_type, &dirent->d_type))
 		goto efault;
-	if (copy_to_user(dirent->d_name, name, namlen))
+	if (__copy_to_user_inatomic(dirent->d_name, name, namlen))
 		goto efault;
 	if (__put_user(0, dirent->d_name + namlen))
 		goto efault;

------------------------------------------------------------------------------
OpenSolaris 2009.06 is a cutting edge operating system for enterprises 
looking to deploy the next generation of Solaris that includes the latest 
innovations from Sun and the OpenSource community. Download a copy and 
enjoy capabilities such as Networking, Storage and Virtualization. 
Go to: http://p.sf.net/sfu/opensolaris-get
