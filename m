From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 18 Jan 2011 04:36:29 +0000
Subject: Re: [PATCH 1/2] video: nuc900fb: fix compile error
Message-Id: <20110118043628.GG2122@linux-sh.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1295253143.12890.3.camel@mola> <1295253222.12890.4.camel@mola>
	<1295253143.12890.3.camel@mola>
In-Reply-To: <1295253222.12890.4.camel@mola> <1295253143.12890.3.camel@mola>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Mon, Jan 17, 2011 at 04:32:23PM +0800, Axel Lin wrote:
> >From a4bd940fa4d162f95e51e67c7ec4973b1d5b6866 Mon Sep 17 00:00:00 2001
> From: Axel Lin <axel.lin@gmail.com>
> Date: Mon, 17 Jan 2011 16:24:36 +0800
> Subject: [PATCH 1/2] video: nuc900fb: fix compile error
> 
> This patch fixes below compile error:
> 
>   CC      drivers/video/nuc900fb.o
> drivers/video/nuc900fb.c: In function 'nuc900fb_suspend':
> drivers/video/nuc900fb.c:726: error: too few arguments to function 'nuc900fb_stop_lcd'
> drivers/video/nuc900fb.c: In function 'nuc900fb_resume':
> drivers/video/nuc900fb.c:743: error: 'bfinfo' undeclared (first use in this function)
> drivers/video/nuc900fb.c:743: error: (Each undeclared identifier is reported only once
> drivers/video/nuc900fb.c:743: error: for each function it appears in.)
> make[2]: *** [drivers/video/nuc900fb.o] Error 1
> make[1]: *** [drivers/video] Error 2
> make: *** [drivers] Error 2
> 
> Signed-off-by: Axel Lin <axel.lin@gmail.com>

On Mon, Jan 17, 2011 at 04:33:42PM +0800, Axel Lin wrote:
> >From f0064467b1f9696ebcade98ec75ef3fbc6cfe38f Mon Sep 17 00:00:00 2001
> From: Axel Lin <axel.lin@gmail.com>
> Date: Mon, 17 Jan 2011 16:25:57 +0800
> Subject: [PATCH 2/2] video: nuc900fb: properly free resources in nuc900fb_remove
> 
> Signed-off-by: Axel Lin <axel.lin@gmail.com>

Both applied, thanks.
