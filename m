From: Pawel Moll <pawel.moll@arm.com>
Date: Thu, 06 Mar 2014 15:23:51 +0000
Subject: Re: [PATCH v5 1/2] video: ARM CLCD: Add DT support
Message-Id: <1394119431.4160.84.camel@hornet>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1394036606-17784-1-git-send-email-pawel.moll@arm.com>
 <53184C2E.3000807@ti.com>
In-Reply-To: <53184C2E.3000807@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, 2014-03-06 at 10:21 +0000, Tomi Valkeinen wrote:
> Is this an old HW, and presumably there won't be new users for it? If
> yes, this is probably fine. 

There is a DRM driver in the works, actually...

> If not, you might want to look at the video
> ports and endpoints, which is used by at least three not-yet-merged series:
> 
> [PATCHv3 00/41] OMAPDSS: DT support v3
> [PATCH v5 00/11] imx-drm dt bindings
> [RFC PATCH v2 00/21] Add DSI display support for Exynos based boards
> 
> Using bindings like that would be more future proof, even if the current
> driver doesn't use them.

... and this makes me try to get out of its way. In other words, I fully
agree with you, but I don't think this applies to this particular patch,
as I'm not even trying to represent the display pipeline. The (optional)
"display-timings" sub-node has been "borrowed" from other older drivers
and can be easily deprecated in the future, replaced by standard ones
(whatever final shape they will take :-). All other extra properties are
CLCD-specific and orthogonal.

Pawel

