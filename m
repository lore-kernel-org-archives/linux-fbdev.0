From: Marc Dietrich <marvin24@gmx.de>
Date: Mon, 21 Jan 2013 08:52:45 +0000
Subject: Re: [PATCH 2/3] tegra: pwm-backlight: add tegra pwm-bl driver
Message-Id: <2440319.UsvGAcXXBp@fb07-iapwap2>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1358591420-7790-1-git-send-email-acourbot@nvidia.com> <1358591420-7790-3-git-send-email-acourbot@nvidia.com> <50FCEFDE.8000705@gmail.com>
In-Reply-To: <50FCEFDE.8000705-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Zhang <nvmarkzhang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Alexandre Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Zhang <markz-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org

Hi,

> > diff --git a/drivers/video/backlight/pwm_bl_tegra.c
> > b/drivers/video/backlight/pwm_bl_tegra.c new file mode 100644
> > index 0000000..8f2195b
> > --- /dev/null
> > +++ b/drivers/video/backlight/pwm_bl_tegra.c
> 
> So according to the filename, I think we can put all tegra boards codes
> here, right? Just like what you do for Ventana, if I wanna add support
> for cardhu, I can define similar functions -- let's say "init_cardhu",
> "exit_cardhu", "notify_cardhu" and "notify_after_cardhu", right?
> 
> But I think if we do in this way, the file will become very long soon.
> And there are a lot of redundant codes in it. So do you have any
> suggestions?

I think we (for PAZ00) will just reuse the ventana code which is sufficient 
for us. But adding "pwm-backlight-ventana" to our DTS may look a bit strange. 
On the other hand, I guess that's why the property is called "compatible".

Marc

