From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Thu, 15 Sep 2011 17:18:02 +0000
Subject: Re: Proposal for a low-level Linux display framework
Message-Id: <20110915181802.69ef0d56@lxorguk.ukuu.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1316088425.11294.78.camel@lappyti>
	<yunboul7sx7.fsf@aiko.keithp.com>
	<1316100594.23214.65.camel@deskari>
	<yun8vpp7qk7.fsf@aiko.keithp.com> <4E72320B.6020000@gmx.de>
In-Reply-To: <4E72320B.6020000@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: linaro-dev@lists.linaro.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Archit Taneja <archit@ti.com>, "Clark, Rob" <rob@ti.com>

> is and we could use it. Such attitude is not helpful and as I don't see any
> serious intention of the DRM guys to cooperate I think those subsystems are more
> likely to diverge. At least I'll never accept any change to the fb
> infrastructure that requires DRM.

There are aspects of the fb code that want changing for DRM (and indeed
modern hardware) but which won't break for other stuff. Given the move to
using main memory for video and the need for the OS to do buffer
management for framebuffers I suspect a move to DRM is pretty much
inevitable, along with having to fix the fb layer to cope with
discontiguous framebuffers.

Alan
