From: Rahul Sharma <r.sh.open@gmail.com>
Date: Wed, 09 Jan 2013 08:35:30 +0000
Subject: Re: [RFC v2 0/5] Common Display Framework
Message-Id: <CAPdUM4P6riQVJ4m4Sdkh1O8xmpKF4YnhGq69p7DkxAdr165KYA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1353620736-6517-1-git-send-email-laurent.pinchart@ideasonboard.com>
	<9690842.n93imGlCHA@avalon>
	<CAF6AEGt+gwUq-xGze5bTgrKUMRijSBo_ORreq=Ot1RMD-WrbYQ@mail.gmail.com>
	<1563062.kh1jqNm1kH@avalon>
	<CAN_cFWPyrvO5RAvMHhZgQySf_Y5N2pz64uMurvdG0d-4zDjPFQ@mail.gmail.com>
In-Reply-To: <CAN_cFWPyrvO5RAvMHhZgQySf_Y5N2pz64uMurvdG0d-4zDjPFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rob Clark <rob.clark@linaro.org>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Tom Gall <tom.gall@linaro.org>, Ragesh Radhakrishnan <ragesh.r@linaro.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, Kyungmin Park <kyungmin.park@samsung.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Benjamin Gaignard <benjamin.gaignard@linaro.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Vikas Sajjan <vikas.sajjan@linaro.org>, Sumit Semwal <sumit.semwal@linaro.org>, Sebastien Guiriec <s-guiriec@ti.com>, "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>

Hi Laurent,

CDF will also be helpful in supporting Panels with integrated
audio (HDMI/DP) if we can add audio related control operations to
display_entity_control_ops. Video controls will be called by crtc
in DRM/V4L and audio controls from Alsa.

Secondly, if I need to support get_modes operation in hdmi/dp
panel, I need to implement edid parser inside the panel driver. It
will be meaningful to add get_edid control operation for hdmi/dp.

regards,
Rahul Sharma.

On Tue, Jan 8, 2013 at 9:43 PM, Rob Clark <rob.clark@linaro.org> wrote:
> On Tue, Jan 8, 2013 at 2:25 AM, Laurent Pinchart
> <laurent.pinchart@ideasonboard.com> wrote:
>> Hi Rob,
>>
>> On Thursday 27 December 2012 09:54:55 Rob Clark wrote:
>>> What I've done to avoid that so far is that the master device registers the
>>> drivers for it's output sub-devices before registering it's own device.
>>
>> I'm not sure to follow you here. The master device doesn't register anything,
>> do you mean the master device driver ? If so, how does the master device
>> driver register its own device ? Devices are not registered by their driver.
>
> sorry, that should have read "master driver registers drivers for it's
> sub-devices.."
>
> BR,
> -R
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> http://lists.freedesktop.org/mailman/listinfo/dri-devel
