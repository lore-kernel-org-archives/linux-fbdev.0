From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 08 Dec 2016 21:43:13 +0000
Subject: Re: [RFC PATCH 0/3] staging: remove fbdev drivers
Message-Id: <1481233393.26959.53.camel@kernel.crashing.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1479888193-23908-1-git-send-email-tomi.valkeinen@ti.com>
 <1481158879.26959.41.camel@kernel.crashing.org>
 <035da7a8-5a3f-1ef6-f686-479773e78084@ti.com>
 <1481232210.26959.47.camel@kernel.crashing.org>
In-Reply-To: <1481232210.26959.47.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Noralf =?ISO-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Teddy Wang <teddy.wang@siliconmotion.com>, Arnaud Patard <arnaud.patard@rtp-net.org>, airlied@linux.ie
Cc: linux-kernel@vger.kernel.org

On Fri, 2016-12-09 at 08:23 +1100, Benjamin Herrenschmidt wrote:
> > From memory, David claimed you cannot directly work on the fb with a "proper"
> 
> DRM driver. Maybe I misunderstood but then the DRM shines by its complete
> absence of useful documentation 

That sentence should have been in the past, it does look like
documentation has been landing in the tree this year ! yay ! I'll go
off read it.

> mixed with bazillion layers of APIs and helpers
> so it's pretty hard to get ones head around it without wasting very large amounts
> of time which I don't have at the moment.

Ben.

