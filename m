From: Eric Miao <eric.y.miao@gmail.com>
Date: Wed, 16 Mar 2011 11:17:25 +0000
Subject: Re: [PATCH 1/4] ARM: PXA: PXAFB: rework pxafb overlay memory management
Message-Id: <AANLkTi=FctYRCNQV3Sa8m6R3qfwSKoqHBZ7T5riRCA95@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <201103060030.59584.anarsoul@gmail.com>
	<1299835250-11095-1-git-send-email-anarsoul@gmail.com>
	<201103112234.10904.marek.vasut@gmail.com>
	<201103112346.51471.anarsoul@gmail.com>
In-Reply-To: <201103112346.51471.anarsoul@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

2011/3/12 Vasily Khoruzhick <anarsoul@gmail.com>:
> On Friday 11 March 2011 23:34:10 Marek Vasut wrote:
>> > + =C2=A0 if (ofb->usage++ =3D 0)
>>
>> TBH I don't like this notation, it feels hard to read. Can you split that
>> ofb-
>>
>> >usage++ into two parts ?
>>
>> Cheers
>
> It's not deprecated by kernel codestyle, looks ok and works ok, but I'll
> change it if one more person argues against it :)
>

I'm OK with the it. The whole series merged into -devel.

Thanks.
- eric
