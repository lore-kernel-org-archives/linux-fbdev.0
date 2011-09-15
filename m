From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Thu, 15 Sep 2011 17:47:12 +0000
Subject: Re: Proposal for a low-level Linux display framework
Message-Id: <4E723A20.2040002@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1316088425.11294.78.camel@lappyti>	<yunboul7sx7.fsf@aiko.keithp.com>	<1316100594.23214.65.camel@deskari>	<yun8vpp7qk7.fsf@aiko.keithp.com>	<4E72320B.6020000@gmx.de> <20110915181802.69ef0d56@lxorguk.ukuu.org.uk>
In-Reply-To: <20110915181802.69ef0d56@lxorguk.ukuu.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Keith Packard <keithp@keithp.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-dev@lists.linaro.org, "Clark, Rob" <rob@ti.com>, Archit Taneja <archit@ti.com>

Hi Alan,

On 09/15/2011 05:18 PM, Alan Cox wrote:
>> is and we could use it. Such attitude is not helpful and as I don't see any
>> serious intention of the DRM guys to cooperate I think those subsystems are more
>> likely to diverge. At least I'll never accept any change to the fb
>> infrastructure that requires DRM.
> 
> There are aspects of the fb code that want changing for DRM (and indeed
> modern hardware) but which won't break for other stuff. Given the move to
> using main memory for video and the need for the OS to do buffer
> management for framebuffers I suspect a move to DRM is pretty much
> inevitable, along with having to fix the fb layer to cope with
> discontiguous framebuffers.

What is your problem with discontigous framebuffers? (I assume discontigous
refers to the pages the framebuffer is composed of)
Sounds to me like you should implement your own fb_mmap and either map it
contigous to screen_base or implement your own fb_read/write.
In theory you could even have each pixel at a completely different memory
location although some userspace wouldn't be happy when it could no longer mmap
the framebuffer.


Best regards,

Florian Tobias Schandinat
