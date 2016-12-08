From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 08 Dec 2016 21:23:30 +0000
Subject: Re: [RFC PATCH 0/3] staging: remove fbdev drivers
Message-Id: <1481232210.26959.47.camel@kernel.crashing.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1479888193-23908-1-git-send-email-tomi.valkeinen@ti.com>
 <1481158879.26959.41.camel@kernel.crashing.org>
 <035da7a8-5a3f-1ef6-f686-479773e78084@ti.com>
In-Reply-To: <035da7a8-5a3f-1ef6-f686-479773e78084@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Noralf =?ISO-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Teddy Wang <teddy.wang@siliconmotion.com>, Arnaud Patard <arnaud.patard@rtp-net.org>, airlied@linux.ie
Cc: linux-kernel@vger.kernel.org

On Thu, 2016-12-08 at 10:01 +0200, Tomi Valkeinen wrote:
> 
> > DRM drivers don't strike me as suitable for small/slow cores with dumb
> > framebuffers or simple 2D only accel, such as the one found in the ASpeed
> > BMCs.
> 
> Then the DRM framework should be improved to be suitable.

Dave ? :-)

> > With drmfb you basically have to shadow everything into memory & copy
> > over everything, and locks you out of simple 2D accel. For a simple text
> > console the result is orders of magnitude slower and memory hungry than
> > a simple fbdev.
> 
> I don't think that's true. You can have a single fbdev buffer and blit
> there all you want, afaik.

Well, I had that argument with Dave Airlie which I CCed. The "dumb" ones like
bochsdrmfb, cirrusdrmfb, astdrmfb ... all use shadowing, meaning they use a
lot more memory and cannot do any 2D acceleration for fbcon.

From memory, David claimed you cannot directly work on the fb with a "proper"
DRM driver. Maybe I misunderstood but then the DRM shines by its complete
absence of useful documentation mixed with bazillion layers of APIs and helpers
so it's pretty hard to get ones head around it without wasting very large amounts
of time which I don't have at the moment.

> > Not everything has a powerful 3D GPU.
> 
> We don't use GPU on OMAPs (except for 3D).

The CPU in an OMAP is order of magnitude faster than what I have in an
Aspeed BMC though.

Ben.

