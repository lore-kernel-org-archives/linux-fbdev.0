From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 30 Oct 2012 16:35:23 +0000
Subject: Re: [RFC 0/5] Generic panel framework
Message-Id: <3539590.nD15u1ceQC@avalon>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1345164583-18924-1-git-send-email-laurent.pinchart@ideasonboard.com> <CAGA24MLnW-i0koFuAsnFQ2mNnrLupkmbxW5T8WYiV3QuoA2vig@mail.gmail.com> <CAJATT-5=kQzUaubL--oRJdm6u8Z10Hus+SMLt3zG1ZSi4QUVWw@mail.gmail.com>
In-Reply-To: <CAJATT-5=kQzUaubL--oRJdm6u8Z10Hus+SMLt3zG1ZSi4QUVWw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Zhou Zhu <zzhu84@gmail.com>
Cc: Jun Nie <niej0001@gmail.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, linux-media@vger.kernel.org, Bryan Wu <bryan.wu@canonical.com>, Richard Purdie <rpurdie@rpsys.net>, Marcus Lorentzon <marcus.lorentzon@linaro.org>, Sumit Semwal <sumit.semwal@ti.com>, Archit Taneja <archit@ti.com>, Sebastien Guiriec <s-guiriec@ti.com>, Inki Dae <inki.dae@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>

Hi Zhou,

On Tuesday 04 September 2012 16:20:38 Zhou Zhu wrote:
> Hi Laurent,
> 
> Basically I agree that we need a common panel framework. I just have
> some questions:
> 1.  I think we should add color format in videomode - if we use such
> common video mode structure shared across subsystems.
> In HDMI, colors are bind with timings tightly. We need a combined
> videomode with timing and color format together.

What kind of color formats do you have in mind ?

> 2. I think we should add "set_videomode" interface. It helps HDMI
> monitors to set EDIDs.

For panels that support several video modes, sure, we need a way to set the 
video mode. I don't have access to any such panel though, that's why the 
operation has been left out. It wouldn't be difficult to add it when a real 
use case will come up.

What do you mean exactly about HDMI monitors setting EDID ?

-- 
Regards,

Laurent Pinchart

