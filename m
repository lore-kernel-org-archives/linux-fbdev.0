From: Grazvydas Ignotas <notasas@gmail.com>
Date: Mon, 25 Jun 2012 12:05:18 +0000
Subject: Re: [PATCH] OMAPDSS: Check if RPM enabled before trying to change state
Message-Id: <CANOLnOOodXtqV7Hs-SsEUfB3Uo1PSGb8bkaeN7M48jVpQrb-cA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1340438771-25587-1-git-send-email-jaswinder.singh@linaro.org>
	<1340605221.12683.30.camel@lappyti>
In-Reply-To: <1340605221.12683.30.camel@lappyti>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: jaswinder.singh@linaro.org, mythripk@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, andy.green@linaro.org, n-dechesne@ti.com

On Mon, Jun 25, 2012 at 9:20 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> wro=
te:
> On Sat, 2012-06-23 at 13:36 +0530, jaswinder.singh@linaro.org wrote:
>>
>>  Currenlty HDMI fails to come up in the suspend-resume path.
>> This patch helps that real-world scenario.
>
> What is the problem there? It'd be good to explain the problem in the
> patch description. Does the pm_runtime_get return -EACCES?

On slightly different but related issue, currently OMAPDSS always
spits lots of backtraces when it's compiled without CONFIG_PM_RUNTIME,
because pm_runtime_put* always return -ENOSYS without
CONFIG_PM_RUNTIME. So something like this patch proposes is needed, or
maybe WARN_ON should check for -ENOSYS, I don't know..


--=20
Gra=C5=BEvydas
