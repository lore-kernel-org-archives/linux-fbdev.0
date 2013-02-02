From: Rob Clark <rob.clark@linaro.org>
Date: Sat, 02 Feb 2013 10:08:33 +0000
Subject: Re: [RFC v2 0/5] Common Display Framework
Message-Id: <CAF6AEGvcT27FRo4Zv3UvftqmqZYe4ReQsmddnO+WT9qpZj=z7Q@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1353620736-6517-1-git-send-email-laurent.pinchart@ideasonboard.com>
	<CAN_cFWPyrvO5RAvMHhZgQySf_Y5N2pz64uMurvdG0d-4zDjPFQ@mail.gmail.com>
	<CAPdUM4P6riQVJ4m4Sdkh1O8xmpKF4YnhGq69p7DkxAdr165KYA@mail.gmail.com>
	<1699935.hiBjgCN6cp@avalon>
In-Reply-To: <1699935.hiBjgCN6cp@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Rahul Sharma <r.sh.open@gmail.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Benjamin Gaignard <benjamin.gaignard@linaro.org>, Tom Gall <tom.gall@linaro.org>, Kyungmin Park <kyungmin.park@samsung.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, Ragesh Radhakrishnan <ragesh.r@linaro.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Philipp Zabel <p.zabel@pengutronix.de>, Maxime Ripard <maxime.ripard@free-electrons.com>, Vikas Sajjan <vikas.sajjan@linaro.org>, Sumit Semwal <sumit.semwal@linaro.org>, Sebastien Guiriec <s-guiriec@ti.com>, "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>

On Fri, Feb 1, 2013 at 5:42 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> Hi Rahul,
>
> On Wednesday 09 January 2013 13:53:30 Rahul Sharma wrote:
>> Hi Laurent,
>>
>> CDF will also be helpful in supporting Panels with integrated audio
>> (HDMI/DP) if we can add audio related control operations to
>> display_entity_control_ops. Video controls will be called by crtc in DRM/V4L
>> and audio controls from Alsa.
>
> I knew that would come up at some point :-) I agree with you that adding audio
> support would be a very nice improvement, and I'm totally open to that, but I
> will concentrate on video, at least to start with. The first reason is that
> I'm not familiar enough with ALSA, and the second that there's only 24h per
> day :-)
>
> Please feel free, of course, to submit a proposal for audio support.
>
>> Secondly, if I need to support get_modes operation in hdmi/dp panel, I need
>> to implement edid parser inside the panel driver. It will be meaningful to
>> add get_edid control operation for hdmi/dp.
>
> Even if EDID data is parsed in the panel driver, raw EDID will still need to
> be exported, so a get_edid control operation (or something similar) is
> definitely needed. There's no disagreement on this, I just haven't included
> that operation yet because my test hardware is purely panel-based.

one of (probably many) places that just keeping CDF (CDH? common
display helpers..) inside DRM makes life easier :-P

BR,
-R

> --
> Regards,
>
> Laurent Pinchart
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-media" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
