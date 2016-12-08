From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 08 Dec 2016 01:01:19 +0000
Subject: Re: [RFC PATCH 0/3] staging: remove fbdev drivers
Message-Id: <1481158879.26959.41.camel@kernel.crashing.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1479888193-23908-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1479888193-23908-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Noralf =?ISO-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Teddy Wang <teddy.wang@siliconmotion.com>, Arnaud Patard <arnaud.patard@rtp-net.org>
Cc: linux-kernel@vger.kernel.org

On Wed, 2016-11-23 at 10:03 +0200, Tomi Valkeinen wrote:
> Hi,
> 
> Since the fbdev framework is in maintenance mode and all new display drivers
> should be made with the DRM framework, remove the fbdev drivers from staging.
> 
> Note: the patches are created with git format-patch -D, so they can't be
> applied. Only for review.

I missed the discussion where this decision was made, I admit I am
unimpressed by it.

DRM drivers don't strike me as suitable for small/slow cores with dumb
framebuffers or simple 2D only accel, such as the one found in the ASpeed
BMCs.

With drmfb you basically have to shadow everything into memory & copy
over everything, and locks you out of simple 2D accel. For a simple text
console the result is orders of magnitude slower and memory hungry than
a simple fbdev.

At least that was the case last I looked at the DRM stuff with Dave,
maybe things have changed... 

Not everything has a powerful 3D GPU.

Ben.

