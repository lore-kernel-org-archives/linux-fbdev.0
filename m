From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Tue, 17 Jul 2012 11:24:49 +0000
Subject: Re: dma-buf/fbdev: one-to-many support
Message-Id: <20120717122449.07489b50@pyramind.ukuu.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CANq1E4SbippxHHTaqLhpGjJLG12y94kWUFdB7P_EAG14o50vrQ@mail.gmail.com>
	<1497600.3Qx4Vx9if4@avalon>
In-Reply-To: <1497600.3Qx4Vx9if4@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: David Herrmann <dh.herrmann@googlemail.com>, linux-fbdev@vger.kernel.org, Sumit Semwal <sumit.semwal@linaro.org>, dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org

> The main issue is that fbdev has been designed with the implicit assumption 
> that an fbdev driver will always own the graphics memory it uses. All 
> components in the stack, from drivers to applications, have been designed 
> around that assumption.
> 
> We could of course fix this, revamp the fbdev API and turn it into a modern 
> graphics API, but I really wonder whether it would be worth it. DRM has been 
> getting quite a lot of attention lately, especially from embedded developers 
> and vendors, and the trend seems to me like the (Linux) world will gradually 
> move from fbdev to DRM.
> 
> Please feel free to disagree :-)

I would disagree on the "main issue" bit. All the graphics cards have
their own formats and cache management rules. Simply sharing a buffer
doesn't work - which is why all of the extra gloop will be needed.

Alan
