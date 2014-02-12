From: David Herrmann <dh.herrmann@gmail.com>
Date: Wed, 12 Feb 2014 22:26:34 +0000
Subject: Re: Fixing the kernels backlight API
Message-Id: <CANq1E4R=UVo5YVPUrdRFeobAE-qU6e-+GHZ2VJwwaa8zEO6g3Q@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <52FB8F45.9060006@redhat.com>
	<CAPM=9tyYLuoTtW69-cPx-JSuar++D5WEtYRZr_-aP7uowZpVyA@mail.gmail.com>
	<20140212204311.GH3891@intel.com>
In-Reply-To: <20140212204311.GH3891@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: =?ISO-8859-1?Q?Ville_Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Jingoo Han <jg1.han@samsung.com>, "xorg-devel@lists.x.org" <xorg-devel@lists.x.org>, dri-devel <dri-devel@lists.freedesktop.org>, Hans de Goede <hdegoede@redhat.com>

Hi

On Wed, Feb 12, 2014 at 9:43 PM, Ville Syrj=E4l=E4
<ville.syrjala@linux.intel.com> wrote:
> On Thu, Feb 13, 2014 at 06:14:04AM +1000, Dave Airlie wrote:
>> >
>> > The biggest remaining stumbling block is the backlight API, because op=
ening the
>> > sysfs files requires root rights. I'll very likely write a little help=
er for this
>> > for now, but in the long run it would be good to have a better solutio=
n.
>> >
>> > While discussion this in the graphics devroom at Fosdem, the general c=
onsensus
>> > seemed to be that the current backlight API is in need of an overhaul =
anyways.
>> >
>> > There are several issues with the current API:
>> > -there is no reliable way to determine the relation between a backlight
>> >  control in sysfs and the display it controls the backlight off
>> > -on many laptops we end up with multiple providers of backlight control
>> >  all battling over control of the same backlight controller through va=
rious
>> >  firmware interfaces
>> > -and there is no way to do acl management on it because of sysfs usage
>> >
>> > At Fosdem it was suggested to "simply" make the backlight a property of
>> > the connector in drm/kms and let users control it that way. From an ac=
l pov
>> > this makes a ton of sense, if a user controls the other display-panel =
settings,
>> > then he should be able to control the backlight too.
>> >
>> > This also nicely solves the issue of userspace having to figure out wh=
ich backlight
>> > control to use for a certain output.
>> >
>> > Last this makes it the kernels responsibility to figure out which firm=
ware interface
>> > (if any) to use and tie that to the connector, rather then just export=
ing all of
>> > them, including conflicting ones, and just hoping that userspace will =
figure things out.
>> >
>> > Note that wrt the last point, the kernel is the one which should have =
all the hardware
>> > knowledge to do this properly, after all hardware abstraction is one o=
f the tasks of
>> > the kernel.
>> >
>> > I realize moving this more into the kernel, and tying things into drm =
is in no means
>> > easy, but it is about time we clean up this mess.
>> >
>> > Note that although I'm kicking of this discussion, my focus within the=
 graphics team is
>> > mostly on input devices, so I'm hoping that someone else will pick thi=
ngs up once we've
>> > a better idea of how we would like to solve this.
>> >
>>
>> I hate to respond with yeah no, but yeah no,
>>
>> http://people.freedesktop.org/~cbrill/dri-log/?channel=3Ddri-devel&show_=
html=3Dtrue&highlight_names=3D&date 14-02-04
>> http://people.freedesktop.org/~cbrill/dri-log/?channel=3Ddri-devel&show_=
html=3Dtrue&highlight_names=3D&date 14-02-05
>>
>> read down that until you see me and tagr talking, read it a few times,
>> and the follow on chat with dvdhrm.
>>
>> The biggest problem with leaving the kernel to pick the correct one,
>> is the kernel simply never knows which is the
>> correct one,
>
> That could be solved by still allowing userspace to change the
> connection between the property and the actual backlight device.
>
> With the prop approach + atomic modeset you could also do some
> slightly fancier things like changing the backlight at the same
> time as doing a modeset or just adjusting some other display
> related properties.

The "attach" stuff actually sounds doable, but who decides which one
to attach? You still need some user-space script during device-plug
for that.
But to be honest, the simplest way would be a "backlightd"
bus-activatable daemon. SetBacklight() then takes a DRM-connector and
brightness-value, which the daemon looks up in /sys and sets.. This
has the advantage that we can do any fancy matching in user-space. We
can provide quirks (maybe even via udev-hwdb) and other helpers for
weird setups.

Cheers
David
