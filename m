From: "K, Mythri P" <mythripk@ti.com>
Date: Wed, 23 Mar 2011 13:59:20 +0000
Subject: Re: [RFC PATCH] HDMI:Support for EDID parsing in kernel.
Message-Id: <AANLkTinjEmih3GC9FMByUCcLVvcc1k1PCzVECbQZa62f@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1300815176-21206-1-git-send-email-mythripk@ti.com>
 <4D88E1FB.5070503@redhat.com> <20110322175810.GA32416@linux-sh.org>
In-Reply-To: <20110322175810.GA32416@linux-sh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Paul Mundt <lethal@linux-sh.org>
Cc: Mauro Carvalho Chehab <mchehab@redhat.com>, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, linux-media@vger.kernel.org

Hi Paul,

On Tue, Mar 22, 2011 at 11:28 PM, Paul Mundt <lethal@linux-sh.org> wrote:
> On Tue, Mar 22, 2011 at 02:52:59PM -0300, Mauro Carvalho Chehab wrote:
>> Em 22-03-2011 14:32, Mythri P K escreveu:
>> > Adding support for common EDID parsing in kernel.
>> >
>> > EDID - Extended display identification data is a data structure provid=
ed by
>> > a digital display to describe its capabilities to a video source, This=
 a
>> > standard supported by CEA and VESA.
>> >
>> > There are several custom implementations for parsing EDID in kernel, s=
ome
>> > of them are present in fbmon.c, drm_edid.c, sh_mobile_hdmi.c, Ideally
>> > parsing of EDID should be done in a library, which is agnostic of the
>> > framework (V4l2, DRM, FB) =A0which is using the functionality, just ba=
sed on
>> > the raw EDID pointer with size/segment information.
>> >
>> > With other RFC's such as the one below, which tries to standardize HDM=
I API's
>> > It would be better to have a common EDID code in one place.It also hel=
ps to
>> > provide better interoperability with variety of TV/Monitor may be even=
 by
>> > listing out quirks which might get missed with several custom implemen=
tation
>> > of EDID.
>> > http://permalink.gmane.org/gmane.linux.drivers.video-input-infrastruct=
ure/30401
>> >
>> > This patch tries to add functions to parse some portion EDID (detailed=
 timing,
>> > monitor limits, AV delay information, deep color mode support, Audio a=
nd VSDB)
>> > If we can align on this library approach i can enhance this library to=
 parse
>> > other blocks and probably we could also add quirks from other implemen=
tation
>> > as well.
>> >
>> > Signed-off-by: Mythri P K <mythripk@ti.com>
>> > ---
>> > =A0arch/arm/include/asm/edid.h | =A0243 ++++++++++++++++++++++++++++++
>> > =A0drivers/video/edid.c =A0 =A0 =A0 =A0| =A0340 ++++++++++++++++++++++=
+++++++++++++++++++++
>>
>> Hmm... if you want this to be agnostic, the header file should not be in=
side
>> arch/arm, but on some other place, like include/video/.
>>
> Ironically this adds a drivers/video/edid.c but completely ignores
> drivers/video/edid.h which already exists and already contains many of
> these definitions.
>
> I like the idea of a generalized library, but it would be nice to see the
> existing edid.h evolved and its users updated incrementally.
>
well yes , That could be enhanced and that would take care of Mauro's
comment too.

Thanks and regards,
Mythri.
