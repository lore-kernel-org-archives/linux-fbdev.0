From: Hans de Goede <hdegoede@redhat.com>
Date: Wed, 12 Feb 2014 15:12:05 +0000
Subject: Fixing the kernels backlight API
Message-Id: <52FB8F45.9060006@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "xorg-devel-go0+a7rfsptAfugRpC6u6w@public.gmane.org" <xorg-devel-go0+a7rfsptAfugRpC6u6w@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hi All,

Quick self intro: I've been a FOSS developer for 15+ years now and I've been
working for Red Hat for 5 years. Recently I've moved to the graphics team.

One of my first tasks in the graphics team is to make the xserver run without
root rights. I'm making good progress with this, having solved almost all issues
already.

The biggest remaining stumbling block is the backlight API, because opening the
sysfs files requires root rights. I'll very likely write a little helper for this
for now, but in the long run it would be good to have a better solution.

While discussion this in the graphics devroom at Fosdem, the general consensus
seemed to be that the current backlight API is in need of an overhaul anyways.

There are several issues with the current API:
-there is no reliable way to determine the relation between a backlight
 control in sysfs and the display it controls the backlight off
-on many laptops we end up with multiple providers of backlight control
 all battling over control of the same backlight controller through various
 firmware interfaces
-and there is no way to do acl management on it because of sysfs usage

At Fosdem it was suggested to "simply" make the backlight a property of
the connector in drm/kms and let users control it that way. From an acl pov
this makes a ton of sense, if a user controls the other display-panel settings,
then he should be able to control the backlight too.

This also nicely solves the issue of userspace having to figure out which backlight
control to use for a certain output.

Last this makes it the kernels responsibility to figure out which firmware interface
(if any) to use and tie that to the connector, rather then just exporting all of
them, including conflicting ones, and just hoping that userspace will figure things out.

Note that wrt the last point, the kernel is the one which should have all the hardware
knowledge to do this properly, after all hardware abstraction is one of the tasks of
the kernel.

I realize moving this more into the kernel, and tying things into drm is in no means
easy, but it is about time we clean up this mess.

Note that although I'm kicking of this discussion, my focus within the graphics team is
mostly on input devices, so I'm hoping that someone else will pick things up once we've
a better idea of how we would like to solve this.

Regards,

Hans

