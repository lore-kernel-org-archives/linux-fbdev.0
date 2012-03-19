From: Darius Augulis <augulis.darius@gmail.com>
Date: Mon, 19 Mar 2012 07:52:33 +0000
Subject: Re: [PATCH v2 3/3] ARM: Samsung: Rework platform data of s3c-fb driver
Message-Id: <CAEYLNCqzSFW4ugsXgG0ugwQ6p0fSmZaYdgx03J0XVKK4bKH5Lg@mail.gmail.com>
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
 <CAEYLNCpJU_5uVa-jo5HUNY8Av6eYaiow1gEZtHCiQZ5oKkGoMQ@mail.gmail.com>
 <001501cd0561$57c642b0$0752c810$%han@samsung.com>
 <CAJuYYwQmJvx_uGZKbAJ9uds-ciLs2VDqcifhoqB-P0M5uhO-nA@mail.gmail.com>
 <CAEYLNCo0zyH9Nsf59UU-J4m=km+mKH1ym5a-9s7WthFpos6D+w@mail.gmail.com>
 <CAJuYYwQY6C-+NUuYfmDyGoh0ahVa8_x1cai8MCfN_JjWh1k1Gg@mail.gmail.com>
In-Reply-To: <CAJuYYwQY6C-+NUuYfmDyGoh0ahVa8_x1cai8MCfN_JjWh1k1Gg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Mon, Mar 19, 2012 at 9:49 AM, Thomas Abraham
<thomas.abraham@linaro.org> wrote:
> On 19 March 2012 13:10, Darius Augulis <augulis.darius@gmail.com> wrote:

>> Right now s3c_fb_pd_win contains exactly LCD timing values.
>> Your patch will move these timing values to struct fb_videomode.
>>
>> I could make necessary patch for that too, but I think you will spend
>> less time doing it by yourself than syncing with me.
>> What do you think?
>
> Yes, I will prepare an additional patch in this series that will
> maintain backward compatibility for real6410 and mini6410 with the
> approach suggested by Jingoo Han. As I do not have either of these
> boards, an ack from you would be very helpful when the next version of
> this patchset is posted.

It's fine - I will review and probably test it.
