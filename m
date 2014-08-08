From: Tobias Klauser <tklauser@distanz.ch>
Date: Fri, 08 Aug 2014 07:20:38 +0000
Subject: Re: [PATCH] Adding a support for Skyworks SKY81452
Message-Id: <20140808072037.GD29832@distanz.ch>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1407398738-7582-1-git-send-email-jack.yoo@skyworksinc.com>
 <20140807123439.GC29832@distanz.ch>
 <20140808070913.GB5387@ulmo>
In-Reply-To: <20140808070913.GB5387@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Gyungoh Yoo <gyungoh@gmail.com>, rdunlap@infradead.org, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, jg1.han@samsung.com, cooloney@gmail.com, plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, grant.likely@linaro.org, sameo@linux.intel.com, lee.jones@linaro.org, lgirdwood@gmail.com, broonie@kernel.org, jack.yoo@skyworksinc.com, florian.vaussard@epfl.ch, jason@lakedaemon.net, andrew@lunn.ch, silvio.fricke@gmail.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-fbdev@vger.kernel.org

On 2014-08-08 at 09:09:19 +0200, Thierry Reding <thierry.reding@gmail.com> wrote:
> On Thu, Aug 07, 2014 at 02:34:39PM +0200, Tobias Klauser wrote:
> > On 2014-08-07 at 10:05:38 +0200, Gyungoh Yoo <gyungoh@gmail.com> wrote:
> [...]
> > > +#ifdef CONFIG_OF
> > > +static const struct of_device_id sky81452_of_match[] = {
> > > +	{.compatible = "sky,sky81452",},
> > > +	{ }
> > > +};
> > > +MODULE_DEVICE_TABLE(of, sky81452_of_match);
> > > +#endif
> > 
> > The #ifdefery here is not needed since you use of_match_ptr below, whcih
> > will expand to NULL of CONFIG_OF is not set.
> 
> On the contrary, that's exactly why the #ifdef is needed here. If you
> don't guard the OF match table here, then of_match_ptr() evaluating to
> NULL will cause the table to become unused and the compiler warning
> about it.

Oops, yes of course. Sorry about that and thanks for your correction.

Tobias
