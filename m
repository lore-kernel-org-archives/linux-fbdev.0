From: Andrew Morton <akpm@osdl.org>
Subject: Re: backlight: oops in __mutex_lock_slowpath
 during head /sys/class/graphics/fb0/* in 2.6.18
Date: Fri, 22 Sep 2006 16:02:55 -0700
Message-ID: <20060922160255.b97f2887.akpm@osdl.org>
References: <20060921121952.GA16927@aepfle.de>
	<20060921123742.ec225cc2.akpm@osdl.org>
	<20060921215620.GA9518@hansmi.ch>
	<20060922112622.GA26724@aepfle.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GQu3Q-0006tT-Vp for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 22 Sep 2006 16:03:33 -0700
Received: from smtp.osdl.org ([65.172.181.4])
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44) id 1GQu3P-0003Kg-GL
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 22 Sep 2006 16:03:32 -0700
In-Reply-To: <20060922112622.GA26724@aepfle.de>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Olaf Hering <olaf@aepfle.de>
Cc: linux-fbdev-devel@lists.sourceforge.net, Daniel R Thompson <daniel.thompson@st.com>, Michael Hanselmann <linux-kernel@hansmi.ch>, linux-kernel@vger.kernel.org, Jon Smirl <jonsmirl@gmail.com>, "Antonino A. Daplas" <adaplas@pol.net>

On Fri, 22 Sep 2006 13:26:22 +0200
Olaf Hering <olaf@aepfle.de> wrote:

> On Thu, Sep 21, Michael Hanselmann wrote:
> 
> > What about the patch below? Does it work for you?
> 
> Appears to work.
> 
> tangerine:~ # head /sys/class/graphics/fb0/*
> ==> /sys/class/graphics/fb0/bits_per_pixel <==
> 8
> 
> ==> /sys/class/graphics/fb0/bl_curve <==
> head: error reading `/sys/class/graphics/fb0/bl_curve': No such device
> 
> ==> /sys/class/graphics/fb0/blank <==
> 
> ==> /sys/class/graphics/fb0/console <==
> 
> ==> /sys/class/graphics/fb0/cursor <==
> 
> ==> /sys/class/graphics/fb0/dev <==
> 29:0
> 
> ==> /sys/class/graphics/fb0/mode <==
> 
> ==> /sys/class/graphics/fb0/modes <==
> U:832x624p-74
> 
> ==> /sys/class/graphics/fb0/name <==
> valkyrie
> 
> ==> /sys/class/graphics/fb0/pan <==
> 0,0
> 
> ==> /sys/class/graphics/fb0/rotate <==
> 0
> 
> ==> /sys/class/graphics/fb0/state <==
> 0
> 
> ==> /sys/class/graphics/fb0/stride <==
> 832
> 
> ==> /sys/class/graphics/fb0/subsystem <==
> head: error reading `/sys/class/graphics/fb0/subsystem': Is a directory
> head: cannot open `/sys/class/graphics/fb0/uevent' for reading: Permission denied
> 
> ==> /sys/class/graphics/fb0/virtual_size <==
> 832,624

Still looks like a bit of a mess, but I assume that's expected.

Michael, I take it that patch was final?

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
