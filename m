From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: atyfb h/vsync polarity
Date: Fri, 22 Jul 2005 12:06:44 +0800
Message-ID: <200507221206.44358.adaplas@gmail.com>
References: <20050622140842.GV20191@midgar.lan.raphnet.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DvpZg-0000Y8-Qc
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 21 Jul 2005 21:55:52 -0700
Received: from rproxy.gmail.com ([64.233.170.198])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1DvpZf-0007zz-Jc
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 21 Jul 2005 21:55:53 -0700
Received: by rproxy.gmail.com with SMTP id a41so142525rng
        for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 21 Jul 2005 21:55:47 -0700 (PDT)
In-Reply-To: <20050622140842.GV20191@midgar.lan.raphnet.net>
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
To: linux-fbdev-devel@lists.sourceforge.net, Raphael Assenat <raph@raphnet.net>

On Wednesday 22 June 2005 22:08, Raphael Assenat wrote:
> Hi,
> I am a Linux Sparc64 user, and recently I decided to switch from 2.4
> kernel series to 2.6 series. Everything worked well, but I had trouble
> getting the framebuffer console to work.
>
> In openboot, my monitor worked perfectly. But as soon as Linux
> configured the framebuffer, my monitor would loose sync. I compared the
> output given by fbset on the working configuration (2.4 kernel) and the
> non-working configuration (2.6.12 kernel). Every setting was identical,
> except that the output on 2.4 had 'hsync high'. I tried 'fbset -hsync
> high', but the screen still did not sync, and fbset still did not report
> 'hsync high', as if the setting was ignored.
>
> After digging a little bit, I found this in
> drivers/video/aty/atyfb_base.c:
>
> if(vdisplay < 400) {
> 		h_sync_pol = 1;
> 		v_sync_pol = 0;
> } else if(vdisplay < 480) {
> 		h_sync_pol = 0;
> 		v_sync_pol = 1;
> } else if(vdisplay < 768) {
> 		h_sync_pol = 0;
> 		v_sync_pol = 0;
> } else {
> 		h_sync_pol = 1;
> 		v_sync_pol = 1;
> }
>

I also believe that the above code is not needed.  The appropriate
sync signals are already correctly set (hopefully) from the entries
in the mode database, kernel or user.

Also, if I remember the VGA standards correctly, hsync and vsync
should be high if vyres > 400.

Tony



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
