From: Andy Green <andy.green@linaro.org>
Date: Tue, 26 Jun 2012 08:40:32 +0000
Subject: Re: [PATCH] OMAPDSS: Check if RPM enabled before trying to change state
Message-Id: <4FE97580.4070805@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1340438771-25587-1-git-send-email-jaswinder.singh@linaro.org> <1340605221.12683.30.camel@lappyti> <CAJe_Zhf-H0dLtFsFAcryDy3av60RjmWmP+d3GSaxq8dNZKiXWw@mail.gmail.com> <1340616643.3395.19.camel@deskari> <CAJe_ZhftuNggxH+269-ZJbWJo5nSzSjo1dDCTQGMbsjPWoUpyg@mail.gmail.com> <1340628094.3395.63.camel@deskari> <CAJe_ZhetdEwrgDEfV9rLHU1_fmb3O+954hCKcoENBgQ6Bi6BXQ@mail.gmail.com> <1340632161.3395.100.camel@deskari> <CAJe_ZheHoCikVzy6zJoKHuL8_oQ0ZnPASUUWimvbPRr+AZ4zWg@mail.gmail.com> <1340695166.2093.22.camel@lappyti> <CAJe_Zhev3V85K1jhj+W+d+0kv132MZ=-7rChhCLgtWO7WN4u1w@mail.gmail.com>
In-Reply-To: <CAJe_Zhev3V85K1jhj+W+d+0kv132MZ=-7rChhCLgtWO7WN4u1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Jassi Brar <jaswinder.singh@linaro.org>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, mythripk@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, n-dechesne@ti.com

On 06/26/12 16:32, the mail apparently from Jassi Brar included:
> On 26 June 2012 12:49, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
>> On Mon, 2012-06-25 at 22:36 +0530, Jassi Brar wrote:
>
>>>>
>>>> Normally if the driver does dispc_runtime_get() and dispc_read_reg(),
>>>> the first call will enable the HW so the reg read works.
>>>>
>>>> But if the pm_runtime is disabled, say, during system suspend, with yo=
ur
>>>> patch dispc_runtime_get() will just return 0 without doing anything, a=
nd
>>>> the dispc_read_reg() will crash because the HW is disabled (because
>>>> nobody enabled it).
>>>>
>>> Hmm, I am not sure if new calls would/should be made to dispc.c after
>>> the system has suspended and before resumed. That is, anything other
>>> than from runtime_resume/suspend callbacks of DSS, DISPC, HDMI, VENC
>>> and RFBI, which rightly don't touch any dss reg but only
>>> enable/disable a clock.
>>
>> They do touch the registers. For example, dispc's callbacks save and
>> restore the registers. The HW should be fully functional during the
>> callbacks. The point of the callbacks is to suspend/resume the HW in
>> question, which of course requires accessing the HW.
>>
> DISPC being held by HDMI, VENC and RFBI would be the last to suspend
> and first to resume. And it won't have its registers touched between
> dispc_runtime_suspend() and dispc_runtime_resume(), which seems ok to
> me (?)
> HDMI, VENC and RFBI directly fooling around with DISPC regs would have
> been a problem, which isn't the case.
>
>>> As we know, a subsystem should make sure any active work is cleared
>>> out before suspending and set some flag so that nothing runs until it
>>> has resumed. I don't say we can't crash the system with this patch,
>>> but then we would be violating rules of suspend-resume.
>>
>> Let's go back a bit. I feel like I'm missing some pieces of information,
>> as I still don't quite grasp the problem.
>>
>> In the patch you said this fixes an issue with HDMI. Can you tell more
>> about the problem? What code path is being run? Any error messages?
>>
>> I tried system suspend with omap4-sdp and panda, with 3.5-rc2, but
>> neither board seems to wake up from the suspend. Does it work for you?
>>
> Something non-omapdss in vanilla breaks suspend/resume.
> Without this patch I see the upstream's display broken after the
> suspend attempt.
>      $ echo mem > /sys/power/state
>
> I work on TILT tree, which has suspend/resume working after some more
> local patches.
>      http://git.linaro.org/gitweb?p=3Dpeople/andygreen/kernel-tilt.git;a=
=3Dshortlog;h=3Drefs/heads/tilt-3.4
>
> I don't have SDP so not sure, but it should simply be testable with
> Panda4460 and the omap4plus_defconfig there.  Please feel free to ask
> if you have any issue checking that out.

We don't have access to Blaze and don't test that tree against it, but=20
it's worth trying on PandaBoard ES which we do have and test against=20
(omap4plus_defconfig).

Here, mem suspend is working with HDMI raster coming back on resume, but=20
we don't always get a desktop redraw (suspending again can "correct"=20
that).  Jassi's patches are present in this tree.

A slightly side-issue, I have a TV here that only issues hpd 700ms after=20
the Panda provides 5V at the HDMI link.  It has always been touch-and-go=20
if dss will recognize it or not, compared to a monitor which issues hpd=20
high within some us of the link being powered.

The patches from Jassi about permanently enabling the external HDMI PHY=20
chip section that performs level-conversion for hpd, and the existing=20
work to use irq management of hpd, seems to have really solved detecting=20
that TV for the first time.

-Andy

--=20
Andy Green | TI Landing Team Leader
Linaro.org =E2=94=82 Open source software for ARM SoCs | Follow Linaro
http://facebook.com/pages/Linaro/155974581091106  -=20
http://twitter.com/#!/linaroorg - http://linaro.org/linaro-blog


