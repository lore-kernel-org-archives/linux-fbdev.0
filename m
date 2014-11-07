From: Lee Jones <lee.jones@linaro.org>
Date: Fri, 07 Nov 2014 11:50:09 +0000
Subject: Re: [PATCH 2/2] backlight: pwm: clean up pwm requested using legacy API
Message-Id: <20141107115009.GA3745@x1>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1413035186-11771-1-git-send-email-vladimir_zapolskiy@mentor.com>
 <1413035186-11771-3-git-send-email-vladimir_zapolskiy@mentor.com>
 <20141011142156.GC11456@kroah.com>
 <545BF1D1.30304@mentor.com>
 <20141106225420.GA2770@kroah.com>
In-Reply-To: <20141106225420.GA2770@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>, Thierry Reding <thierry.reding@gmail.com>, linux-fbdev@vger.kernel.org, linux-pwm@vger.kernel.org, Jingoo Han <jg1.han@samsung.com>, Bryan Wu <cooloney@gmail.com>, Dmitry Eremin-Solenikov <dmitry_eremin@mentor.com>

On Thu, 06 Nov 2014, Greg KH wrote:

> On Fri, Nov 07, 2014 at 12:10:25AM +0200, Vladimir Zapolskiy wrote:
> > Hello Greg, Thierry,
> >=20
> > On 11.10.2014 17:21, Greg KH wrote:
> > > On Sat, Oct 11, 2014 at 04:46:26PM +0300, Vladimir Zapolskiy wrote:
> > >> If PWM device is requested by means of legacy API pwm_request(), its
> > >> resources are not freed on module unbind, which may cause an oops on
> > >> access, e.g. by reading /sys/kernel/debug/pwm.
> > >>
> > >> Reported-by: Dmitry Eremin-Solenikov <dmitry_eremin@mentor.com>
> > >> Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
> > >> ---
> > >>  drivers/video/backlight/pwm_bl.c |    4 ++++
> > >>  1 file changed, 4 insertions(+)
> > >=20
> > > <formletter>
> > >=20
> > > This is not the correct way to submit patches for inclusion in the
> > > stable kernel tree.  Please read Documentation/stable_kernel_rules.txt
> > > for how to do this properly.
> > >=20
> > > </formletter>
> > > --
> >=20
> > could you please review the change? I believe it would be nice to have
> > oops fix in v3.18.
>=20
> drivers/video/ is not under my control, so there's nothing I can do
> here, sorry...

I can apply this with Thierry's Ack.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
