From: Jiri Kosina <jkosina@suse.cz>
Date: Sat, 09 Jan 2010 13:43:12 +0000
Subject: Re: [PATCH] hid: Logitech G13 driver 0.0.3
Message-Id: <alpine.LNX.2.00.1001091441180.7275@pobox.suse.cz>
List-Id: <linux-fbdev.vger.kernel.org>
References: <201001071623.o07GNOB4022157@mustang.cs.nmsu.edu>    <45a44e481001071832q40d6f913w2ccf89c4c45a692a@mail.gmail.com> <5370b38ca0c149470c0e364627c56ee4.squirrel@intranet.cs.nmsu.edu>
In-Reply-To: <5370b38ca0c149470c0e364627c56ee4.squirrel@intranet.cs.nmsu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: "Rick L. Vinyard, Jr." <rvinyard@cs.nmsu.edu>
Cc: Jaya Kumar <jayakumar.lkml@gmail.com>, linux-kernel@vger.kernel.org, felipe.balbi@nokia.com, Pavel Machek <pavel@ucw.cz>, linux-fbdev@vger.kernel.org, krzysztof.h1@wp.pl, Andrew Morton <akpm@linux-foundation.org>, linux-usb@vger.kernel.org, Oliver Neukum <oliver@neukum.org>, linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>

On Thu, 7 Jan 2010, Rick L. Vinyard, Jr. wrote:

> >> +static ssize_t g13_mled_store(struct device *dev,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct devic=
e_attribute *attr,
> >> + =A0 =A0 =A0 =A0const char *buf, size_t count)
> >> +{
> >> + =A0 =A0 =A0 struct hid_device *hdev;
> >> + =A0 =A0 =A0 int i;
> >> + =A0 =A0 =A0 unsigned m[4];
> >> + =A0 =A0 =A0 unsigned mled;
> >> + =A0 =A0 =A0 ssize_t set_result;
> >> +
> >> + =A0 =A0 =A0 /* Get the hid associated with the device */
> >> + =A0 =A0 =A0 hdev =3D container_of(dev, struct hid_device, dev);
> >> +
> >> + =A0 =A0 =A0 /* If we have an invalid pointer we'll return ENODATA */
> >> + =A0 =A0 =A0 if (hdev =3D NULL || &(hdev->dev) !=3D dev)
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODATA;
> >> +
> >> + =A0 =A0 =A0 i =3D sscanf(buf, "%u %u %u %u", m, m+1, m+2, m+3);
> >> + =A0 =A0 =A0 if (!(i =3D 4 || i =3D 1)) {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "unrecognized input: %s"=
, buf);
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -1;
> >> + =A0 =A0 =A0 }
> >> +
> >> + =A0 =A0 =A0 if (i =3D 1)
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mled =3D m[0];
> >> + =A0 =A0 =A0 else
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mled =3D (m[0] ? 1 : 0) | (m[1] ? 2 : 0)=
 |
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (m[2] ? =
4 : 0) | (m[3] ? 8 : 0);
> >> +
> >> + =A0 =A0 =A0 set_result =3D g13_set_mled(hdev, mled);
> >> +
> >> + =A0 =A0 =A0 if (set_result < 0)
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return set_result;
> >> +
> >> + =A0 =A0 =A0 return count;
> >> +}
> >> +
> >> +static DEVICE_ATTR(mled, 0666, g13_mled_show, g13_mled_store);
> >
> > Have you considered the use of the LED class driver as an alternative
> > to introducing these sysfs led controls for the device?
> >
>=20
> I did, but this seemed a simpler approach to let user space (such as a
> daemon) manage the leds. In particular this could be used by a user space
> program to map the keys. The MR led could be used to indicate an active
> record mode, etc.

I finally had some time to go through the driver as well (thanks Dmitry=20
for beating me with proper review).

Could you be more specific about reasons why you are hesitating to use LED =

subsystem instead of the whole mled stuff in the driver?

I don't see anything that couldn't be achieved using LED class.

Thanks,

--=20
Jiri Kosina
SUSE Labs, Novell Inc.
