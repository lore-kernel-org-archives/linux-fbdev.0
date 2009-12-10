From: Bernie Thompson <bernie@plugable.com>
Date: Thu, 10 Dec 2009 19:43:31 +0000
Subject: Re: conflicts between fbcon and user-mode fbdev clients
Message-Id: <480988180912101143p1ab40eebr6bdaa10fe3b194c7@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <480988180912091352v77fa9a12s5077b3211c13586b@mail.gmail.com>
In-Reply-To: <480988180912091352v77fa9a12s5077b3211c13586b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Thu, Dec 10, 2009 at 11:02 AM, James Simmons <jsimmons@infradead.org> wrote:
> That shouldn't happen. In the xorg.conf do you have in the
>
> Option UseFBDev "True"

That option appears to have no effect (have tried both ways).  Do you
know who parses it?  Couldn't find it in core xserver.

The DisplayLink support is still very rough, but it's currently using
its own X server driver
(http://libdlo.freedesktop.org/wiki/xf86-driver-displaylink), which
has some IOCTLs to its framebuffer driver, including a mode setting
IOCTL.

If the arbitration between fbdev clients is intended to happen at the
point of mode setting, rather than at open(), that would explain the
problem.  Are there any old posts or docs which describe how
arbitration is handled for the fbdev driver and multiple clients?

Jaya Kumar has written an alternative DisplayLink fbdev driver that
uses defio and works with the standard fbdev X servers.  That support
will be merged in soon, so then it'll be easy to test what happens
where there's no special mode set paths between X and the framebuffer
driver.

Thanks,
Bernie
