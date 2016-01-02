From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Sat, 02 Jan 2016 12:39:19 +0000
Subject: Re: [PATCH 1/1] video: ARM CLCD: Add the framebuffer parameters setting in probe
Message-Id: <20160102123919.GY8644@n2100.arm.linux.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1451435928-22903-1-git-send-email-rjying@aliyun.com>
In-Reply-To: <1451435928-22903-1-git-send-email-rjying@aliyun.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rongjun Ying <rjying@aliyun.com>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Dec 30, 2015 at 08:38:48AM +0800, Rongjun Ying wrote:
> This patch fixes the user space applications can't get the framebuffer
> parameters, if disable the fb console feature.
> 
> Signed-off-by: Rongjun Ying <rjying@aliyun.com>

I think this behaviour is intentional: userspace is expected to
set the initial mode for non-console frame buffers by using
FBIOPUT_VSCREENINFO.

Otherwise, register_fb() would always set an initial mode on all
framebuffers.

I remember this being discussed years ago (more than a decade)
when the FB layer was relatively new.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
