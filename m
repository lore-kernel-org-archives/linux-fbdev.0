From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Date: Mon, 07 Sep 2020 10:29:22 +0000
Subject: Re: [PATCH v1 0/2] video: fbdev: radeonfb: PCI PM framework upgrade and fix-ups.
Message-Id: <5ea9e575-e2ba-1f12-4894-3c0d271ea294@daenzer.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200806072256.585705-1-vaibhavgupta40@gmail.com>
 <20200907075559.GN2352366@phenom.ffwll.local>
In-Reply-To: <20200907075559.GN2352366@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Vaibhav Gupta <vaibhavgupta40@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Shuah Khan <skhan@linuxfoundation.org>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Bjorn Helgaas <bjorn@helgaas.com>, Thierry Reding <thierry.reding@gmail.com>, Bjorn Helgaas <helgaas@kernel.org>, Vaibhav Gupta <vaibhav.varodek@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, Thierry Reding <treding@nvidia.com>, linux-kernel-mentees@lists.linuxfoundation.org

On 2020-09-07 9:55 a.m., Daniel Vetter wrote:
> On Thu, Aug 06, 2020 at 12:52:54PM +0530, Vaibhav Gupta wrote:
>> Linux Kernel Mentee: Remove Legacy Power Management.
>>
>> The original goal of the patch series is to upgrade the power management
>> framework of radeonfb fbdev driver. This has been done by upgrading .sus=
pend()
>> and .resume() callbacks.
>>
>> The upgrade makes sure that the involvement of PCI Core does not change =
the
>> order of operations executed in a driver. Thus, does not change its beha=
vior.
>>
>> During this process, it was found that "#if defined(CONFIG_PM)" at line =
1434 is
>> redundant. This was introduced in the commit
>> 42ddb453a0cd ("radeon: Conditionally compile PM code").
>=20
> I do wonder whether it wouldn't be better to just outright delete these,
> we have the drm radeon driver for pretty much all the same hardware ...

In contrast to radeonfb, the radeon driver doesn't support=20
suspend-to-RAM on Apple PowerPC notebooks.


--=20
Earthling Michel D=C3=A4nzer               |               https://redhat.c=
om
Libre software enthusiast             |             Mesa and X developer
