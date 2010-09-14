From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 14 Sep 2010 08:31:45 +0000
Subject: Re: [PATCH 00/15] ARM: mach-shmobile: HDMI hot-plug and improvements
Message-Id: <20100914083145.GL7336@linux-sh.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <Pine.LNX.4.64.1009030856020.2883@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1009030856020.2883@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Fri, Sep 03, 2010 at 09:19:45AM +0200, Guennadi Liakhovetski wrote:
> The main purpose of this patch set is supporting dynamic framebuffer 
> reconfiguration upon monitor hot-plug. The good thing is - it works. The 
> not so good thing is - only to the extent, that the current fbdev API 
> allows. Specifically, there is currently no possibility under the fbdev 
> API to inform framebuffer users about a changed framebuffer configuration, 
> as can easily be the case, when a new monitor has been plugged in. It is, 
> however, possible to inform in-kernel framebuffer users, e.g., the fbcon 
> console, about such a change, using framebuffer notifications. This patch 
> series implements support for monitor hot-plug on the hardware level, 
> i.e., the LCD and HDMI controllers get reconfigured for a new device. The 
> user configuration remains untouched. With this approach with a new 
> monitor plugged in, the user either gets to see the upper left corner of 
> the framebuffer image, or the whole framebuffer will be displayed in the 
> upper left corner of the display.
> 
> The patch series also contains a number of improvements to both the lcdc 
> and hdmi SH-Mobile drivers.
> 
> Based on the current (commit 410d878b) genesis-2.6/master tree.
> 
Applied, thanks.
