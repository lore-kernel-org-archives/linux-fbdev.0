From: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.13-rc3-mm1
Date: Fri, 15 Jul 2005 16:23:49 -0700
Message-ID: <20050715162349.731ca00d.akpm@osdl.org>
References: <20050715013653.36006990.akpm@osdl.org>
	<20050716075242.24aed0bd.yuasa@hh.iij4u.or.jp>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DtZas-0006Si-A5
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 15 Jul 2005 16:27:46 -0700
Received: from smtp.osdl.org ([65.172.181.4])
	by sc8-sf-mx1.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44)
	id 1DtZas-00008m-0c
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 15 Jul 2005 16:27:46 -0700
In-Reply-To: <20050716075242.24aed0bd.yuasa@hh.iij4u.or.jp>
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
Cc: yuasa@hh.iij4u.or.jp, linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net, "Antonino A. Daplas" <adaplas@hotpop.com>

Yoichi Yuasa <yuasa@hh.iij4u.or.jp> wrote:
>
> Hi Andrew
> 
> I got the following error.
> 
> make ARCH=mips oldconfig
> scripts/kconfig/conf -o arch/mips/Kconfig
> drivers/video/Kconfig:7:warning: type of 'FB' redefined from 'boolean' to 'tristate'
> 
> file drivers/char/speakup/Kconfig already scanned?
> make[1]: *** [oldconfig] Error 1
> make: *** [oldconfig] Error 2
> 

Well arch/mips/Kconfig is defining CONFIG_FB as bool and
drivers/video/Kconfig was changed a while ago to define it as tristate.  I
assume this failure also happens in linus's current tree.  

It seems odd that mips is privately duplicating the generic code's
definition.  Maybe that needs to be taken out of there.

I'll cc the fbdev guys - could someone please come up with fix?  It's a
showstopper for the MIPS architecture.


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
