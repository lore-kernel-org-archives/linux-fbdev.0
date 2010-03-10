From: Michal Suchanek <hramrach@centrum.cz>
Date: Wed, 10 Mar 2010 21:16:53 +0000
Subject: Re: [Linux-fbdev-devel] drm_fb_helper: Impossible to change video
Message-Id: <a5d587fb1003101316q25e95d02w118a009b0d76e420@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <badfd5ba0911200516m55693acbp8fc5164bd6d828cf@mail.gmail.com>
	<21d7e9970911202027l1d4deec6p5750b8425cd6bb3f@mail.gmail.com>
	<a5d587fb1003010118r1b586990ja4144441143bb4be@mail.gmail.com>
	<21d7e9971003022102v232c099r441b0bd843b30313@mail.gmail.com>
	<a5d587fb1003030023l355eab4dtb9f4cd62058dea3e@mail.gmail.com>
	<21d7e9971003030123q2e5d073dj68a81d612e26dc94@mail.gmail.com>
	<a5d587fb1003030232s2c5bf153s5a2b67e47f28a29c@mail.gmail.com>
	<alpine.LFD.2.00.1003101804420.4419@casper.infradead.org>
	<20100310210458.GB4536@sci.fi>
In-Reply-To: <20100310210458.GB4536@sci.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: James Simmons <jsimmons@infradead.org>, Michal Suchanek <hramrach@centrum.cz>, Dave Airlie <airlied@gmail.com>, DRI development list <dri-devel@lists.sourceforge.net>, Paulius

On 10 March 2010 22:04, Ville Syrj=C3=A4l=C3=A4 <syrjala@sci.fi> wrote:
> On Wed, Mar 10, 2010 at 06:11:29PM +0000, James Simmons wrote:
>>
>> > I don't think so. There is another driver which does this -
>> > vesa/uvesa. For these it is not possible to change the resolution from
>> > fbdev, it just provides some framebuffer on top of which fb
>> > applications or fbcons run.
>>
>> Only because that is the only way to do it. The other options was to have
>> x86emul in the kernel. That was not going to happen.
>>
>> > I guess equivalent of xrandr would be what people would want but the
>> > current fbdev capabilities are far from that.
>> > Since KMS provides these capabilities already I would think adding a
>> > tool that manipulates KMS directly (kmset?) is the simplest way.
>>
>> Still would have to deal with the issue of keeping the graphical console
>> in sync with the changes.
>>
>> > There are other drivers that support multihead already (matroxfb, any
>> > other?) and have their own driver-specific inteface.
>>
>> Each crtc is treated as a seperate fbdev device. I don't recall any
>> special ioctls. Maybe for mirroring which was never standardized.
>
> matroxfb does have a bunch of custom ioctls to change the crtc<->output
> mapping. omapfb is another multihead fb driver and it's more complex
> than matroxfb. Trying to make it perform various tricks through the
> fbdev API (and a bunch of custom ioctls, and a bunch of sysfs knobs)
> is something I've been doing but I would not recommend it for anyone
> who has the option of using a better API.
>
> I don't think the CRTC=FB_info makes much sense if the main use
> case is fbcon. fbcon will use a single fb device and so you can't see
> the console on multiple heads anyway which makes the whole thing
> somewhat pointless. And if you're trying to do something more complex
> you will be a lot better off bypassing fbdev altogether.
>

I guess it's also possible that somebody would want the fbdev/fbcons
cover multiple screens. This is not particularly useful with fbcons
(although curses WMs exist) but might be somewhat useful for graphical
fbdev applications.

Multiple views of the kernel virtual consoles on different heads might
be nice toy but it's probably too hard to be worth trying. And there
are always applications like jfbterm which could be perhaps slightly
adapted to use one of the other devices instead of a vc.

Thanks

Michal
