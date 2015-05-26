From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Date: Tue, 26 May 2015 12:01:42 +0000
Subject: Re: [PATCH 15/21] backlight: Probe backlight devices on demand
Message-Id: <CAAObsKCBLVOph2DzeQqph+teiFq=uZtjShBOf+G-U2UxRAJ7jw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1432565608-26036-1-git-send-email-tomeu.vizoso@collabora.com>
 <1432565608-26036-16-git-send-email-tomeu.vizoso@collabora.com>
 <20150526071850.GA11677@x1> <20150526072526.GB6325@pengutronix.de>
 <20150526083931.GC11677@x1>
In-Reply-To: <20150526083931.GC11677@x1>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

On 26 May 2015 at 10:39, Lee Jones <lee.jones@linaro.org> wrote:
> On Tue, 26 May 2015, Sascha Hauer wrote:
>> On Tue, May 26, 2015 at 08:18:50AM +0100, Lee Jones wrote:
>> > On Mon, 25 May 2015, Tomeu Vizoso wrote:
>> >
>> > > When looking up a backlight device through its DT node, ensure that =
the
>> > > corresponding device has been registered.
>> > >
>> > > Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
>> > > ---
>> > >  drivers/video/backlight/backlight.c | 3 +++
>> > >  1 file changed, 3 insertions(+)
>> >
>> > Looks reasonable.
>> >
>> > Until anyone screams at me, applied thanks.
>>
>> The compiler will scream at you when it realizes that
>> of_platform_device_ensure() doesn't exist in your kernel...
>
> Yup, indeed it did.
>
> I assumed this was *only* enabling subsystems and that the
> framework/API was already accepted.
>
> So the advice I'd give to Tomeu when sending full enablement
> patch-sets i.e. ones which provide the framework/API *and* enable
> subsystems in the same set, is to send the entire set to everyone, so
> we can see what the aim of the set is and how to deal with it.

Yeah, but get_maintainer.pl outputs 33 maintainer addresses, plus 1
reviewer plus 14 mailing lists, so to avoid rejects because of too
many recipients I went with the advice in [0] and sent each patch to
their maintainers and list(s) and the cover letter to all lists. Also
sent the whole series to lakml to make sure that it's at least indexed
there.

Any advice on what to do with series that span so many subsystems?

Thanks,

Tomeu

[0] http://lwn.net/Articles/585782/

> --
> Lee Jones
> Linaro STMicroelectronics Landing Team Lead
> Linaro.org =E2=94=82 Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
