From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 20 Mar 2012 21:40:46 +0000
Subject: Re: Howto consolidate xgifb (staging) with sisfb
Message-Id: <CADnq5_MmHAzawm2eZTWO28F8Z5kh4KrjVZpi-Z9gR-f_ZpsGAA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <201203200002.40429.PeterHuewe@gmx.de>
In-Reply-To: <201203200002.40429.PeterHuewe@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

On Tue, Mar 20, 2012 at 5:06 PM, Aaro Koskinen <aaro.koskinen@iki.fi> wrote:
> Hi,
>
> On Tue, Mar 20, 2012 at 12:02:39AM +0100, Peter H=FCwe wrote:
>> I'm currently trying to improve the xgifb driver from staging a bit and =
my
>> final goal is to probably merge this driver with the sis driver (as both=
 card
>> families seem to have a lot in common).
>>
>> However I'm a little bit unsure how to proceed here.
>
> I would first continue deleting unused dead code and definitions from the
> staging driver. We have already removed maybe 10000 lines of code without
> a loss of functionality, and I believe there is still more work to do.
>
> Then with the remaining code, we could start thinking how to consolidate
> the stuff with sisfb. Or even with the other fb drivers, I don't think
> stuff like bpp_to_var is specific to these two drivers.
>
> And once xgifb is cleaned up, the partial XGI support would be dropped
> from sisfb.

You could probably just add the pci ids to sisfb;  The xgi chips were
just rebadged sis chips.  IIRC, xgifb was just a fork of sisfb with
the strings changed.  XGI was a combination of the old trident and sis
graphics teams.  Most of the xgi cards were just rebadged sis cards
with the exception of the xp10 which was a trident variant and could
probably be merged with the tridentfb driver if there is one.

For reference see the X drivers:
Sis-based:
http://cgit.freedesktop.org/xorg/driver/xf86-video-sis
http://cgit.freedesktop.org/xorg/driver/xf86-video-xgi

Trident-based:
http://cgit.freedesktop.org/xorg/driver/xf86-video-trident
http://cgit.freedesktop.org/xorg/driver/xf86-video-xgixp

Alex
