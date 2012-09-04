From: Zhou Zhu <zzhu84@gmail.com>
Date: Tue, 04 Sep 2012 08:20:38 +0000
Subject: Re: [RFC 0/5] Generic panel framework
Message-Id: <CAJATT-5=kQzUaubL--oRJdm6u8Z10Hus+SMLt3zG1ZSi4QUVWw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1345164583-18924-1-git-send-email-laurent.pinchart@ideasonboard.com>
	<3937256.gcqPRVoNWN@avalon>
	<1345528197.15491.8.camel@lappyti>
	<3648908.jA5PYymWxV@avalon>
	<CAGA24MLnW-i0koFuAsnFQ2mNnrLupkmbxW5T8WYiV3QuoA2vig@mail.gmail.com>
In-Reply-To: <CAGA24MLnW-i0koFuAsnFQ2mNnrLupkmbxW5T8WYiV3QuoA2vig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jun Nie <niej0001@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, linux-media@vger.kernel.org, Bryan Wu <bryan.wu@canonical.com>, Richard Purdie <rpurdie@rpsys.net>, Marcus Lorentzon <marcus.lorentzon@linaro.org>, Sumit Semwal <sumit.semwal@ti.com>, Archit Taneja <archit@ti.com>, Sebastien Guiriec <s-guiriec@ti.com>, Inki Dae <inki.dae@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>

Hi Laurent,

Basically I agree that we need a common panel framework. I just have
some questions:
1.  I think we should add color format in videomode - if we use such
common video mode structure shared across subsystems.
In HDMI, colors are bind with timings tightly. We need a combined
videomode with timing and color format together.
2. I think we should add "set_videomode" interface. It helps HDMI
monitors to set EDIDs.

-- 
Thanks,
-Zhou
