From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 30 Apr 2013 10:28:42 +0000
Subject: Re: [PATCH V2] video: implement a simple framebuffer driver
Message-Id: <201304301228.42245.arnd@arndb.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1365043183-28905-1-git-send-email-swarren@wwwdotorg.org>
 <517F7245.2050606@iki.fi>
In-Reply-To: <517F7245.2050606@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tuesday 30 April 2013, Tomi Valkeinen wrote:

> The bootloader would init the display hardware, the bootfb would give an
> early /dev/fb0 for the kernel and userspace, and when the real display
> driver is loaded, the bootfb would be unbound and the real driver would
> take over.

I think that's a great idea. What I'm not sure about is how that
infrastructure for switching frame buffers would work and how hard
it's to write.

	Arnd
