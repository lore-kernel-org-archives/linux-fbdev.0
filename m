From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: [PATCH] add mutex to fbdev for fb_mmap
	locking
Date: Tue, 2 Jun 2009 17:09:15 +0200
Message-ID: <20090602170915.a8d99344.krzysztof.h1@poczta.fm>
References: <200905282134.n4SLYNwv027999@imap1.linux-foundation.org>
	<alpine.LFD.2.01.0905290820510.3435@localhost.localdomain>
	<20090530121128.5f04179d.krzysztof.h1@poczta.fm>
	<alpine.LFD.2.01.0905300805350.3435@localhost.localdomain>
	<20090531162453.dff458cb.krzysztof.h1@poczta.fm>
	<alpine.LFD.2.01.0905311006070.3435@localhost.localdomain>
	<20090601222413.c2b57c9f.krzysztof.h1@poczta.fm>
	<alpine.LFD.2.01.0906011329400.3435@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <krzysztof.h1@poczta.fm>) id 1MBVVP-0007YT-RX
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 02 Jun 2009 15:02:23 +0000
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MBVVL-0007CU-4E for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 02 Jun 2009 15:02:23 +0000
In-Reply-To: <alpine.LFD.2.01.0906011329400.3435@localhost.localdomain>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: krzysztof.h1@wp.pl, Linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>, Peter Zijlstra <a.p.zijlstra@chello.nl>, geert@linux-m68k.org, akpm@linux-foundation.org, Ingo Molnar <mingo@elte.hu>, righi.andrea@gmail.com

On Mon, 1 Jun 2009 13:38:40 -0700 (PDT)
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> 
> 
> On Mon, 1 Jun 2009, Krzysztof Helt wrote:
> > If the revert to BKL is rejected this patch may wait till 2.6.31.
> 
> Ahh, so this one helps clean up locking, but doesn't fix any actual 
> regressions? I was going to ask you about that.
> 

There is a problem with multihead configuration with and without the patch.
I realize that it is late stage of the 2.6.30 so IMO it is not worth pushing it at 
this moment .
The patch is quite an improvement for smem_start/smem_len handling
so it should find its way into the tree.

> Btw - one thing you could try on the whole lockdep front - and I realize 
> that this is a _total_ hack - is to try the patch below.
> 
> The _only_ thing it does is to hide the sysfs_mutex -> mm_lock chain from 
> lockdep, by using the (incorrect) __copy_to_user_inatomic() instead of the 
> (correct) copy_to_user(). But I'd like to hear if that sysfs_mutex in 
> readdir is the only way you can get a chain.
> 

I'll test this.

Best regards,
Krzysztof

----------------------------------------------------------------------
Chcesz miec nawigacje GPS ?
Zamow lub przedluz umowe na neostrade, a nawigacja bedzie Twoja.
Kliknij na link po szczegoly! http://link.interia.pl/f219a



------------------------------------------------------------------------------
OpenSolaris 2009.06 is a cutting edge operating system for enterprises 
looking to deploy the next generation of Solaris that includes the latest 
innovations from Sun and the OpenSource community. Download a copy and 
enjoy capabilities such as Networking, Storage and Virtualization. 
Go to: http://p.sf.net/sfu/opensolaris-get
