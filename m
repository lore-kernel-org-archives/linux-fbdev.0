From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: framebuffer ioctl
Date: Mon, 6 Sep 2004 17:02:20 -0400
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <9e4733910409061402372095b1@mail.gmail.com>
References: <Pine.GSO.4.58.0409041304080.3434@waterleaf.sonytel.be>
	 <413A3735.9E7D2F11@orpatec.ch> <413B4925.5000706@comcast.net>
	 <200409060926.07163.adaplas@hotpop.com> <413CC0EA.8070709@comcast.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C4Qd3-0003w9-Oq
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 06 Sep 2004 14:02:21 -0700
Received: from rproxy.gmail.com ([64.233.170.206] helo=mproxy.gmail.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1C4Qd3-00016s-6V
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 06 Sep 2004 14:02:21 -0700
Received: by mproxy.gmail.com with SMTP id 76so144301rnl
        for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 06 Sep 2004 14:02:20 -0700 (PDT)
In-Reply-To: <413CC0EA.8070709@comcast.net>
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
To: linux-fbdev-devel@lists.sourceforge.net

On Mon, 06 Sep 2004 12:56:26 -0700, Zack <plinius@comcast.net> wrote:
> I think you may be misinterpreting my intent. I am strictly anti-bloat,
> so I don't want a larger kernel. By the same token, I don't use
> X because it is bloated--X uses 16 megs minimum on my system,
> and that is very much not to my taste.

Mesa-solo is not X it is the OpenGL layer. mesa-solo runs standalone
without needing X. Using mesa-solo will give you access the full
acceleration capabilities of many chip families - i810, i830, i915,
radeon, r128, mga, sis, ffb, tdfx.  Nvidia is not supported because
the hardware documentation is secret. There is also a mode for
building an embedded version of mesa-solo which removes about 50% of
the OpenGL functions and makes it smaller if that is really a problem.

Check out the Cairo benchmarks. The OpenGL drivers can beat the
performance of 2D drivers 100:1 and some cases 400:1. OpenGL uses the
GPU to do the drawing instead of the main CPU.

Writing fully accelerated drivers is very complicated and it takes
years of work.

-- 
Jon Smirl
jonsmirl@gmail.com


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
