From: Pradeep Subrahmanion <subrahmanion.pradeep@gmail.com>
Date: Tue, 13 Mar 2012 13:41:35 +0000
Subject: Re: [PATCH] Added backlight driver for Acer Aspire 4736
Message-Id: <CABNxG=DswuqLOqe0qO0=tPdzZnX0paZ1JEcTv_vu-9GtyX25Lg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1331608337.2267.67.camel@debian.Gayathri>
	<20120312175130.GA18002@srcf.ucam.org>
	<1331640592.3485.50.camel@debian.Gayathri>
	<20120313124738.GB10822@srcf.ucam.org>
In-Reply-To: <20120313124738.GB10822@srcf.ucam.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Matthew Garrett <mjg@redhat.com>
Cc: rpurdie@rpsys.net, FlorianSchandinat@gmx.de, akpm@linux-foundation.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

I tried giving acpi_backlight =3D vendor . In that case hot key for
brightness control is working. But i think=A0 , it is not calculating
the correct value for brightness because increasing brightness after
maximum level gives blank screen .

=A0I also had tried 'acpi_backlight =3D acer_wmi' as the boot parameter
earlier . In that case=A0 , the driver cannot find any acpi_wmi device
(showed error while booting).

By ' ACPI interface' , I mean 'acpi_video0' inside the
/sys/class/backlight. I havn't tried the /sys/class/backlight
interface directly . I will try that also.

Thanks ,

Pradeep Subrahmanion.

On Tue, Mar 13, 2012 at 6:17 PM, Matthew Garrett <mjg@redhat.com> wrote:
>
> On Tue, Mar 13, 2012 at 08:09:52AM -0400, Pradeep Subrahmanion wrote:
> > Before taking this approach , I had a look at the WMI interface.But I f=
ound from acer-acpi site that , the 4730 series
> > is using new WMI interface which needs to be reverse engineered.
> > As far as =A0acpi interface is concerned , by default it is not at all =
causing any change in brightness.
> > When 'acpi_osi=3DLinux' was added to the boot grub config , the brightn=
ess control with hot key started to work .
> > But it was not changing to correct values. Increasing brightness after =
maximum level gives blank screen.
>
> That page was last updated in 2009. Have you tried the current acer-wmi
> code? You'd probably need to pass backlight=3Dvendor if there's a
> non-working ACPI interface.
>
> When you say the ACPI interface doesn't work, what do you mean? Have you
> tried using the /sys/class/backlight interface directly?
>
> --
> Matthew Garrett | mjg59@srcf.ucam.org
