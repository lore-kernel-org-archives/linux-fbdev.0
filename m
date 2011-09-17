From: Rob Clark <rob@ti.com>
Date: Sat, 17 Sep 2011 16:50:57 +0000
Subject: Re: Proposal for a low-level Linux display framework
Message-Id: <CAF6AEGuuv4sDJbwHpYGUUsX36gFBcfH_Pa+t57ifvwdON3PP-Q@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1316088425.11294.78.camel@lappyti>
	<yunboul7sx7.fsf@aiko.keithp.com>
	<1316100594.23214.65.camel@deskari>
	<yun8vpp7qk7.fsf@aiko.keithp.com>
	<4E72320B.6020000@gmx.de>
	<CADnq5_NnzLtJmSzOgyppnBtv96DRTJ71u6ZSrs56KJ-F5CC-mw@mail.gmail.com>
	<4E724659.5080709@gmx.de>
	<20110915195804.4e6d965b@lxorguk.ukuu.org.uk>
	<CAMP44s1ywhCV+FaudnwjwJUvj5Cf3_oz1M++kjXxRDGQpJ6-0w@mail.gmail.com>
	<CAF6AEGu2-O+2KuCrQPJ6-xejg8TCScrFVZSimgkAV_5Xs-bgkg@mail.gmail.com>
	<4E74C6C3.2000704@gmx.de>
In-Reply-To: <4E74C6C3.2000704@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: linux-fbdev@vger.kernel.org, linaro-dev@lists.linaro.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Archit Taneja <archit@ti.com>

On Sat, Sep 17, 2011 at 11:11 AM, Florian Tobias Schandinat
<FlorianSchandinat@gmx.de> wrote:
> On 09/17/2011 03:16 PM, Rob Clark wrote:
>>>From userspace perspective, fbdev doesn't go away. =A0It is just a
>> legacy interface provided on top of DRM/KMS driver mostly via helper
>> functions. =A0With this approach, you get the richer KMS API (and all
>> the related plumbing for hotplug, EDID parsing, multi-head support,
>> flipping, etc) for userspace stuff that needs that, but can keep the
>> fbdev userspace interface for legacy apps. =A0It is the best of both
>> worlds. =A0There isn't really any good reason to propagate standalone
>> fbdev driver anymore.
>
> I disagree. This depends on the functionality the hardware has, the desir=
ed
> userspace and the manpower one has to do it. And of course if you just wa=
nt fb
> having fb via DRM/KMS has some overhead/bloat. It's perfectly okay to hav=
e just
> an fb driver for devices that can't do more anyway.
> And fb is no legacy interface but actively developed, just with other goa=
ls than
> DRM/KMS is, it aims for stability and to provide a direct interface, not =
needing
> any X or wayland crap.

Hmm, for simple enough devices, maybe fb is fine.. but if you are
covering a range of devices which include stuff with more
sophisticated userspace (X/wayland), then just doing DRM/KMS and using
the DRM fbdev helpers, vs doing both DRM/KMS and standalone fbdev..
well that seems like a no-brainer.

I still think, if you are starting a new driver, you should just go
ahead and use DRM/KMS.. a simple DRM/KMS driver that doesn't support
all the features is not so complex, and going this route future-proofs
you better when future generations of hardware gain more capabilities
and sw gain more requirements.

BR,
-R

>
> Best regards,
>
> Florian Tobias Schandinat
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> http://lists.freedesktop.org/mailman/listinfo/dri-devel
>
