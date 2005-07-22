From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: Fw: framebuffer blitting performance loss  2.6.12 -> 2.6.13-rc3
Date: Fri, 22 Jul 2005 11:58:23 +0800
Message-ID: <200507221158.23454.adaplas@gmail.com>
References: <20050715033912.1cd9b6c3.akpm@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Dvpbc-0000b8-Aq
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 21 Jul 2005 21:57:52 -0700
Received: from rproxy.gmail.com ([64.233.170.195])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1Dvpbc-0000EK-Aq
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 21 Jul 2005 21:57:52 -0700
Received: by rproxy.gmail.com with SMTP id a41so142889rng
        for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 21 Jul 2005 21:57:48 -0700 (PDT)
In-Reply-To: <20050715033912.1cd9b6c3.akpm@osdl.org>
Content-Disposition: inline
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: linux-fbdev-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>
Cc: Knut Petersen <Knut_Petersen@t-online.de>

On Friday 15 July 2005 18:39, Andrew Morton wrote:
> Begin forwarded message:
>
> Date: Fri, 15 Jul 2005 12:14:37 +0200
> From: Knut Petersen <Knut_Petersen@t-online.de>
> To: linux-kernel@vger.kernel.org
> Subject: framebuffer blitting performance loss  2.6.12 -> 2.6.13-rc3
>
>
> Hi everybody!
>
> There is a serious performance loss between 2.6.12 and 2.6.13-rc3
> affecting _all_ framebuffer devices, especially those with fast
> bitblit functions.
>

I haven't seen any significant performance penalty, between 2.6.12-rc5-mm1
and 2.6.13-rc3-mm1.

Based on your results, I would pinpoint the culprit to be in
video/console/bitblit.c.  However, the changes there are minor, and should not
alter the peformance.

Tony



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
