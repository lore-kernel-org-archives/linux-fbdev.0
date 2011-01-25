From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 25 Jan 2011 06:11:48 +0000
Subject: Re: [PATCH] video: da8xx-fb: fix fb_probe error path
Message-Id: <20110125061147.GC11673@linux-sh.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1295608686.3976.9.camel@phoenix> <1295495451.20884.3.camel@mola>
In-Reply-To: <1295608686.3976.9.camel@phoenix> <1295495451.20884.3.camel@mola>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Axel Lin <axel.lin@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, Sudhakar Rajashekhara <sudhakar.raj@ti.com>, Lennert Buytenhek <buytenh@marvell.com>, Green Wan <gwan@marvell.com>, Eric Miao <eric.y.miao@gmail.com>, Marek Vasut <marek.vasut@gmail.com>, Haojian Zhuang <haojian.zhuang@marvell.com>

On Thu, Jan 20, 2011 at 11:50:51AM +0800, Axel Lin wrote:
> Current implementation puts CONFIG_CPU_FREQ at wrong place, CONFIG_CPU_FREQ
> is for lcd_da8xx_cpufreq_deregister not for unregister_framebuffer.

On Fri, Jan 21, 2011 at 07:18:06PM +0800, Axel Lin wrote:
> Current implementation calls pxa168fb_check_var twice in pxa168fb_probe.

Both applied, thanks.
