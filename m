From: Darius Augulis <augulis.darius@gmail.com>
Date: Thu, 15 Mar 2012 07:42:03 +0000
Subject: Re: [PATCH v2 3/3] ARM: Samsung: Rework platform data of s3c-fb driver
Message-Id: <CAEYLNCp5e=86rpRi2C-5OJptTyEeXAn8JHhbWw_BqGzSaDD9wQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1331585999-8604-1-git-send-email-thomas.abraham@linaro.org>
 <1331585999-8604-4-git-send-email-thomas.abraham@linaro.org>
 <002f01cd00fe$5df84fa0$19e8eee0$%han@samsung.com>
 <CAJuYYwSUf-gsVesduMggSuues9OLOR6DUDAAMg_tL=e3=3c0tQ@mail.gmail.com>
 <000501cd0184$f088cb20$d19a6160$%han@samsung.com>
 <4F60E5C8.3040804@gmail.com>
 <001501cd0241$6bb53560$431fa020$%han@samsung.com>
In-Reply-To: <001501cd0241$6bb53560$431fa020$%han@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

Hi,

>
> Yes, only single LCD resolution will be left.
>
>> I have mini6410 with both 4.3" and 7" LCDs and real6410 with 7" LCD. Now
>> we have possibility to choose LCD size dynamically - leave it there.
>> What you mean "default" 4.3" size LCD? The 7" size LCD is also provided
>> by board sellers - I've bought it.
>
> OK, I see.
> Both mini6410 and real6410 provide both 4.3" and 7" LCDs,
> so you needs to select both LCDs.
>
> Um, usually, single LCD is provided on the single board.
> Also, the daughter board with another kind LCD can be connected to the bo=
ard.

There is single board - mini6410 (or real6410) and it's name doesn't
depend on connected LCD size.
We know, that this board is available with different sizes of LCD and
currently we have in kernel support for both sizes.
It might be so, that it's implemented not in perfect way, but it was
accepted and at least it's working.
If you want to rework s3c-fb platform data and driver framework, you
should not drop any functionality created by other people.

>
> However, .win_mode is used not for LCD, but for windows of FIMD IP.
> Actually, our current framework does not support to choose multi LCD,
> so, I understand that you use .win_mode[1] as second LCD.
> However, that's not accurate way to select multi LCD.
>
> Thomas, can you consider Augulis's opinion?
> I think that the method to select multi LCDs is necessary.
>
> Ideal process is such as:
> =A01. add the patch to support to select multi LCDs
> =A02. apply above patch to make the mini6410 and real6410 to select multi=
 LCDs.
> =A03. apply Thomas's patchset to remove timing value from .win_mode varia=
ble.

Yes, this would be the right way to go.

regards,
Darius A.
