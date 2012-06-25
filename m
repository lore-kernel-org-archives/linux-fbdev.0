From: Jassi Brar <jaswinder.singh@linaro.org>
Date: Mon, 25 Jun 2012 12:39:31 +0000
Subject: Re: [PATCH] OMAPDSS: Check if RPM enabled before trying to change state
Message-Id: <CAJe_ZhftuNggxH+269-ZJbWJo5nSzSjo1dDCTQGMbsjPWoUpyg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1340438771-25587-1-git-send-email-jaswinder.singh@linaro.org>
	<1340605221.12683.30.camel@lappyti>
	<CAJe_Zhf-H0dLtFsFAcryDy3av60RjmWmP+d3GSaxq8dNZKiXWw@mail.gmail.com>
	<1340616643.3395.19.camel@deskari>
In-Reply-To: <1340616643.3395.19.camel@deskari>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: mythripk@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, andy.green@linaro.org, n-dechesne@ti.com

On 25 June 2012 15:00, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> On Mon, 2012-06-25 at 14:19 +0530, Jassi Brar wrote:
>> On 25 June 2012 11:50, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
>> > On Sat, 2012-06-23 at 13:36 +0530, jaswinder.singh@linaro.org wrote:
>> ....
>> >> =A0Currenlty HDMI fails to come up in the suspend-resume path.
>> >> This patch helps that real-world scenario.
>> >
>> > What is the problem there? It'd be good to explain the problem in the
>> > patch description. Does the pm_runtime_get return -EACCES?
>> >
>> Yes, it returns -EACCESS because RPM on devices is disabled during the
>> period from suspend-start to resume-finished.
>
> So... You didn't answer my first comment, how can the code work?
>
Sorry, don't know why I thought I didn't miss anything.

> The driver needs to enable the HW and the call to pm_runtime_get() is
> skipped. Won't this lead to crash as the DSS registers are accessed
> without the HW in enabled state?
>
Hmm...  how does the extant code in hdmi driver ensures DSS is up and runni=
ng ?
While it does sound important even to my limited knowledge of OMAPDSS,
I see rpm of HDMI, VENC and RFBI only dependent on DISPC, not DSS.

And for DISPC these drivers already hold a reference in their display
enable/resume and keep it until disable/suspend. So we don't lose
DISPC anytime it is really required.

> And what happens if the pm_runtime_get() call is skipped, but pm_runtime_=
put() is not?
>
Not sure in what newly introduced scenario by this patch, because
get/put both check for pm_enabled before proceeding. Am I overlooking
something?

thnx
