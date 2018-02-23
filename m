From: Jonathan Corbet <corbet@lwn.net>
Date: Fri, 23 Feb 2018 15:23:41 +0000
Subject: Re: [PATCH v2 0/3] backlight: document sysfs interfaces
Message-Id: <20180223082341.5f19f8d2@lwn.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1517902411.git.aishpant@gmail.com>
In-Reply-To: <cover.1517902411.git.aishpant@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Aishwarya Pant <aishpant@gmail.com>
Cc: Daniel Thompson <daniel.thompson@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Jingoo Han <jingoohan1@gmail.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>, Greg KH <gregkh@linuxfoundation.org>, Lee Jones <lee.jones@linaro.org>

On Tue, 6 Feb 2018 13:08:41 +0530
Aishwarya Pant <aishpant@gmail.com> wrote:

> Patchset contains documentation of the sysfs interfaces for the
> following five backlight drivers-
> 1) lm3639
> 2) adp5520
> 3) adp8860
> 
> It was compiled from data sheets, reading code and git history logs. In v2 of
> the patches, documentation for lp8788 and lp855x devices was dropped as the
> attributes contained debug information.

I've applied the set to the docs tree, thanks.

jon
