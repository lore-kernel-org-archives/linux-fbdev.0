From: "Jaya Kumar" <jayakumar.lkml@gmail.com>
Subject: Re: [RFC 2.6.26-rc3 1/7] pxafb: module
	unloading support
Date: Thu, 12 Jun 2008 10:17:21 -0400
Message-ID: <45a44e480806120717w24d81426k2086ea0e1a7cb9b0@mail.gmail.com>
References: <1212814166-10313-1-git-send-email-jayakumar.lkml@gmail.com>
	<1212814166-10313-2-git-send-email-jayakumar.lkml@gmail.com>
	<18510.8821.785915.671710@ipc1.ka-ro> <484E30E6.8090204@gmail.com>
	<45a44e480806112136j7f96cc68ga4c92d796f64b057@mail.gmail.com>
	<20080612072534.adc46a9e.krzysztof.h1@poczta.fm>
	<4850F852.40501@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1K6ncA-00028V-GB for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 12 Jun 2008 07:17:22 -0700
Received: from yw-out-1718.google.com ([74.125.46.153])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1K6ncA-0005Ht-7i
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 12 Jun 2008 07:17:22 -0700
Received: by yw-out-1718.google.com with SMTP id 6so2327841ywa.82
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 12 Jun 2008 07:17:22 -0700 (PDT)
In-Reply-To: <4850F852.40501@gmail.com>
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
To: Eric Miao <eric.y.miao@gmail.com>
Cc: ymiao3@marvell.com, linux-fbdev-devel@lists.sourceforge.net, linux-arm-kernel@lists.arm.linux.org.uk

On Thu, Jun 12, 2008 at 6:20 AM, Eric Miao <eric.y.miao@gmail.com> wrote:
>
> I still feel a bit upset to this set of patches, and I need more time
> to review, thanks.
>

Hi Eric,

Yes, I agree with you that this patchset is unusual. I think this is
probably the only case where we have one fbdev driver feeding on the
framebuffer of another. So I can understand your feeling.

btw, I'm happy to rewrite any portion to improve it. Please share your
thoughts and I will try to work towards resolving the issues.

Thanks,
jaya

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
