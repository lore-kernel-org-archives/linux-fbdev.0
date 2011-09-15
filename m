From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Thu, 15 Sep 2011 19:05:14 +0000
Subject: Re: Proposal for a low-level Linux display framework
Message-Id: <20110915200514.74bdcd90@lxorguk.ukuu.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1316088425.11294.78.camel@lappyti>
	<yunboul7sx7.fsf@aiko.keithp.com>
	<1316100594.23214.65.camel@deskari>
	<yun8vpp7qk7.fsf@aiko.keithp.com> <4E72320B.6020000@gmx.de>
	<20110915181802.69ef0d56@lxorguk.ukuu.org.uk>
	<4E723A20.2040002@gmx.de>
In-Reply-To: <4E723A20.2040002@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: linaro-dev@lists.linaro.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Archit Taneja <archit@ti.com>, "Clark, Rob" <rob@ti.com>

> What is your problem with discontigous framebuffers? (I assume discontigous
> refers to the pages the framebuffer is composed of)
> Sounds to me like you should implement your own fb_mmap and either map it
> contigous to screen_base or implement your own fb_read/write.
> In theory you could even have each pixel at a completely different memory
> location although some userspace wouldn't be happy when it could no longer mmap
> the framebuffer.

The mmap side is trivial, the problem is that the fb layer default
implementations of blits, fills etc only work on a kernel linear frame
buffer. And (for example) there is not enough linear stolen memory on
some Intel video for a 1080p console on HDMI even though the hardware is
perfectly capable of using an HDTV as its monitor. Nor - on a 32bit box-
is there enough space to vremap it.

Alan
