From: Jassi Brar <jaswinder.singh@linaro.org>
Date: Mon, 25 Jun 2012 08:53:12 +0000
Subject: Re: [PATCH] OMAPDSS: Check if RPM enabled before trying to change state
Message-Id: <CAJe_Zhf-H0dLtFsFAcryDy3av60RjmWmP+d3GSaxq8dNZKiXWw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1340438771-25587-1-git-send-email-jaswinder.singh@linaro.org>
	<1340605221.12683.30.camel@lappyti>
In-Reply-To: <1340605221.12683.30.camel@lappyti>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: mythripk@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, andy.green@linaro.org, n-dechesne@ti.com

On 25 June 2012 11:50, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> On Sat, 2012-06-23 at 13:36 +0530, jaswinder.singh@linaro.org wrote:
....
>> =A0Currenlty HDMI fails to come up in the suspend-resume path.
>> This patch helps that real-world scenario.
>
> What is the problem there? It'd be good to explain the problem in the
> patch description. Does the pm_runtime_get return -EACCES?
>
Yes, it returns -EACCESS because RPM on devices is disabled during the
period from suspend-start to resume-finished.
