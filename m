From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Thu, 08 Dec 2016 22:00:28 +0000
Subject: Re: [RFC PATCH 0/3] staging: remove fbdev drivers
Message-Id: <5849D7FC.8030200@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1479888193-23908-1-git-send-email-tomi.valkeinen@ti.com>
 <20161123085234.GB3122@kroah.com>
 <230111fb-498e-11ef-b452-157a36d7f021@ti.com>
In-Reply-To: <230111fb-498e-11ef-b452-157a36d7f021@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-fbdev@vger.kernel.org, Teddy Wang <teddy.wang@siliconmotion.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Arnaud Patard <arnaud.patard@rtp-net.org>

On Wednesday 23 November 2016 09:12 AM, Tomi Valkeinen wrote:
> On 23/11/16 10:52, Greg Kroah-Hartman wrote:
>> On Wed, Nov 23, 2016 at 10:03:10AM +0200, Tomi Valkeinen wrote:
>>> Hi,
>>>
>>> Since the fbdev framework is in maintenance mode and all new display drivers
>>> should be made with the DRM framework, remove the fbdev drivers from staging.
>>>
<snip>
>
> Or do you mean that we should keep the drivers in staging until there's
> a matching DRM driver, but drop any plans to move the drivers from
> staging to drivers/video/? If so, I'm fine with that. This is an RFC,
> mostly to raise some discussion and push people to actually write those
> DRM drivers =).

I already have plans to convert my drivers to DRM. But it will be great 
if you can point me to a simple driver which will help me to understand 
how DRM works.

Regards
Sudip
