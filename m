From: Jassi Brar <jaswinder.singh@linaro.org>
Date: Mon, 25 Jun 2012 09:16:34 +0000
Subject: Re: [PATCH] OMAPDSS: HDMI: Cache EDID
Message-Id: <CAJe_Zhe9aeN1WiMUPTwDtBMs0fUEse-XXTBTqf70bfJcPqw91g@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1340438806-25622-1-git-send-email-jaswinder.singh@linaro.org>
	<1340606154.12683.34.camel@lappyti>
	<CAJe_Zhf1RsDtKXOpQ97Am-ByBYUtOgjJYyySGYGL9zHNYB_Ejw@mail.gmail.com>
	<1340611895.3395.14.camel@deskari>
In-Reply-To: <1340611895.3395.14.camel@deskari>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: mythripk@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, andy.green@linaro.org, n-dechesne@ti.com

On 25 June 2012 13:41, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
>
>> I am perfectly OK to resend as a patch series, if you want.
>
> Yes please.
>
OK, will do.

>> >> =A0bool ti_hdmi_4xxx_detect(struct hdmi_ip_data *ip_data)
>> >> =A0{
>> >> - =A0 =A0 return gpio_get_value(ip_data->hpd_gpio);
>> >> + =A0 =A0 if (gpio_get_value(ip_data->hpd_gpio))
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 return true;
>> >> +
>> >> + =A0 =A0 /* Invalidate EDID Cache */
>> >> + =A0 =A0 ip_data->edid_len =3D 0;
>> >> +
>> >> + =A0 =A0 return false;
>> >
>> > Why is this needed? The HPD interrupt should handle this already. And =
if
>> > the HPD interrupt doesn't work for some reason, this won't work either,
>> > as the user can plug and unplug his HDMI monitors a thousand times
>> > between two detect calls.
>> >
>> I thought it is almost impossible to unplug->plug cycle the HDMI cable
>> even twice a second, let alone 1000 times against the 10Hz .detect()
>> poll =A0:) =A0 =A0Or you mean some relay controlled HDMI switching
>> mechanism?
>
> omapdss doesn't call the detect function, so it can't presume it's used
> in some certain frequency. Also, last time I tested omapdrm, I think
> detect was called once in 5 secs or so.
>
It's not omapdss.  It's the DRM stack, via the omapdrm, that polls
every 10 secs (not 5).
Sorry I said 10Hz instead of 1/10Hz.

>> =A0Anyways, that is not the point of this patch. This patch only aims to
>> avoid un-ncessary EDID reads while doing its best to make sure we
>> invalidate EDID 'as soon as possible'.
>
> I'm not sure I understand your point. If the HPD interrupt works
> properly, EDID is invalidated there, and the code in detect is not
> needed. And if the HPD interrupt doesn't work (although I don't see why
> it wouldn't), the code in detect doesn't work. In either case it's not
> correct.
>
Well, the idea was to tie edid-cache invalidating with de-asserted
HPD, wherever we read HPD. I will drop it.

thnx
