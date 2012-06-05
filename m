From: Jean Pihet <jean.pihet@newoldbits.com>
Date: Tue, 05 Jun 2012 13:00:29 +0000
Subject: Re: [GIT PULL] OMAP DSS for v3.5
Message-Id: <CAORVsuVu3U9kUgonvZK=JDFcFLJmHqx66PetXJ8KPZRjYX4Bgw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1337681363.4125.10.camel@deskari>
	<CAORVsuXLhGCEHMbZB_8FrzfL-sMH76wMH9rdUjOzOfL06bLH4w@mail.gmail.com>
	<1338899593.4456.6.camel@deskari>
In-Reply-To: <1338899593.4456.6.camel@deskari>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, linux-omap@vger.kernel.org, linux-fbdev <linux-fbdev@vger.kernel.org>, Tony Lindgren <tony@atomide.com>

Hi Tomi,

On Tue, Jun 5, 2012 at 2:33 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrot=
e:
> Hi Jean,
>
> On Tue, 2012-06-05 at 14:17 +0200, Jean Pihet wrote:
>> Hi Tomi,
>
>> I am using a mainline kernel (3.5.0-rc1) with the patches below integrat=
ed.
>> I have an issue with suspend/resume on OMAP3 Beagleboard, where the
>> system hangs at resume time.
>>
>> Here below is a log with the option no_console_suspend set and a few
>> added messages in case of null pointer in _od_resume_noirq.
>> It looks like there is no omap_device associated to the "omapdss_dpi" pd=
ev.
>>
>> What do you think? How to fix this?
>> Sorry I know there have been some discussions on the lists but I am
>> not aware of all the details in the devices creation for DSS.
>>
>> / # echo mem > /sys/power/state
>> [ =A0 23.262298] PM: Syncing filesystems ... done.
>> [ =A0 23.295501] Freezing user space processes ... (elapsed 0.02 seconds=
) done.
>> [ =A0 23.326507] Freezing remaining freezable tasks ... (elapsed 0.02 se=
conds) don
>> e.
>> [ =A0 23.502197] PM: suspend of devices complete after 163.766 msecs
>> [ =A0 23.511932] PM: late suspend of devices complete after 3.418 msecs
>> [ =A0 23.524444] PM: noirq suspend of devices complete after 5.860 msecs
>> [ =A0 23.531249] Disabling non-boot CPUs ...
>> [ =A0 24.476562] Powerdomain (per_pwrdm) didn't enter target state 1
>> [ =A0 24.482818] Powerdomain (core_pwrdm) didn't enter target state 1
>> [ =A0 24.489166] Could not enter target state in pm_suspend
>> [ =A0 24.495147] *** _od_resume_noirq: od=3DNULL, dev=3D0xc78bcc08
>> [ =A0 24.500915] *** _od_resume_noirq: od=3DNULL, pdev=3D0xc78bcc00
>> [ =A0 24.506805] *** _od_resume_noirq: od=3DNULL, pdev->name:omapdss_dpi
>> [ =A0 24.513336] Unable to handle kernel NULL pointer dereference at vir=
tual addre
>> ss 00000018
>> [ =A0 24.521942] pgd =3D c62f0000
>> [ =A0 24.524841] [00000018] *pgd=862c1831, *pte=00000000, *ppte=00000000
>> [ =A0 24.531524] Internal error: Oops: 17 [#1] SMP ARM
>> [ =A0 24.536529] Modules linked in:
>> [ =A0 24.539764] CPU: 0 =A0 =A0Not tainted =A0(3.5.0-rc1-00010-g5041caa-=
dirty #131)
>> [ =A0 24.546844] PC is at _od_resume_noirq+0x1c/0xac
>> [ =A0 24.551635] LR is at _od_resume_noirq+0x94/0xac
>> ...
>
> I'm on leave currently, so I can't test it right now. But can you try
Oh sorry about that!

> the attached patch? Or even better, try merging the tag:
That fixes it! I am able to suspend/resume correctly now.

>
> git://gitorious.org/linux-omap-dss2/linux.git tags/omapdss-for-3.5-rc2
>
> which contains the included patch plus a couple other fixes.
Thanks for the link, that is certainly useful!

Have a nice time on leave ;-p

>
> =A0Tomi
>

Regards,
Jean
