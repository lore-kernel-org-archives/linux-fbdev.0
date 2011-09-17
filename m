From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Sat, 17 Sep 2011 18:15:50 +0000
Subject: Re: Proposal for a low-level Linux display framework
Message-Id: <4E74E3D6.8080401@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1316088425.11294.78.camel@lappyti>	<yunboul7sx7.fsf@aiko.keithp.com>	<1316100594.23214.65.camel@deskari>	<yun8vpp7qk7.fsf@aiko.keithp.com>	<4E72320B.6020000@gmx.de>	<CADnq5_NnzLtJmSzOgyppnBtv96DRTJ71u6ZSrs56KJ-F5CC-mw@mail.gmail.com>	<4E724659.5080709@gmx.de>	<20110915195804.4e6d965b@lxorguk.ukuu.org.uk>	<CAMP44s1ywhCV+FaudnwjwJUvj5Cf3_oz1M++kjXxRDGQpJ6-0w@mail.gmail.com>	<CAF6AEGu2-O+2KuCrQPJ6-xejg8TCScrFVZSimgkAV_5Xs-bgkg@mail.gmail.com>	<4E74C6C3.2000704@gmx.de> <CAPM=9twmPVrBPmUuEuTYHSzjDGHtfsmiVX6cozpAFYEaV-NcCg@mail.gmail.com>
In-Reply-To: <CAPM=9twmPVrBPmUuEuTYHSzjDGHtfsmiVX6cozpAFYEaV-NcCg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dave Airlie <airlied@gmail.com>
Cc: Rob Clark <rob@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linaro-dev@lists.linaro.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Archit Taneja <archit@ti.com>, linux-fbdev@vger.kernel.org

On 09/17/2011 04:47 PM, Dave Airlie wrote:
>>
>> I disagree. This depends on the functionality the hardware has, the desired
>> userspace and the manpower one has to do it. And of course if you just want fb
>> having fb via DRM/KMS has some overhead/bloat. It's perfectly okay to have just
>> an fb driver for devices that can't do more anyway.
>> And fb is no legacy interface but actively developed, just with other goals than
>> DRM/KMS is, it aims for stability and to provide a direct interface, not needing
>> any X or wayland crap.
> 
> Stability is a total misnomer, whats worse is you know it. If you just
> want to do software render your whole GUI whether you use KMS or fbdev
> doesn't matter. Instability is only to do with GPU hardware
> acceleration, whether fb or kms expose accel doesn't matter. So less
> attitude please.

Is it? Well, okay, I don't want to use any acceleration that can crash my
machine, where can I select it, preferably as compile time option? I didn't find
such a thing for Intel or Radeon. Don't say, I should rely on userspace here or
use fbdev for this.
The thing is that the core fbdev API does not expose any acceleration to
userspace, maybe some drivers do via IOCTLs, but I hope that are only things
that can be done in a sane way, otherwise I'd consider it a bug. The story is
different for DRM/KMS, as I understand, as this was primarily for acceleration
and only recently got modesetting capabilities.

> fbdev is totally uninteresting for any modern multi-output hardware
> with an acceleration engine, you can't even memory manage the GPU
> memory in any useful way, try resizing the fb console dynamically when
> you've allocated the memory immediately following it in VRAM, you
> can't as userspace has it direct mapped, with no way to remove the
> mappings or repage them. Even now I'm still thinking we should do
> kmscon without exposing the fbdev interface to userspace because the
> whole mmap semantics are totally broken, look at the recent fb
> handover race fixes.

It's true that mmap can be PITA, but I don't see any real alternative given that
you want directly map video memory, especially on low end systems. And there are
ways around it, you can forbid mapping (though probably most userspace wouldn't
like it, I guess) or use any other solution like defio.
If you'd stop exposing the fbdev userspace interface it'd just harden my opinion
that KMS is a piece of trash and that I should avoid hardware that does not have
a native framebuffer driver. I think you shouldn't do this, as it's just a
disadvantage for your end users, but I personally do not really care.


Regards,

Florian Tobias Schandinat
