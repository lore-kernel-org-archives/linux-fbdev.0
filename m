From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: [Bugme-new] [Bug 12712] New: s2disk hangs
 with nvidiafb
Date: Mon, 16 Feb 2009 20:59:47 +0100
Message-ID: <20090216205947.d024cf25.krzysztof.h1@poczta.fm>
References: <bug-12712-10286@http.bugzilla.kernel.org/>
	<20090215111720.6860a225.akpm@linux-foundation.org>
	<web-45680874@post.open.by>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <krzysztof.h1@poczta.fm>) id 1LZ9Yx-0002EV-NF
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 16 Feb 2009 19:55:31 +0000
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1LZ9Yp-00033v-CD for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 16 Feb 2009 19:55:31 +0000
In-Reply-To: <web-45680874@post.open.by>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: "Sergei S." <bender.rodriguez@open.by>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-fbdev-devel@lists.sourceforge.net, bugme-daemon@bugzilla.kernel.org

On Sun, 15 Feb 2009 23:11:26 +0200
"Sergei S." <bender.rodriguez@open.by> wrote:
> 
> I've tested
> 2.6.27-14, 2.6.29-rc4 (git-5, git-7), 2.6.29-rc5
> 
> all of them fails to s2disk with nvidiafb.
> 
> dmesg | grep buf
> [    1.651258] Console: switching to colour frame buffer device 160x50
> [    1.652466] nvidiafb: PCI nVidia NV1d framebuffer (64MB @ 0xC0000000)
> [    1.652846] vesafb: framebuffer at 0xc0000000, mapped to 0xfd980000, using
> 6144k, total 131072k
> [    1.653320] fb1: VESA VGA frame buffer device
> 

Interesting, you have two framebuffers running on a single card. Does the s2disk
works for you if you select nvidiafb and turn off vesa framebuffer?

Can you post the same lines for the latest working kernel with both vesa and nvidia
framebuffers selected?

Regards,
Krzysztof


----------------------------------------------------------------------
Zostan mistrzem parkowania w Bombaju!
Zagraj >> http://link.interia.pl/f204e 


------------------------------------------------------------------------------
Open Source Business Conference (OSBC), March 24-25, 2009, San Francisco, CA
-OSBC tackles the biggest issue in open source: Open Sourcing the Enterprise
-Strategies to boost innovation and cut costs with open source participation
-Receive a $600 discount off the registration fee with the source code: SFAD
http://p.sf.net/sfu/XcvMzF8H
