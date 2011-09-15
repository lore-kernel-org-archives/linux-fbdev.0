From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 15 Sep 2011 18:04:31 +0000
Subject: Re: Proposal for a low-level Linux display framework
Message-Id: <CADnq5_P+Ubou_geK3Hc8XAkZ4FkyyCib0DJmrzaxfUfH7Oub8g@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1316088425.11294.78.camel@lappyti>
	<yunboul7sx7.fsf@aiko.keithp.com>
	<1316100594.23214.65.camel@deskari>
	<yun8vpp7qk7.fsf@aiko.keithp.com> <4E72320B.6020000@gmx.de>
	<CADnq5_NnzLtJmSzOgyppnBtv96DRTJ71u6ZSrs56KJ-F5CC-mw@mail.gmail.com>
	<CAMuHMdUoYi5xTQz=v1rCycS23vFgQzeZFbNZGnrRN+qkBCrSRA@mail.gmail.com>
In-Reply-To: <CAMuHMdUoYi5xTQz=v1rCycS23vFgQzeZFbNZGnrRN+qkBCrSRA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linaro-dev@lists.linaro.org, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Archit Taneja <archit@ti.com>, linux-fbdev@vger.kernel.org, "Clark, Rob" <rob@ti.com>

On Thu, Sep 15, 2011 at 1:56 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Thu, Sep 15, 2011 at 19:52, Alex Deucher <alexdeucher@gmail.com> wrote:
>> While the DRM has historically targeted 3D acceleration, that is not a
>> requirement to use the DRM KMS modesetting API. =A0The current fb API
>> has no concept of display controllers or connectors or overlays, etc.
>> To match it to modern hardware, it needs a major overhaul. =A0Why create
>> a new modern fb interface that's largely the same as DRM KMS? =A0What if
>> we just consider the KMS API as the new fb API? =A0If there are any
>> inadequacies in the DRM KMS API we would be happy to work out any
>> changes.
>
> I admit I didn't look for it, but does there exist a sample DRM KMS driver
> for dumb frame buffer hardware with one fixed video mode?

Not at the moment.  However, there drivers for AMD, Intel, and nvidia
chips as well patches for a number of ARM SoCs that are in the process
of moving upstream.  Also, Matt Turner wrote a KMS driver for 3D labs
glint hardware that is pretty simple (single display controller,
single DAC, etc.), however it hasn't been merged upstream yet.
http://code.google.com/p/google-summer-of-code-2010-xorg/downloads/detail?n=
ame=3DMatt_Turner.tar.gz&can=3D2&qHis kernel git tree was on kernel.org so =
it's down at the moment,
hence the link to the tarball.

Alex
