From: David Lechner <david@lechnology.com>
Date: Sat, 29 Jul 2017 19:40:04 +0000
Subject: Re: [PATCH 0/6] Support for LEGO MINDSTORMS EV3 LCD display
Message-Id: <5d8f6518-8d7e-c029-2da4-e3417afb3e40@lechnology.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1501355870-13960-1-git-send-email-david@lechnology.com>
In-Reply-To: <1501355870-13960-1-git-send-email-david@lechnology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
Cc: =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>, David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, linux-fbdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

On 07/29/2017 02:17 PM, David Lechner wrote:
> The goal of this series is to get the built-in LCD of the LEGO MINDSTORMS EV3
> working. But, most of the content here is building up the infrastructure to do
> that.
> 

Some general comments/questions:

I have noticed that DRM doesn't really have support for monochrome 
displays. I'm guessing that is because no one really uses them anymore?

The LEGO EV3 display is just an LCD (not the backlit kind). It has two 
modes of operation. It can to 2bbp grayscale or it can do 1bpp 
monochrome. The grayscale isn't the best (looks splotchy in places), so 
it would be nice to be able to choose between these two modes. How would 
I implement something like that?

Also, how can I indicate to userspace that this display really is 
monochrome/grayscale since the reported color depth 16bpp?

