From: Timur Tabi <timur@freescale.com>
Date: Thu, 17 Nov 2011 20:19:01 +0000
Subject: Re: [PATCH] fb: split out framebuffer initialization from allocation
Message-Id: <4EC56C35.2090102@freescale.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1321308088-6327-1-git-send-email-timur@freescale.com>
In-Reply-To: <1321308088-6327-1-git-send-email-timur@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Timur Tabi wrote:
> Introduce functions framebuffer_init() and framebuffer_cleanup() to allow
> the initialization of a user-allocated fb_info object.
> 
> framebuffer_alloc() allows for appending a private data structure when it
> allocates the fb_info object.  However, a driver that registers multiple
> framebuffers for one device may also need another private data structure
> for the device itself.  framebuffer_init() allows such drivers to store
> the fb_info objects in the device-specific private data structure,
> thereby simplifying memory allocation.
> 
> Signed-off-by: Timur Tabi <timur@freescale.com>

Florian,

Any comments on this patch?  If you're okay with the change, I want to take advantage of it in my framebuffer driver.

-- 
Timur Tabi
Linux kernel developer at Freescale

