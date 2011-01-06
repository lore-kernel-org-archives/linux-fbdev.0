From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 06 Jan 2011 06:35:32 +0000
Subject: Re: [PATCH] Corrected matroxfb video option in comments and kernel config help.
Message-Id: <20110106063532.GA15340@linux-sh.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <AANLkTikqCduraRjVvtaU3u1ikQyR-3GryovdTMe-z5HD@mail.gmail.com>
In-Reply-To: <AANLkTikqCduraRjVvtaU3u1ikQyR-3GryovdTMe-z5HD@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Tue, Dec 28, 2010 at 11:03:50AM +0100, Vicente Jim?nez wrote:
> From 81561bbf722613794c77cd03c537f4139b2d0976 Mon Sep 17 00:00:00 2001
> From: Vicente Jimenez Aguilar <googuy@gmail.com>
> Date: Tue, 28 Dec 2010 11:35:24 +0100
> Subject: [PATCH 2/2] Corrected matroxfb video option in comments and kernel config help.
> 
> Configuring the kernel I found that the Matrox frame buffer help has a
> different option than the one in the docs (Documentation/fb/matroxfb.txt).
> I decided to check the source code to see what is the correct option.
> drivers/video/matrox/matroxfb_base.c has a lot of comments that sugests
> that the video option is "matrox".
> However in line 2452 of this same file you have:
> fb_get_options("matroxfb", &option)
> 
> video=matroxfb:XXX is the correct video option not video=matrox:XXX.

Missing Signed-off-by.
