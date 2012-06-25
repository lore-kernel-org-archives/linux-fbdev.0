From: Jassi Brar <jaswinder.singh@linaro.org>
Date: Mon, 25 Jun 2012 12:45:35 +0000
Subject: Re: [PATCH] OMAPDSS: Check if RPM enabled before trying to change state
Message-Id: <CAJe_ZhecBjXi99NjOrMo5oCYtRBso6mGmWZcZVbbXxxc=pHrUw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1340438771-25587-1-git-send-email-jaswinder.singh@linaro.org>
	<1340605221.12683.30.camel@lappyti>
	<CANOLnOOodXtqV7Hs-SsEUfB3Uo1PSGb8bkaeN7M48jVpQrb-cA@mail.gmail.com>
In-Reply-To: <CANOLnOOodXtqV7Hs-SsEUfB3Uo1PSGb8bkaeN7M48jVpQrb-cA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, mythripk@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, andy.green@linaro.org, n-dechesne@ti.com

On 25 June 2012 17:35, Grazvydas Ignotas <notasas@gmail.com> wrote:
> On Mon, Jun 25, 2012 at 9:20 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> w=
rote:
>> On Sat, 2012-06-23 at 13:36 +0530, jaswinder.singh@linaro.org wrote:
>>>
>>> =A0Currenlty HDMI fails to come up in the suspend-resume path.
>>> This patch helps that real-world scenario.
>>
>> What is the problem there? It'd be good to explain the problem in the
>> patch description. Does the pm_runtime_get return -EACCES?
>
> On slightly different but related issue, currently OMAPDSS always
> spits lots of backtraces when it's compiled without CONFIG_PM_RUNTIME,
> because pm_runtime_put* always return -ENOSYS without
> CONFIG_PM_RUNTIME. So something like this patch proposes is needed, or
> maybe WARN_ON should check for -ENOSYS, I don't know..
>
I didn't check, but this patch should already fix that I think ?

IMHO, for omapdss, we need not differentiate between -ENOSYS and
-EACCESS because anyway the ultimate functions dispc_runtime_resume()
and dispc_runtime_suspend()  can't report failure (they always return
0).

-j
