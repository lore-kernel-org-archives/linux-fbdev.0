From: Darius Augulis <augulis.darius@gmail.com>
Date: Fri, 16 Mar 2012 10:18:30 +0000
Subject: Re: [PATCH v2 3/3] ARM: Samsung: Rework platform data of s3c-fb driver
Message-Id: <CAEYLNCpJU_5uVa-jo5HUNY8Av6eYaiow1gEZtHCiQZ5oKkGoMQ@mail.gmail.com>
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
 <CAEYLNCpfQ0cYb4efw6PZNnKjQ2rF25rj5Ed=i884LJXHAwigBw@mail.gmail.com>
 <002f01cd0359$eb718330$c2548990$%han@samsung.com>
In-Reply-To: <002f01cd0359$eb718330$c2548990$%han@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Fri, Mar 16, 2012 at 11:48 AM, Jingoo Han <jg1.han@samsung.com> wrote:
>> > It's just bug.
>> >
>> > struct s3c_fb_pd_win should be used for windows of FIMD IP.
>> > It should not be used for selecting multi-LCDs.
>>
>> why not? s3c_fb_pd_win contains timing values which depend directly on
>> LCD size and resolution.
>> Please look into the code again - mini6410 doesn't use platform data
>> so select different LCD sizes.
>> It has only single window in platform data - exactly what you want.
>> Now tell my, why you are arguing, that this platform data cannot be
>> rewritten dynamically by board setup routines at kernel startup time?
>> Many ARM architectures are doing the same - takes kernel command line
>> argument to select LCD and passes necessary data for its fb drivers
>> via platform data structures. It not a bug, it's correct approach to
>> support different sizes of LCD display for the same board.
>
>
> Hey, it is not my point.
> To take kernel command line is not problem to support multiple LCDs.
>
> My point is that s3c_fb_pd_win should not include variable LCD option.
> So, if you want to support multiple LCDs, you should use another variable,
> instead of using s3c_fb_pd_win[0] and s3c_fb_pd_win[1] as 4.3" LCD, 7.0" LCD.

But I use s3c_fb_pd_win only as container to hold timing values in
board setup code.
s3c-fb platform data has only single window and does not perform any
LCD selection.
What is wrong here? You suggest to declare some custom structure to
hold these timing values? What's the point?

>
> You use s3c_fb_pd_win[0], s3c_fb_pd_win[1] as 4.3" LCD, 7.0" LCD.
> However, s3c_fb_pd_win[0], s3c_fb_pd_win[1] means the windows of FIMD IP.

There is no multiple windows in platform data! driver sees only single
window. And this wont change in any way if you drop LCD selection from
board setup code.
Driver will see the same single window. So - your are arguing, that
board setup code sets platform data in bad way. I don't accept your
opinion, because tens of boards are doing the same and nobody call it
bug.

>
