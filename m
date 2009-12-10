From: James Simmons <jsimmons@infradead.org>
Date: Thu, 10 Dec 2009 19:02:37 +0000
Subject: Re: conflicts between fbcon and user-mode fbdev clients
Message-Id: <alpine.LFD.2.00.0912101852180.7053@casper.infradead.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <480988180912091352v77fa9a12s5077b3211c13586b@mail.gmail.com>
In-Reply-To: <480988180912091352v77fa9a12s5077b3211c13586b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org


> Hi fbdevs,
> 
> This is probably a FAQ, but I haven't found the answer.
> 
> What (if anything) should a driver be doing to prevent fbcon and other
> clients (e.g. X, etc.) from simultaneously opening and rendering to
> the framebuffer?
> 
> Running a USB graphics device using the udlfb framebuffer driver
> (in the staging tree of 2.6.32), a common problem is fbcon
> automatically opens the first available framebuffer device (/dev/fb0).
>  Then when the user loads an X server, both the X server and fbcon
> continue to merrily render to the device, overwriting each other.
> 
> So, typically, the udlfb driver will see this sequence at boot (with
> the xf-video-displaylink X server):
> fb_open(user = 0)  fbcon opening the framebuffer
> fb_open(user = 1)  X opening the framebuffer
> fb_open(user = 1)  Another instance of X opening framebuffer
> * X and fbcon both render to the framebuffer, causing a mess *
> And then any calls to release() later.

That shouldn't happen. In the xorg.conf do you have in the 

Option UseFBDev "True"


