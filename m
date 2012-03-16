From: Darius Augulis <augulis.darius@gmail.com>
Date: Fri, 16 Mar 2012 09:15:46 +0000
Subject: Re: [PATCH v2 3/3] ARM: Samsung: Rework platform data of s3c-fb driver
Message-Id: <CAEYLNCpfQ0cYb4efw6PZNnKjQ2rF25rj5Ed=i884LJXHAwigBw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1331585999-8604-1-git-send-email-thomas.abraham@linaro.org>
 <1331585999-8604-4-git-send-email-thomas.abraham@linaro.org>
 <002f01cd00fe$5df84fa0$19e8eee0$%han@samsung.com>
 <CAJuYYwSUf-gsVesduMggSuues9OLOR6DUDAAMg_tL=e3=3c0tQ@mail.gmail.com>
 <000501cd0184$f088cb20$d19a6160$%han@samsung.com>
 <4F60E5C8.3040804@gmail.com>
 <001501cd0241$6bb53560$431fa020$%han@samsung.com>
 <CAEYLNCp5e=86rpRi2C-5OJptTyEeXAn8JHhbWw_BqGzSaDD9wQ@mail.gmail.com>
 <002a01cd0283$1f61b200$5e251600$%han@samsung.com>
 <CAEYLNCrprPE60ZS=_OWuck0JCJMhCxzVErZwuwGpEDYkQq-hXg@mail.gmail.com>
 <001d01cd0315$935cc720$ba165560$%han@samsung.com>
 <CAEYLNCrGCmb5EJjURLY=EGfM=4N54MirNkCCyQRxqKEN3Eka8Q@mail.gmail.com>
 <002d01cd034b$c56f2b00$504d8100$%han@samsung.com>
In-Reply-To: <002d01cd034b$c56f2b00$504d8100$%han@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Fri, Mar 16, 2012 at 10:07 AM, Jingoo Han <jg1.han@samsung.com> wrote:
>
>
>> -----Original Message-----
>> From: Darius Augulis [mailto:augulis.darius@gmail.com]
>> Sent: Friday, March 16, 2012 4:47 PM
>> To: Jingoo Han
>> Cc: Thomas Abraham; linux-fbdev@vger.kernel.org; FlorianSchandinat@gmx.de; linux-arm-
>> kernel@lists.infradead.org; linux-samsung-soc@vger.kernel.org; ben-linux@fluff.org; patches@linaro.org;
>> kgene.kim@samsung.com; Kyungmin Park; JeongHyeon Kim; Heiko Stuebner; Kwangwoo Lee; Mark Brown; Peter
>> Korsgaard; Maurus Cuelenaere; Tushar Behera
>> Subject: Re: [PATCH v2 3/3] ARM: Samsung: Rework platform data of s3c-fb driver
>>
>> On Fri, Mar 16, 2012 at 3:39 AM, Jingoo Han <jg1.han@samsung.com> wrote:
>>
>> it's not a bug, because it's working like it was intended to. it was
>> reviewed and accepted by maintainers before merging to main line.
>> you do not have rights to drop it because you don't like it.
>> You are doing changes - please do it correctly and do not break
>> existing functionality.
>> btw, you still not answered my question: why these two s3c_fb_pd_win
>> structures in mach-mini6410.c is a problem? They are declared on the
>> stack, but platform data uses only single one. mini6410 rewrites its
>> s3c-fb platform data with data from one of these two structures
>> dynamically. Why it's a bug? You want to remove this dynamic selection
>> which could be leaved there with reworked framework too.
>
>
> It's just bug.
>
> struct s3c_fb_pd_win should be used for windows of FIMD IP.
> It should not be used for selecting multi-LCDs.

why not? s3c_fb_pd_win contains timing values which depend directly on
LCD size and resolution.
Please look into the code again - mini6410 doesn't use platform data
so select different LCD sizes.
It has only single window in platform data - exactly what you want.
Now tell my, why you are arguing, that this platform data cannot be
rewritten dynamically by board setup routines at kernel startup time?
Many ARM architectures are doing the same - takes kernel command line
argument to select LCD and passes necessary data for its fb drivers
via platform data structures. It not a bug, it's correct approach to
support different sizes of LCD display for the same board.
You are simply lazy to deal with little bit different code of mini6410
and real6410 because they have support for multiple LCDs and other
s3c-fb boards doesn't.
This is a reason why you want to drop it and not because it's a bug.
Hope other maintainers and code reviewers understand this situation correctly.

>
> struct s3c_fb_pd_win should include information of windows of FIMD IP, s3c_fb_pd_win[0], s3c_fb_pd_win[1] represents window 0,
> window 1 of FIMD IP. However, your code includes information of LCD, it means that struct s3c_fb_pd_win represents 4.3" LCD, 7.0"
> LCD. It is wrong usage.
>
>
>>
>> > 'struct s3c_fb_pd_win' is used not for LCD, but for windows of FIMD IP. So, 'struct s3c_fb_pd_win'
>> should not be used to select LCD.
>> > The mach-aquila.c uses two 'struct s3c_fb_pd_win' like you, however 'struct s3c_fb_pd_win' don't make
>> problem with Thomas's
>> > patchset. It is because mach-aquila.c use 'struct s3c_fb_pd_win' for only windows of FIMD IP.
>> > We don't have to responsibility to keep wrong code. If you have kept the rule, Thomas's patch would
>> not make the compatibility
>> > problem with your code. Why we should keep aberration such as your code? If you want to select two
>> LCDs, please find other way.
>> >
>> >
>> >>
>> >> Darius A.
>> >
>
