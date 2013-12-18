From: Ingo Molnar <mingo@kernel.org>
Date: Wed, 18 Dec 2013 09:29:41 +0000
Subject: Re: cirrusdrmfb broken with simplefb
Message-Id: <20131218092941.GA19210@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <s5hlhzik3kk.wl%tiwai@suse.de>
 <CANq1E4TFKDduy71jCXy+8CMS1_OFxWEpsHY3AA0RUJPW4VE8hg@mail.gmail.com>
In-Reply-To: <CANq1E4TFKDduy71jCXy+8CMS1_OFxWEpsHY3AA0RUJPW4VE8hg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: David Herrmann <dh.herrmann@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, Stephen Warren <swarren@wwwdotorg.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>


* David Herrmann <dh.herrmann@gmail.com> wrote:

> Hi
>=20
> On Wed, Dec 18, 2013 at 8:42 AM, Takashi Iwai <tiwai@suse.de> wrote:
> > Hi,
> >
> > with the recent enablement of simplefb on x86, cirrusdrmfb on QEMU/KVM
> > gets broken now, as reported at:
> >     https://bugzilla.novell.com/show_bug.cgi?id=855821
> >
> > The cirrus VGA resource is reserved at first as "BOOTFB" in
> > arch/x86/kernel/sysfb_simplefb.c, which is taken by simplefb platform
> > device.  This resource is, however, never released until the platform
> > device is destroyed, and the framebuffer switching doesn't trigger
> > it.  It calls fb's destroy callback, at most.  Then, cirrus driver
> > tries to assign the resource, fails and gives up, resulting in a
> > complete blank screen.
> >
> > The same problem should exist on other KMS drivers like mgag200 or
> > ast, not only cirrus.  Intel graphics doesn't hit this problem just
> > because the reserved iomem by BOOTFB isn't required by i915 driver.
> >
> > The patch below is a quick attempt to solve the issue.  It adds a new
> > API function for releasing resources of platform_device, and call it
> > in destroy op of simplefb.  But, forcibly releasing resources of a
> > parent device doesn't sound like a correct design.  We may take such
> > as a band aid, but definitely need a more fundamental fix.
> >
> > Any thoughts?
>=20
> That bug always existed, simplefb is just the first driver to hit it=20
> (vesafb/efifb didn't use resources). I'm aware of the issue but as a=20
> workaround you can simply disable CONFIG_X86_SYSFB. That restores=20
> the old behavior.

This looks like a regression, so we'll either need a fix or we'll have=20
to mark CONFIG_X86_SYSFB as CONFIG_BROKEN.

> As a proper fix, I'd propose something like:
>   dev =3D platform_find_device("platform-framebuffer");
>   platform_remove_device(dev);
>=20
> And we wrap this as:
>   sysfb_remove_framebuffers()
> in arch/x86/kernel/sysfb.c
>=20
> This should cause a ->remove() event for the platform-driver and
> correctly release the resources. Comments?
> I will try to write a patch and send it later.

A fix would be awesome.

Thanks,

	Ingo
