From: Ingo Molnar <mingo@kernel.org>
Date: Wed, 18 Dec 2013 11:54:23 +0000
Subject: Re: [RFC] x86: sysfb: remove sysfb when probing real hw
Message-Id: <20131218115423.GA23692@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <s5hk3f2v15r.wl%tiwai@suse.de>
 <1387367283-20078-1-git-send-email-dh.herrmann@gmail.com>
In-Reply-To: <1387367283-20078-1-git-send-email-dh.herrmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Herrmann <dh.herrmann@gmail.com>
Cc: linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.de>, Stephen Warren <swarren@wwwdotorg.org>, the arch/x86 maintainers <x86@kernel.org>, linux-fbdev@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>


* David Herrmann <dh.herrmann@gmail.com> wrote:

> If we probe a real hw driver for graphics devices, we need to unload any
> generic fallback driver like efifb/vesafb/simplefb on the system
> framebuffer. This is currently done via remove_conflicting_framebuffers()
> in fbmem.c. However, this only removes the fbdev driver, not the fake
> platform devices underneath. This hasn't been a problem so far, as efifb
> and vesafb didn't store any resources there. However, with simplefb this
> changed.
> 
> To correctly release the IORESOURCE_MEM resources of simple-framebuffer
> platform devices, we need to unregister the underlying platform device
> *before* probing any new hw driver. This patch adds sysfb_unregister() for
> that purpose. It can be called from any context (except from the
> platform-device ->remove callback path) and synchronously unloads any
> global sysfb and prevents new sysfbs from getting registered. Thus, you
> can call it even before any sysfb has been loaded.
> 
> This also changes remove_conflicting_framebuffer() to call this helper
> *before* trying it's fbdev heuristic to remove conflicting drivers.
> 
> Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
> ---
> Hi
> 
> This is imho the clean version of Takashi's fix. However, it gets pretty huge. I
> wouldn't object to marking CONFIG_X86_SYSFB broken in the stable series and get
> this in for 3.14. Your call..
> 
> This patch basically simulates an unplug event for system-framebuffers when
> loading real hardware drivers. To trigger it, call sysfb_unregister(). You can
> optionally pass an aperture-struct and primary-flag similar to
> remove_conflicting_framebuffers(). If they're not passed, we remove it
> unconditionally.
> 
> Untested, but my kernel compiles are already running. If my tests succeed and
> nobody has objections, I can resend it as proper PATCH and marked for stable.
> And maybe split the fbmem and sysfb changes into two patches..

Please fix the changelog to conform to the standard changelog style:

 - first describe the symptoms of the bug - how does a user notice? 

 - then describe how the code behaves today and how that is causing the bug

 - and then only describe how it's fixed.

The first item is the most important one - while developers 
(naturally) tend to concentrate on the least important point, the last 
one.

Thanks,

	Ingo
