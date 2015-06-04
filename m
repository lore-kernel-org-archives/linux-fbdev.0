From: Alexander Holler <holler@ahsoftware.de>
Date: Thu, 04 Jun 2015 21:03:46 +0000
Subject: Re: [PATCH 00/21] On-demand device registration
Message-Id: <5570BD32.9020705@ahsoftware.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1432565608-26036-1-git-send-email-tomeu.vizoso@collabora.com> <CAF6AEGuOP-3sxDQcNOjVmfP4ue6LmY7KFrj9W75aHKuvZpTFMw@mail.gmail.com>
In-Reply-To: <CAF6AEGuOP-3sxDQcNOjVmfP4ue6LmY7KFrj9W75aHKuvZpTFMw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Rob Clark <robdclark@gmail.com>, Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Mark Rutland <mark.rutland@arm.com>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, linux-usb@vger.kernel.org, linux-pwm@vger.kernel.org, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, Thierry Reding <thierry.reding@gmail.com>, linux-i2c@vger.kernel.org, linux-clk@vger.kernel.org, "moderated list:ARM/S5P EXYNOS AR..." <linux-samsung-soc@vger.kernel.org>, Grant Likely <grant.likely@linaro.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, linux-pm@vger.kernel.org, linux-gpio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, Dan Williams <dan.j.williams@intel.com>, =?UTF-8?B?U3TDqXBoYW5lIE1hcmNoZXNpbg==?= <stephane.marchesin@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

Am 03.06.2015 um 23:12 schrieb Rob Clark:
> On Mon, May 25, 2015 at 10:53 AM, Tomeu Vizoso
> <tomeu.vizoso@collabora.com> wrote:
>> Hello,
>>
>> I have a problem with the panel on my Tegra Chromebook taking longer than
>> expected to be ready during boot (St=C3=A9phane Marchesin reported what =
is
>> basically the same issue in [0]), and have looked into ordered probing a=
s a
>> better way of solving this than moving nodes around in the DT or playing=
 with
>> initcall levels.
>>
>> While reading the thread [1] that Alexander Holler started with his seri=
es to
>> make probing order deterministic, it occurred to me that it should be po=
ssible
>> to achieve the same by registering devices as they are referenced by oth=
er
>> devices.
>>
>> This basically reuses the information that is already implicit in the pr=
obe()
>> implementations, saving us from refactoring existing drivers or adding
>> information to DTBs.
>>
>> Something I'm not completely happy with is that I have had to move the c=
all to
>> of_platform_populate after all platform drivers have been registered.
>> Otherwise I don't see how I could register drivers on demand as we don't=
 have
>> yet each driver's compatible strings.
>>
>> For machs that don't move of_platform_populate() to a later point, these
>> patches shouldn't cause any problems but it's not guaranteed that we'll =
avoid
>> all the deferred probes as some drivers may not be registered yet.
>>
>> I have tested this on boards with Tegra, iMX.6 and Exynos SoCs, and these
>> patches were enough to eliminate all the deferred probes.
>>
>> With this series I get the kernel to output to the panel in 0.5s, instea=
d of 2.8s.
>=20
> So, complete drive-by comment (and I won't claim to be a DT expert,
> etc, etc, so take this with a few grains of salt), but why not push
> the problem to the DT compiler (or a pre-process step that could be
> run on existing DT blobs), which generates an optional DT node that is
> the recommended probe order?  That seems like it avoids adding
> complexity into the early boot code (which seems like a good thing)..

I've played with that approach too (as my patches for dtc do contain the
same code I've put into the kernel, but decided that it doesn't make
much sense. The sort algorithm is really small (some dozen lines), very
fast (around 3-5ms on a omap) and might be later used to sort necessary
module loading too. So there would be no advantage to put a sorted list
into the DT. And having the sort algorithm in the kernel, would make it
possible to use it for acpi or something else too, if they manage it to
provide the necessary dependencies.

Regards,

Alexander Holler

