From: Andrew Morton <akpm@osdl.org>
Subject: Re: Fw: framebuffer blitting performance loss
 2.6.12 -> 2.6.13-rc3
Date: Fri, 29 Jul 2005 12:02:50 -0700
Message-ID: <20050729120250.3c8c1372.akpm@osdl.org>
References: <20050715033912.1cd9b6c3.akpm@osdl.org>
	<200507221158.23454.adaplas@gmail.com>
	<20050729001735.5934622f.akpm@osdl.org>
	<42EA430C.2010405@t-online.de>
	<42EA4E6A.70907@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Dya9F-00066O-E6
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 29 Jul 2005 12:03:57 -0700
Received: from smtp.osdl.org ([65.172.181.4])
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44)
	id 1Dya9D-0004Ge-Mj
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 29 Jul 2005 12:03:57 -0700
In-Reply-To: <42EA4E6A.70907@gmail.com>
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
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: Knut_Petersen@t-online.de, linux-fbdev-devel@lists.sourceforge.net

"Antonino A. Daplas" <adaplas@gmail.com> wrote:
>
>     fbdev: Replace memcpy with for-loop when preparing bitmap

Whee, progress.  Please let me know if/when you want this sent to Linus.


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
