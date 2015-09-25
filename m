From: Kamil Lulko <kamil.lulko@gmail.com>
Date: Fri, 25 Sep 2015 10:41:43 +0000
Subject: Re: No more new fbdev drivers, please
Message-Id: <560524E7.4020707@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <5603EC15.9090605@ti.com>
In-Reply-To: <5603EC15.9090605@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tomi.valkeinen@ti.com
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org

Hi,

> fbdev is (more or less) maintained, but it's a deprecated framework. All
> new Linux display drivers should be done on DRM.

What about no-mmu platforms? DRM has a big fat MMU dependency in the 
kconfig, is there a way to write DRM driver for such devices?

/Kamil
