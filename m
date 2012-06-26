From: Jassi Brar <jaswinder.singh@linaro.org>
Date: Tue, 26 Jun 2012 15:21:38 +0000
Subject: Re: [PATCH] OMAPDSS: Check if RPM enabled before trying to change state
Message-Id: <CAJe_ZheMN_sqaANSMepmhDDp2a2sQAVPYD1-owBWpwwbxqAtHQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1340438771-25587-1-git-send-email-jaswinder.singh@linaro.org>
	<1340605221.12683.30.camel@lappyti>
	<CAJe_Zhf-H0dLtFsFAcryDy3av60RjmWmP+d3GSaxq8dNZKiXWw@mail.gmail.com>
	<1340616643.3395.19.camel@deskari>
	<CAJe_ZhftuNggxH+269-ZJbWJo5nSzSjo1dDCTQGMbsjPWoUpyg@mail.gmail.com>
	<1340628094.3395.63.camel@deskari>
	<CAJe_ZhetdEwrgDEfV9rLHU1_fmb3O+954hCKcoENBgQ6Bi6BXQ@mail.gmail.com>
	<1340632161.3395.100.camel@deskari>
	<CAJe_ZheHoCikVzy6zJoKHuL8_oQ0ZnPASUUWimvbPRr+AZ4zWg@mail.gmail.com>
	<1340695166.2093.22.camel@lappyti>
	<CAJe_Zhev3V85K1jhj+W+d+0kv132MZ=-7rChhCLgtWO7WN4u1w@mail.gmail.com>
	<1340701660.24530.17.camel@deskari>
	<CAJe_Zhd-LA67yO-H_7pacB_T8_z6=Zf47QuoHSJcsXDZ9S+byw@mail.gmail.com>
	<1340712213.24530.21.camel@deskari>
	<CAJe_ZhcxVAUuuMDZ8p1LVae4N2aZb_vFs_nRLfb7atJ2j6j=Sg@mail.gmail.com>
	<1340723296.24530.68.camel@deskari>
In-Reply-To: <1340723296.24530.68.camel@deskari>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: mythripk@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, andy.green@linaro.org, n-dechesne@ti.com

On 26 June 2012 20:38, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> On Tue, 2012-06-26 at 20:19 +0530, Jassi Brar wrote:
>> On 26 June 2012 17:33, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
>> > On Tue, 2012-06-26 at 15:27 +0530, Jassi Brar wrote:
>> >
>> >> Seems similar, but I only tested OMAP4 HDMI.
>> >
>> > Would something like this one below work for you? It fixes the issues on
>> > my overo board.
>> >
>> I think this should work too (I will get to test it only tomorrow).
>>
>> Though I don't think it'll fix stack spew when run without
>> CONFIG_PM_RUNTIME. Maybe we could simply remove the WARN_ON in the
>> xxx_runtime_put() as Alan noted?
>
> Yes, that's a different issue. I'll look at that also.
>
Well, my patch took care of that also. But I agree, that could be
added separately as well.
