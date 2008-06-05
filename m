From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH resend] Adding dummy release
 functions to avoid warnings.
Date: Thu, 5 Jun 2008 09:07:25 -0700
Message-ID: <20080605090725.96da4b75.akpm@linux-foundation.org>
References: <1208306056.15140.13.camel@pcvitaliy>
	<35fbaa3e0806050239y5987fc33rd349be8d07bc1262@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1K4I0d-0003ZS-To for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 05 Jun 2008 09:08:15 -0700
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1K4I0c-0002q1-Ft
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 05 Jun 2008 09:08:15 -0700
In-Reply-To: <35fbaa3e0806050239y5987fc33rd349be8d07bc1262@mail.gmail.com>
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
To: Vitaliy Ivanov <vitalivanov@gmail.com>
Cc: devzero@web.de, linux-fbdev-devel@lists.sourceforge.net, torvalds@linux-foundation.org, lkml <linux-kernel@vger.kernel.org>, protasnb@gmail.com, jsun@junsun.net, dwmw2@infradead.org

On Thu, 5 Jun 2008 12:39:46 +0300 "Vitaliy Ivanov" <vitalivanov@gmail.com> wrote:

> Hi all,
> 
> Natalie reported that patch wasn't accepted.
> Please check this out. If I need to correct it somehow then pls let me know.
> 
> V.
> 
> ---------- Forwarded message ----------
> From: Vitaliy Ivanov <vitalivanov@gmail.com>
> Date: Wed, Apr 16, 2008 at 3:34 AM
> Subject: [PATCH] Adding dummy release functions to avoid warnings.
> To: linux-kernel@vger.kernel.org, devzero@web.de, jsun@junsun.net,
> dwmw2@infradead.org
> 
> 
> 
> Subject: [PATCH] Adding dummy release functions to avoid warnings.
> 
> From: Vitaliy Ivanov <vitalivanov@gmail.com>
> 
> Trivial fix for #9690.
> Added simple release functions that doing nothing.
> Not sure whether we can leave it as is or to rework using
> platform_device helpers like platform_device_alloc.

Please see Documentation/kobject.txt - search for the text
"mocked mercilessly" :)

> This approach is used in many drivers.
> --
> 
>  drivers/mtd/maps/physmap.c |    6 ++++++

Let's mock David too!

>  drivers/video/hgafb.c      |   10 +++++++++-

I expect that
hgafb-convert-to-new-platform-driver-api-bugzilla-9689.patch which I
merged yesterday will help here.


-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
