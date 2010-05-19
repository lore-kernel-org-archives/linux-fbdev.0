From: InKi Dae <daeinki@gmail.com>
Date: Wed, 19 May 2010 01:53:09 +0000
Subject: Re: s3c-fb updates
Message-Id: <AANLkTil9VFeNtsYGgUljdMo4x4McC7CA9HEcwycyXlWP@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1274180045-14645-1-git-send-email-ben-linux@fluff.org>
	<AANLkTinXI9Fgqk8juRNpAA4nxsDnL82CMXwYThZo6y1l@mail.gmail.com>
	<20100519004519.GB4720@trinity.fluff.org>
In-Reply-To: <20100519004519.GB4720@trinity.fluff.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

Hi, Ben

I sent patch series corrected as Andrew requested yesterday.
I was busy so I conformed your answer late.

Sorry but please review my patch series again.

thank you.

2010/5/19 Ben Dooks <ben-linux@fluff.org>:
> On Tue, May 18, 2010 at 11:35:00PM +0900, Kyungmin Park wrote:
>> Hi,
>>
>> On Tue, May 18, 2010 at 7:54 PM, Ben Dooks <ben-linux@fluff.org> wrote:
>> > Updates for the s3c-fb to improbe the build and update support
>> > for s5pv210 and s3c2416 devices.
>> >
>> > The dependency on Inki Dae's patches have been removed since they've
>> > not been reposted, and at-least one causes build failures.
>>
>> Ben please check your mailbox again. He sent it after your reply.
>
> no, what he sent was three patch files attached to a mail[1] which
> Andrew Morton replied to saying that these needed to be sent as proper
> patches with descriptions and other such things that patches have.
>
>> Anyway, how do you integrate the FIMD and FIMC features in current
>> driver? Any plans?
>
> I've been discussiong things with the engineers here. However, the first
> thing is to get the driver closer aligned to the one that Sys.LSI have
> been shipping, which means getting some missing features sorted out.
>
> By the way, which is the FIMC block? I've not seen any documentation
> referencing this as an block in the SoC.
>
> As such I will try and see if Pawel's previous patcehs that got missed
> can be merged into this tree and into the kernel this round.
>
> [1] http://lkml.org/lkml/2010/5/7/63
>
> --
> Ben
>
> Q: =A0 =A0 =A0What's a light-year?
> A: =A0 =A0 =A0One-third less calories than a regular year.
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
