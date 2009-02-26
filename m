From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] cirrusfb: fix compilation in Zorro
	code
Date: Thu, 26 Feb 2009 12:50:32 -0800
Message-ID: <20090226125032.29afcc66.akpm@linux-foundation.org>
References: <20090225070956.41fff8e6.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <akpm@linux-foundation.org>) id 1LcnBo-0006X8-9y
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 26 Feb 2009 20:50:40 +0000
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1LcnBj-0001xs-S3
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 26 Feb 2009 20:50:40 +0000
In-Reply-To: <20090225070956.41fff8e6.krzysztof.h1@poczta.fm>
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
Cc: linux-fbdev-devel@lists.sourceforge.net

On Wed, 25 Feb 2009 07:09:56 +0100
Krzysztof Helt <krzysztof.h1@poczta.fm> wrote:

> Where can I get m68 cross compiler for PC able
> to compile Amiga kernel?

http://userweb.kernel.org/~akpm/cross-compilers/ has some cross-compilers.
They're a bit crufty nowadays, but the m68k one works OK I think.

------------------------------------------------------------------------------
Open Source Business Conference (OSBC), March 24-25, 2009, San Francisco, CA
-OSBC tackles the biggest issue in open source: Open Sourcing the Enterprise
-Strategies to boost innovation and cut costs with open source participation
-Receive a $600 discount off the registration fee with the source code: SFAD
http://p.sf.net/sfu/XcvMzF8H
