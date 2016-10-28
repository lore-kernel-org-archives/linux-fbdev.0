From: Julia Lawall <julia.lawall@lip6.fr>
Date: Fri, 28 Oct 2016 20:33:38 +0000
Subject: question about drivers/video/fbdev/auo_k190x.c
Message-Id: <alpine.DEB.2.20.1610282231170.1999@hadrien>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

The file drivers/video/fbdev/auo_k190x.c contains the code:

static DEVICE_ATTR(temp, 0644, temp_show, NULL);

Is it correct to have the permission 0644 and not have a store function?
Should it be 0444 instead?

thanks,
julia
