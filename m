From: Timur Tabi <timur@freescale.com>
Date: Mon, 02 May 2011 20:02:57 +0000
Subject: Re: Login prompt on a video console instead of serial port?
Message-Id: <4DBF0DF1.6050207@freescale.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <4DBF065C.3030407@freescale.com>
	<BANLkTikWMksVsvs8KzjdiZfRR-2WGD0Ftw@mail.gmail.com>
In-Reply-To: <BANLkTikWMksVsvs8KzjdiZfRR-2WGD0Ftw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: McClintock Matthew-B29882 <B29882@freescale.com>
Cc: devicetree-discuss <devicetree-discuss@lists.ozlabs.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>

McClintock Matthew-B29882 wrote:
> Don't you have to spawn a terminal on the framebuffer for the login?

I suppose, but I don't know how to do that.  And although that would technically
answer the question in the subject of this thread, I still would have *some*
boot output on the serial port.  It would be nice if I could get all of stdout
on the video display, and all of stdin from the serial port.

> Right now getty spawns the login on the serial port via /etc/inittab.
> Something similiar is probably needed for the framebuffer.

getty appears to work only with serial devices, since it insists on a baud rate
as one of the parameters.

-- 
Timur Tabi
Linux kernel developer at Freescale

