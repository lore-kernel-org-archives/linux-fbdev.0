From: Jassi Brar <jaswinder.singh@linaro.org>
Date: Wed, 27 Jun 2012 04:54:52 +0000
Subject: Re: [PATCH] OMAPDSS: Check if RPM enabled before trying to change state
Message-Id: <CAJe_ZheovnRsJ6opMPkMxwjLSv-OKBPCHu5rsAX_KNz1mb64ZQ@mail.gmail.com>
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
	<CAJe_ZheMN_sqaANSMepmhDDp2a2sQAVPYD1-owBWpwwbxqAtHQ@mail.gmail.com>
	<1340723514.24530.70.camel@deskari>
	<CAJe_ZheXSquxOtOD9iPyQjZ-jxWKzVGZHYkjM=wC37qgMZeJug@mail.gmail.com>
	<1340736243.24530.98.camel@deskari>
In-Reply-To: <1340736243.24530.98.camel@deskari>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: mythripk@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, andy.green@linaro.org, n-dechesne@ti.com

On 27 June 2012 00:14, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> On Tue, 2012-06-26 at 22:31 +0530, Jassi Brar wrote:
>>
>> > But if pm_runtime_get_sync() returns an error, it means the HW has not
>> > been resumed successfully, and is not operational,
>> >
>> Not always. The HW could be in RPM_ACTIVE state while PM on it could
>> be disabled, if the returned error is -EACCESS. =A0 And
>> pm_runtime_enabled() only catches a potential -EACCESS.
>
> True. But the HW could also be in disabled state. And that would lead to
> a crash when accessing the registers.
>
> It is not a fatal error if pm_runtime_get returns -EACCES, but we sure
> shouldn't ignore it (or avoid it with pm_runtime_enabled()), but handle
> it. In some rare cases it could be ok to get -EACCES, but that's a
> special case, not standard.
>
You are mixing up generic concepts with what we have in omapdss.
Believe me, I do understand it's bad to proceed without caring for
returned _errors_.
The way omapdss is organized -EACCESS is _not_ an  error, it just
denotes PM is disabled on the device and that DISPC is in RPM_ACTIVE
is backed by the fact that HDMI always hold a reference between
resume-suspend and DISPC goes to suspend last and resume first.


>> BTW, I just tested your patch and it worked for me as well. But as
>> suspected, it doesn't help the stack spew of CONFIG_PM_RUNTIME:=3Dn
>>
>> So I understand, I only need to resend the other three patches ?
>
> Yes, please.
>
OK, will do today later.

Regards.
