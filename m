From: Bernie Thompson <bernie@plugable.com>
Date: Tue, 16 Aug 2011 16:53:49 +0000
Subject: Re: [PATCH] Add support for SMSC UFX6000/7000 USB display adapters
Message-Id: <CAO1w=s9L9odH3XtAKjGG0-gNKfgqExLGxO1jBsA3NHR-XeRrzg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1313150823-2527-1-git-send-email-steve.glendinning@smsc.com>
In-Reply-To: <1313150823-2527-1-git-send-email-steve.glendinning@smsc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

Hi Florian,

On Tue, Aug 16, 2011 at 3:17 AM, Florian Tobias Schandinat
<FlorianSchandinat@gmx.de> wrote:
>> + * TODO: Propose standard fb.h ioctl for reporting damage,
>> + * using _IOWR() and one of the existing area structs from fb.h
>> + * Consider these ioctls deprecated, but they're still used by the
>> + * DisplayLink X server as yet - need both to be modified in tandem
>> + * when new ioctl(s) are ready.
>> + */
>> +#define UFX_IOCTL_RETURN_EDID =C2=A0 =C2=A0 =C2=A0 =C2=A0(0xAD)
>> +#define UFX_IOCTL_REPORT_DAMAGE =C2=A0 =C2=A0 =C2=A0(0xAA)
>
> Why don't we solve this now? So what do you need?

It would be wonderful to solve this now.  This capability is needed
for any device which doesn't have a directly mmapable hardware
framebuffer (e.g. any USB graphics device, but also remote
framebuffers, devices like eink controllers, etc.)

If we define the standard interface, we'll also modify udlfb (the
DisplayLink driver) to match, so we'll have several clients of the
interface in the tree from day one.

And we also have a patch to the xorg fbdev driver to be a client of
this interface -- to pass X DAMAGE protocol notifications to the
kernel framebuffer, allowing all these devices to work with common
clients (whereas they can't today, without fb_defio or some other
trick to detect framebuffer writes).

Here is the xorg fbdev patch that can be updated to the new interface:
http://git.plugable.com/gitphp/index.php?p=3Dxf86-video-fbdev&a=3Dcommitdif=
f&h=DBfe3f839ee00135a7cccf13db5926fb1019abde

> An IOCTL, a struct like
> struct dloarea {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0int x, y;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0int w, h;
> };
> and I don't think any of the existing structs in fb.h would fit. I'd just=
 prefer
> to have those int's replaced by something of known size, probably __u32 t=
o make
> it consistent with fb_var_screeninfo?

Yes. that'd be perfect.   Could be as simple as

struct fb_rect {
	__u32_t x;
	__u32_t y;
	__u32_t width;
	__u32_t height;
};
#define FBIOPUT_DAMAGE _IOW('F', 0x1A, struct fb_rect)

(with the 1A ordinal being out of date now).  But anything similarly
simple is fine.

> Maybe this should be also reported by the capability field that Laurent's=
 API
> extension will likely add.

Definitely.  In addition to the above, the only other thing needed is
capability negotiation between the fbdev client (say, xorg) and the
fbdev driver.  The negotiation has to be two-step:

The fbdev client tells the driver that it's damage-aware (A)
The fbdev driver returns to the client whether it requires damage (B)

If A and B, then the client will send damage and the driver will rely
on it (and not use fb_defio, timers, or other backup)
If A but not B, then the client should avoid unncessary overhead of
sending damage notifications that the driver isn't listening to.
If not A, then the driver must use fb_defio, timers, or some of the
other (less-efficient) backup mechanisms to make the mmap client's
framebuffer writes get noticed.

Timing: When the driver doesn't have a damage-aware client, they often
fall back to using fb_defio.  fb_defio requires special setup
(framebuffer mmap with pages set to fault on writes), that has
complexities that are best avoided if possible.  So we want step (A)
to happen before mmap, at least, and we should define the API to make
it happen at the earliest point we can define.

You can see the xorg driver patch above, and the smsc and displaylink
drivers doing this today, but in not the prettiest way (as soon as the
driver gets the first damage notification, it tries to stop using
fb_defio).  But an explicit capability negotiation, defined to happen
at the earliest point, would be cleaner.

I don't know Laurent's API.  Do we have the tools in the interface to
do a two-step negotiation to figure out whether (both) client and
driver support this new damage reporting interface?

All the pieces are close. It would be great to get this standardized!
Thanks for stepping in to help lead this.

Best wishes,
Bernie
http://plugable.com/
