From: Pradeep Subrahmanion <subrahmanion.pradeep@gmail.com>
Date: Thu, 22 Mar 2012 05:57:21 +0000
Subject: Re: [PATCH] Added backlight driver for Acer Aspire 4736
Message-Id: <CABNxG=D-JJgD72Wv3hpui0CiprW25MvBzCKcNt-+twAD72+Eyg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1331608337.2267.67.camel@debian.Gayathri>
	<20120312175130.GA18002@srcf.ucam.org>
	<1331640592.3485.50.camel@debian.Gayathri>
	<20120313124738.GB10822@srcf.ucam.org>
	<CABNxG=Dqg26EHmC3vibf3-SjVhby1qgQfMniQObUeh9eJ6SwEw@mail.gmail.com>
	<20120313133458.GA11574@srcf.ucam.org>
	<1331688294.2577.19.camel@debian.Gayathri>
	<1331680373.10557.169.camel@linux-s257.site>
	<1331692996.3052.8.camel@debian.Gayathri>
	<1331704278.10557.190.camel@linux-s257.site>
	<CABNxG=D3y2GQqS1XN=+B0QRScXpufBkPQtP5-SSNEjSavhtW7g@mail.gmail.com>
	<1331798740.10557.245.camel@linux-s257.site>
	<1332047432.6304.13.camel@debian.Gayathri>
	<1332122514.10557.270.camel@linux-s257.site>
	<1332241764.10557.329.camel@linux-s257.site>
	<1332269710.3921.31.camel@debian.Gayathri>
	<1332298845.10557.343.camel@linux-s257.site>
	<1332356993.3103.23.camel@debian.Gayathri>
	<1332380037.10557.398.camel@linux-s257.site>
	<1332383623.2622.6.camel@debian.Gayathri>
	<1332386725.10557.402.camel@linux-s257.site>
	<1332387122.2622.9.camel@debian.Gayathri>
	<1332388489.10557.406.camel@linux-s257.site>
In-Reply-To: <1332388489.10557.406.camel@linux-s257.site>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: joeyli <jlee@suse.com>
Cc: Matthew Garrett <mjg@redhat.com>, rpurdie@rpsys.net, FlorianSchandinat@gmx.de, akpm@linux-foundation.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

From acer acpi ,I came to know that the 4730 series uses new wmi interface .

http://code.google.com/p/aceracpi/wiki/SupportedHardware

Thanks ,

Pradeep Subrahmanion

On Thu, Mar 22, 2012 at 9:24 AM, joeyli <jlee@suse.com> wrote:
> =A9=F3 =A5|=A1A2012-03-22 =A9=F3 09:02 +0530=A1APradeep Subrahmanion =B4=
=A3=A8=EC=A1G
>> On Thu, 2012-03-22 at 11:25 +0800, joeyli wrote:
>> > =A9=F3 =A5|=A1A2012-03-22 =A9=F3 08:03 +0530=A1APradeep Subrahmanion =
=B4=A3=A8=EC=A1G
>> > > On Thu, 2012-03-22 at 09:33 +0800, joeyli wrote:
>> > > > =A9=F3 =A5|=A1A2012-03-22 =A9=F3 00:39 +0530=A1APradeep Subrahmani=
on =B4=A3=A8=EC=A1G
>> > > > > > This new patch should remove acpi_video0 interface on your mac=
hine.
>> > > > > > Please kindly provide your dmidecode:
>> > > > > >  dmidecode > dmidecode.log
>> > > > > >
>> > > > > > And,
>> > > > > > please make should the patch really applied, you can do a bit =
change on
>> > > > > > pr_info message by yourself.
>> > > > >
>> > > > >    Sorry . I think there was some mistake . I tried the patch ag=
ain. Now
>> > > > > I see only intel_backlight inside /sys/class/backlight. There is=
 no
>> > > > > acer-wmi interface . Is this the expected behavior ? . Or am I m=
issing
>> > > > > anything ?
>> > > > >
>> > > >
>> > > > Yes, this is the expected behavior! But, now I doubt your issue was
>> > > > workaround by acpi_osi=3DLinux but not intel_backlight.
>> > > >
>> > >
>> > > > >
>> > > > >
>> > > > > >
>> > > > > > > echo 5 > /sys/class/backlight/acpi_video0/brightness
>> > > > > > > echo 5 > /sys/class/backlight/intel_backlight/brightness
>> > > > > > >
>> > > > > > > But it doesn't make any change .
>> > > > > > >
>> > > > > > > In my case  , 'acpi_backlight =3D vendor' does not make any =
difference since the hot key control
>> > > > > > >
>> > > > > > > already starts working with 'acpi_osi=3DLinux' option.
>> > > > > > >
>> > > > > > > cat /proc/cmdline gives ,
>> > > > > > >
>> > > > > > > BOOT_IMAGE=3D/boot/vmlinuz-3.3.0+
>> > > > > > > root=3DUUID=F0197a59-c067-4fd8-ad90-c4d721816077 ro acpi_osi=
=3DLinux
>> > > > > > >
>> > > > > > >
>> > > > > > > Thanks ,
>> > > > > > >
>> > > > > > > Pradeep Subrahmanion
>> > > > > > >
>> > > > > >
>> > > > > > OK, that's more clearly, please remove acpi_osi=3DLinux then r=
e-test, I
>> > > > > > think the hotkey of backlight control only works with acpi_osi=
=3DLinux ?
>> > > > > >
>> > > >
>> > > > Does your backlight control still work if you remove acpi_osi=3DLi=
nux ?
>> > >
>> > >    If I remove acpi_osi=3DLinux , the hot key control stops working .
>> > >
>> >
>> > What is the preload OS in your machine when you bought it? Windows XP,
>> > Vista or Windows 7?
>>
>>    It was Windows XP.
>>
>
> The WDDM driver didn't support by Windows XP, the brightness control on
> XP should works with _BCM or OpRegion.
>
> Wonder how does brightness control work on XP with your machine.
>
> I will dig more in your dsdt...
>
>
> Thanks
> Joey Lee
>
