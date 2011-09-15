From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Thu, 15 Sep 2011 19:46:36 +0000
Subject: Re: Proposal for a low-level Linux display framework
Message-Id: <4E72561C.7060603@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1316088425.11294.78.camel@lappyti>	<yunboul7sx7.fsf@aiko.keithp.com>	<1316100594.23214.65.camel@deskari>	<yun8vpp7qk7.fsf@aiko.keithp.com>	<4E72320B.6020000@gmx.de>	<20110915181802.69ef0d56@lxorguk.ukuu.org.uk>	<4E723A20.2040002@gmx.de>
	<20110915200514.74bdcd90@lxorguk.ukuu.org.uk>
In-Reply-To: <20110915200514.74bdcd90@lxorguk.ukuu.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linaro-dev@lists.linaro.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Archit Taneja <archit@ti.com>, "Clark, Rob" <rob@ti.com>

On 09/15/2011 07:05 PM, Alan Cox wrote:
>> What is your problem with discontigous framebuffers? (I assume discontigous
>> refers to the pages the framebuffer is composed of)
>> Sounds to me like you should implement your own fb_mmap and either map it
>> contigous to screen_base or implement your own fb_read/write.
>> In theory you could even have each pixel at a completely different memory
>> location although some userspace wouldn't be happy when it could no longer mmap
>> the framebuffer.
> 
> The mmap side is trivial, the problem is that the fb layer default
> implementations of blits, fills etc only work on a kernel linear frame
> buffer. And (for example) there is not enough linear stolen memory on
> some Intel video for a 1080p console on HDMI even though the hardware is
> perfectly capable of using an HDTV as its monitor. Nor - on a 32bit box-
> is there enough space to vremap it.

Okay, I see your problem. It's a bit strange you don't have acceleration. I
guess you need either your own implementation of those or adding function
pointers like fb_read/write just without the __user and use those instead of
direct memory access in the cfb* implementation if screen_base is NULL. Does not
sound like a big problem to me, but pretty inefficient, so probably copying the
existing ones and adjusting it to your needs would be preferred (just like the
sys* implementations exist).


Best regards,

Florian Tobias Schandinat
