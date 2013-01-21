From: Alex Courbot <acourbot@nvidia.com>
Date: Mon, 21 Jan 2013 08:24:47 +0000
Subject: Re: [PATCH 2/3] tegra: pwm-backlight: add tegra pwm-bl driver
Message-Id: <1966511.aoasnExaly@percival>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1358591420-7790-1-git-send-email-acourbot@nvidia.com> <1358591420-7790-3-git-send-email-acourbot@nvidia.com> <50FCEFDE.8000705@gmail.com>
In-Reply-To: <50FCEFDE.8000705@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Zhang <nvmarkzhang@gmail.com>
Cc: Thierry Reding <thierry.reding@avionic-design.de>, Stephen Warren <swarren@wwwdotorg.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, Mark Zhang <markz@nvidia.com>, "gnurou@gmail.com" <gnurou@gmail.com>

On Monday 21 January 2013 15:35:58 Mark Zhang wrote:
> > +	backlight {
> > +		compatible = "pwm-backlight-ventana";
> > +		brightness-levels = <0 16 32 48 64 80 96 112 128 144 160 176 192 
208
> > 224 240 255>; +		default-brightness-level = <12>;
> > +
> > +		pwms = <&pwm 2 5000000>;
> 
> After read the codes of tegra pwm driver & pwm framework, I got to know
> the meaning of this property. So I think we need to add a doc(e.g:
> Documentation/devicetree/bindings/video/backlight/nvidia,tegra20-bl.txt)
> to explain this, "Documentation/devicetree/bindings/pwm/pwm.txt" doesn't
> explain this, because this may be different between different pwm drivers.

The bindings are in Documentation/devicetree/bindings/video/backlight/pwm-
backlight.txt . But you are right that the power supplies and GPIO will 
require a description of their own - I omitted it for this version because I 
am not sure what the driver should be called.

The panel used on Ventana is a Chunghwa CLAA101WA01A, maybe that's the name we 
should use for the compatible string instead (and rename the driver 
accordingly).

> So according to the filename, I think we can put all tegra boards codes
> here, right? Just like what you do for Ventana, if I wanna add support
> for cardhu, I can define similar functions -- let's say "init_cardhu",
> "exit_cardhu", "notify_cardhu" and "notify_after_cardhu", right?

That was my initial intention, yes.

> But I think if we do in this way, the file will become very long soon.
> And there are a lot of redundant codes in it. So do you have any
> suggestions?

If we decide to make a "Tegra" driver, then I don't think the size of the file 
is a big issues, as long as one can easily navigate into it. It will make 
sense to do this since Tegra kernels should include support for all the 
boards.

If we go and name the drivers after their actual panel names, we should 
definitely put them into separate files. The Tegra configuration could then 
include them all by default to make sure all boards are supported.

Alex.

