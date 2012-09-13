From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Thu, 13 Sep 2012 07:00:12 +0000
Subject: Re: [PATCH v6 1/4] Runtime Interpreted Power Sequences
Message-Id: <20120913070012.GC6180@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1347443867-18868-1-git-send-email-acourbot@nvidia.com>
 <1464760.6eqxJ2IzZ2@percival>
 <1347517377.7471.23.camel@lappyti>
 <2689722.93BQTh4lSC@percival>
 <1347519249.7471.42.camel@lappyti>
In-Reply-To: <1347519249.7471.42.camel@lappyti>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
Cc: Alex Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>, Simon Glass <sjg-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Anton Vorontsov <cbou-JGs/UdohzUI@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Leela Krishna Amudala <l.krishna-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Thu, Sep 13, 2012 at 09:54:09AM +0300, Tomi Valkeinen wrote:
> On Thu, 2012-09-13 at 15:36 +0900, Alex Courbot wrote:
> > On Thursday 13 September 2012 14:22:57 Tomi Valkeinen wrote:
> >  
> > > However, I fear these board specific things may be quite a bit anything,
> > > so it may well be pwm, gpios and regulators are not enough for them. For
> > > example, there could be an FPGA on the board which requires some
> > > configuration to accomplish the task at hand. It could be rather
> > > difficult to handle it with a generic power sequence.
> > 
> > Right. Note that this framework is supposed to be extended - I would like to 
> > at least add regulator voltage setting, and maybe even support for clocks and 
> > pinmux (but that might be out of place).
> 
> Yes, that's one concern of mine... I already can imagine someone
> suggesting adding conditionals to the power sequence data. Perhaps also
> direct memory read/writes so you can twiddle registers directly. And so
> on. Where's the limit what it should contain? Can we soon write full
> drivers with the DT data? =)

I have this concern aswell, that's why I'm sceptical about this patch
set. But what are the alternatives? Adding power code to the drivers and
thus adding board specific code to them is backwards.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
