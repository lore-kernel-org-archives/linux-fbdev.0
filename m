From: Grazvydas Ignotas <notasas@gmail.com>
Date: Tue, 26 Jun 2012 13:02:46 +0000
Subject: Re: [PATCH] OMAPDSS: Check if RPM enabled before trying to change state
Message-Id: <CANOLnOP_z47QCB234y-BOWyRGHeO8u-pJct=Kq6+2XCig-tX=w@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1340438771-25587-1-git-send-email-jaswinder.singh@linaro.org>
	<1340605221.12683.30.camel@lappyti>
	<CANOLnOOodXtqV7Hs-SsEUfB3Uo1PSGb8bkaeN7M48jVpQrb-cA@mail.gmail.com>
	<1340627459.3395.54.camel@deskari>
	<4FE85CCA.80903@ti.com>
	<1340628648.3395.69.camel@deskari>
	<4FE93FB9.3080705@ti.com>
In-Reply-To: <4FE93FB9.3080705@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Rajendra Nayak <rnayak@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, jaswinder.singh@linaro.org, mythripk@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, andy.green@linaro.org, n-dechesne@ti.com, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-pm@vger.kernel.org

CCing some PM people, maybe they can comment?

On Tue, Jun 26, 2012 at 7:51 AM, Rajendra Nayak <rnayak@ti.com> wrote:
> On Monday 25 June 2012 06:20 PM, Tomi Valkeinen wrote:
>>
>> Do you know how the drivers should handle CONFIG_PM_RUNTIME=3Dn?
>> Are they supposed to handle the error values returned by runtime PM
>> functions somehow, or should they use #ifdef CONFIG_PM_RUNTIME?
>
> hmm, I always though with CONFIG_RUNTIME_PM=3Dn, the functions would
> be stubbed to return success and not failure. And the _pm_runtime_resume
> function indeed seems to return 1, which is not failure but just saying
> that your device is already active/enabled.
> The _pm_runtime_suspend and _pm_runtime_idle do return a -ENOSYS, which
> is something only returned when CONFIG_RUNTIME_PM=3Dn, so if you really
> want to handle failing pm_runtime_put_sync cases, maybe you still can.
> But then, I don't know if there is anything you can do to recover from
> a failing pm_runtime_put_sync, except for warning the user maybe.
>
>> Both options sound a bit difficult to me... With the first one it's
>> difficult to see if there was an actual error and we should somehow
>> react to it, or is everything fine and we just shouldn't care about
>> runtime PM. The second one requires ifdefs in many places.

--=20
Gra=C5=BEvydas
