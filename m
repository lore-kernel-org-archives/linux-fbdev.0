From: Jun Nie <niej0001@gmail.com>
Date: Thu, 17 May 2012 02:46:37 +0000
Subject: Re: Kernel Display and Video API Consolidation mini-summit at ELC 2012 - Notes
Message-Id: <CAGA24M+OEwi-ayBrXcMPg5PzndRF4mSr2dOOQAxhDCu6ShZLjQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <201201171126.42675.laurent.pinchart@ideasonboard.com>
	<1654816.MX2JJ87BEo@avalon>
	<1775349.d0yvHiVdjB@avalon>
	<20120217095554.GA5511@phenom.ffwll.local>
	<Pine.LNX.4.64.1202201633100.2836@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1202201633100.2836@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Daniel Vetter <daniel@ffwll.ch>, Tomasz Stanislawski <t.stanislaws@samsung.com>, linux-fbdev@vger.kernel.org, Sakari Ailus <sakari.ailus@maxwell.research.nokia.com>, Pawel Osciak <pawel@osciak.com>, Magnus Damm <magnus.damm@gmail.com>, Marcus Lorentzon <marcus.lorentzon@linaro.org>, dri-devel@lists.freedesktop.org, Alexander Deucher <alexander.deucher@amd.com>, Rob Clark <rob@ti.com>, linux-media@vger.kernel.org, Marek Szyprowski <m.szyprowski@samsung.com>

    Is there any discussion on HDCP on the summit? It is tightly
coupled with HDMI and DVI and should be managed together with the
transmitter. But there is not code to handle HDCP in DRM/FB/V4L in
latest kernel. Any thoughts on HDCP? Or you guys think there is risk
to support it in kernel? Thanks for your comments!

Jun
