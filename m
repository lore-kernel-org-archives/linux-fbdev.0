From: James Simmons <jsimmons@infradead.org>
Date: Wed, 10 Mar 2010 18:11:29 +0000
Subject: Re: [Linux-fbdev-devel] drm_fb_helper: Impossible to change video
Message-Id: <alpine.LFD.2.00.1003101804420.4419@casper.infradead.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <badfd5ba0911200516m55693acbp8fc5164bd6d828cf@mail.gmail.com>
	<21d7e9970911202027l1d4deec6p5750b8425cd6bb3f@mail.gmail.com>
	<a5d587fb1003010118r1b586990ja4144441143bb4be@mail.gmail.com>
	<21d7e9971003022102v232c099r441b0bd843b30313@mail.gmail.com>
	<a5d587fb1003030023l355eab4dtb9f4cd62058dea3e@mail.gmail.com>
	<21d7e9971003030123q2e5d073dj68a81d612e26dc94@mail.gmail.com>
	<a5d587fb1003030232s2c5bf153s5a2b67e47f28a29c@mail.gmail.com>
In-Reply-To: <a5d587fb1003030232s2c5bf153s5a2b67e47f28a29c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michal Suchanek <hramrach@centrum.cz>
Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>, DRI development list <dri-devel@lists.sourceforge.net>, Paulius Zaleckas <paulius.zaleckas@gmail.com>


> I don't think so. There is another driver which does this -
> vesa/uvesa. For these it is not possible to change the resolution from
> fbdev, it just provides some framebuffer on top of which fb
> applications or fbcons run.

Only because that is the only way to do it. The other options was to have 
x86emul in the kernel. That was not going to happen.
 
> I guess equivalent of xrandr would be what people would want but the
> current fbdev capabilities are far from that.
> Since KMS provides these capabilities already I would think adding a
> tool that manipulates KMS directly (kmset?) is the simplest way.

Still would have to deal with the issue of keeping the graphical console 
in sync with the changes.
 
> There are other drivers that support multihead already (matroxfb, any
> other?) and have their own driver-specific inteface.

Each crtc is treated as a seperate fbdev device. I don't recall any 
special ioctls. Maybe for mirroring which was never standardized.

> Designing an unified multihead fbdev extension interface would
> probably take quite a bit of typing and time. It would also help to
> have something working to compare to.

IMNSHO the fbdev to ctrc mapping should be the standard way to 
handle the fbdev layer. Plus it is a KISS approach. Mirroring would need 
to be finally dealt with.
