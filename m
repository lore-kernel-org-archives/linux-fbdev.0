From: "Dave Airlie" <airlied@gmail.com>
Subject: Re: [PATCH] nvidiafb: allow ignoring EDID info
Date: Mon, 29 Jan 2007 11:12:57 +1100
Message-ID: <21d7e9970701281612q56b694edp6efd1a5556dea3fe@mail.gmail.com>
References: <ephv35$4i3$1@sea.gmane.org>
	<20070128160831.fb51347f.akpm@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HBK8p-0004Mt-9H for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 28 Jan 2007 16:12:59 -0800
Received: from ug-out-1314.google.com ([66.249.92.169])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HBK8o-0002v8-SV
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 28 Jan 2007 16:12:59 -0800
Received: by ug-out-1314.google.com with SMTP id z38so1089254ugc
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 28 Jan 2007 16:12:57 -0800 (PST)
In-Reply-To: <20070128160831.fb51347f.akpm@osdl.org>
Content-Disposition: inline
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>, linux-kernel@vger.kernel.org

> > Some nVidia video cards have broken EDID information. Using nvidiafb
> > with CONFIG_FB_NVIDIA_I2C enabled on these systems causes the console
> > framebuffer to use wrong timing information, causing the display to be
> > extremely 'snowy'. Since most distribution kernels are compiled with
> > CONFIG_FB_NVIDIA_I2C enabled, this prevents usage of the nvidia
> > framebuffer on said broken system without recompiling the kernel
> > (or at least the nvidiafb module).
> >
> > Solve the issue by introducing a new boolean module parameter (useedid)
> > which can be set to 0 to prevent the driver from using the EDID
> > information.
> >
> > If this patch is accepted, we can probably get rid of CONFIG_FB_NVIDIA_I2C
> > altogether.
> >
>
> That's a pretty sad solution.  Is it possible to detect these bad cards at
> runtime via ther behaviour?  If not, can we generate a blacklist for the
> known-bad cards based on PCI IDs or something?
>
> Because most users won't even be aware of the module option: they'll just
> know that their card doesn't work right.

This isn't a card problem this is a monitor problem, the card just
passes through the edid data from the monitor... or else the
programming of the card registers from edid is wrong..

Dave.

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
