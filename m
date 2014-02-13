From: Hans de Goede <hdegoede@redhat.com>
Date: Thu, 13 Feb 2014 13:57:44 +0000
Subject: Re: Fixing the kernels backlight API
Message-Id: <52FCCF58.1090406@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <52FB8F45.9060006@redhat.com>	<CAPM=9tyYLuoTtW69-cPx-JSuar++D5WEtYRZr_-aP7uowZpVyA@mail.gmail.com>	<20140212204311.GH3891@intel.com>
	<CANq1E4R=UVo5YVPUrdRFeobAE-qU6e-+GHZ2VJwwaa8zEO6g3Q@mail.gmail.com>
	<52FC683F.10905@gmail.com>
In-Reply-To: <52FC683F.10905-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Alexander E. Patrakov" <patrakov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Herrmann <dh.herrmann-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, =?ISO-8859-1?Q?Ville_Syrj=E4l=E4?= <ville.syrjala-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Linux Fbdev development list <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "xorg-devel-go0+a7rfsptAfugRpC6u6w@public.gmane.org" <xorg-devel-go0+a7rfsptAfugRpC6u6w@public.gmane.org>, dri-devel <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

Hi,

On 02/13/2014 07:37 AM, Alexander E. Patrakov wrote:
> 13.02.2014 04:26, David Herrmann wrote:
>> The "attach" stuff actually sounds doable, but who decides which one
>> to attach? You still need some user-space script during device-plug
>> for that.
>> But to be honest, the simplest way would be a "backlightd"
>> bus-activatable daemon. SetBacklight() then takes a DRM-connector and
>> brightness-value, which the daemon looks up in /sys and sets.. This
>> has the advantage that we can do any fancy matching in user-space. We
>> can provide quirks (maybe even via udev-hwdb) and other helpers for
>> weird setups.
> 
> What would be done with Samsung monitors (like an old SyncMaster 770P) that have a DVI connection, no physical buttons and have to be controlled via DDC-CI? Currently, ddccontrol works (via /dev/i2c-*), but only from root. I would like this use case to be covered in such a way that it could work both in Xorg and in Wayland, and, if possible, without races related to i2c usage from the kernel and from userspace.

The nice thing about having a userspace daemon for this is that we can
actually add some support for DCC-CI too.

WRT races between user and kernelspace, those can be avoided by using
the I2C_RDWR ioctl, in this case you can specify multipel i2c writes /
reads which will all get executed as one transaction, note this
assumes that the protocol supports repeated START conditions,
if it needs a STOP condition and still needs everything to be in
one transaction, then things become trickier. This also assumes
that the i2c controller driver used supports I2C_FUNC_I2C

Regards,

Hans
