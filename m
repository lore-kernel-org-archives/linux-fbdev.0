From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Tue, 16 Aug 2011 17:32:15 +0000
Subject: Re: [PATCH] Add support for SMSC UFX6000/7000 USB display adapters
Message-Id: <4E4AA99F.8050403@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1313150823-2527-1-git-send-email-steve.glendinning@smsc.com>
In-Reply-To: <1313150823-2527-1-git-send-email-steve.glendinning@smsc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

Hi Bernie,

On 08/16/2011 04:53 PM, Bernie Thompson wrote:
> Hi Florian,
>=20
> On Tue, Aug 16, 2011 at 3:17 AM, Florian Tobias Schandinat
> <FlorianSchandinat@gmx.de> wrote:
>>> + * TODO: Propose standard fb.h ioctl for reporting damage,
>>> + * using _IOWR() and one of the existing area structs from fb.h
>>> + * Consider these ioctls deprecated, but they're still used by the
>>> + * DisplayLink X server as yet - need both to be modified in tandem
>>> + * when new ioctl(s) are ready.
>>> + */
>>> +#define UFX_IOCTL_RETURN_EDID        (0xAD)
>>> +#define UFX_IOCTL_REPORT_DAMAGE      (0xAA)
>>
>> Why don't we solve this now? So what do you need?
>=20
> It would be wonderful to solve this now.  This capability is needed
> for any device which doesn't have a directly mmapable hardware
> framebuffer (e.g. any USB graphics device, but also remote
> framebuffers, devices like eink controllers, etc.)
>=20
> If we define the standard interface, we'll also modify udlfb (the
> DisplayLink driver) to match, so we'll have several clients of the
> interface in the tree from day one.
>=20
> And we also have a patch to the xorg fbdev driver to be a client of
> this interface -- to pass X DAMAGE protocol notifications to the
> kernel framebuffer, allowing all these devices to work with common
> clients (whereas they can't today, without fb_defio or some other
> trick to detect framebuffer writes).
>=20
> Here is the xorg fbdev patch that can be updated to the new interface:
> http://git.plugable.com/gitphp/index.php?p=3Dxf86-video-fbdev&a=3Dcommitd=
iff&h=DBfe3f839ee00135a7cccf13db5926fb1019abde
>=20
>> An IOCTL, a struct like
>> struct dloarea {
>>        int x, y;
>>        int w, h;
>> };
>> and I don't think any of the existing structs in fb.h would fit. I'd jus=
t prefer
>> to have those int's replaced by something of known size, probably __u32 =
to make
>> it consistent with fb_var_screeninfo?
>=20
> Yes. that'd be perfect.   Could be as simple as
>=20
> struct fb_rect {
> 	__u32_t x;
> 	__u32_t y;
> 	__u32_t width;
> 	__u32_t height;
> };
> #define FBIOPUT_DAMAGE _IOW('F', 0x1A, struct fb_rect)
>=20
> (with the 1A ordinal being out of date now).  But anything similarly
> simple is fine.

Yes, I think we can add this to fb.h without any problems.

>> Maybe this should be also reported by the capability field that Laurent'=
s API
>> extension will likely add.
>=20
> Definitely.  In addition to the above, the only other thing needed is
> capability negotiation between the fbdev client (say, xorg) and the
> fbdev driver.  The negotiation has to be two-step:
>=20
> The fbdev client tells the driver that it's damage-aware (A)
> The fbdev driver returns to the client whether it requires damage (B)
>=20
> If A and B, then the client will send damage and the driver will rely
> on it (and not use fb_defio, timers, or other backup)
> If A but not B, then the client should avoid unncessary overhead of
> sending damage notifications that the driver isn't listening to.
> If not A, then the driver must use fb_defio, timers, or some of the
> other (less-efficient) backup mechanisms to make the mmap client's
> framebuffer writes get noticed.
>=20
> Timing: When the driver doesn't have a damage-aware client, they often
> fall back to using fb_defio.  fb_defio requires special setup
> (framebuffer mmap with pages set to fault on writes), that has
> complexities that are best avoided if possible.  So we want step (A)
> to happen before mmap, at least, and we should define the API to make
> it happen at the earliest point we can define.
>=20
> You can see the xorg driver patch above, and the smsc and displaylink
> drivers doing this today, but in not the prettiest way (as soon as the
> driver gets the first damage notification, it tries to stop using
> fb_defio).  But an explicit capability negotiation, defined to happen
> at the earliest point, would be cleaner.

What's the problem with the way you do it now? (aside that you should IMHO =
reset
the flag whether the client does use damage or not on set_par/mode change)
The extension I proposed and is part of Laurent's patches is a capability
reporting from the driver to the client, that would solve (B). Sure we could
think of anything to make the other way (A) possible but I doubt that it wo=
uld
be worth it as I think you have to keep defio support around anyway for
applications that do not support damage reporting. I think implementing (A)
would just needlessly add complexity to the drivers as it would be some sor=
t of
alternative mmap IOCTL. Or we could try to find yet another flag inside var=
 that
is unused for it but that is difficult.

> All the pieces are close. It would be great to get this standardized!
> Thanks for stepping in to help lead this.

Sure, all the nice features will just be used if they are easy usable from =
user
space, so providing an API instead of requiring user space to know individu=
al
drivers is a good thing.


Best regards,

Florian Tobias Schandinat
