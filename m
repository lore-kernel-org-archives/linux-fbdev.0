From: Rob Herring <robh@kernel.org>
Date: Fri, 18 Nov 2016 18:56:55 +0000
Subject: Re: [PATCHv0 1/1] fbdev: add Intel FPGA FRAME BUFFER driver
Message-Id: <CAL_JsqK2Emqub_JKiXYQUPzxRbws5w=SGUTyZx+qaEExV9V3_A@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1479287278-5192-1-git-send-email-hean.loong.ong@intel.com>
 <20161118140903.q33zx7bk5nergq45@rob-hp-laptop> <20161118141547.465c431e@lxorguk.ukuu.org.uk>
In-Reply-To: <20161118141547.465c431e-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: One Thousand Gnomes <gnomes-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Cc: "Ong, Hean Loong" <hean.loong.ong-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Fri, Nov 18, 2016 at 8:15 AM, One Thousand Gnomes
<gnomes@lxorguk.ukuu.org.uk> wrote:
>> AIUI, we're not taking new FB drivers. This should be a DRM driver
>> instead.
>
> Yes - clone one of the dumb DRM drivers, or if you've got any little bits
> of acceleration (even rolling the display) then it's possibly worth
> accelerating for text mode.
>
>> > +- max-width: The width of the framebuffer in pixels.
>> > +- max-height: The height of the framebuffer in pixels.
>> > +- bits-per-color: only "8" is currently supported
>>
>> These are not h/w properties.
>
> How are the max ones not hardware properties ?

Because the way they are used is setting the mode, not some check of
the max when the mode is set. If this is synthesized for only one
size, then that would be different, but we have bindings for modes.

Rob
