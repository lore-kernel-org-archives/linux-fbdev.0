From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Mon, 20 Feb 2012 16:40:02 +0000
Subject: Re: Kernel Display and Video API Consolidation mini-summit at ELC 2012 - Notes
Message-Id: <Pine.LNX.4.64.1202201709470.2836@axis700.grange>
List-Id: <linux-fbdev.vger.kernel.org>
References: <201201171126.42675.laurent.pinchart@ideasonboard.com>
 <1654816.MX2JJ87BEo@avalon> <1775349.d0yvHiVdjB@avalon>
In-Reply-To: <1775349.d0yvHiVdjB@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Sakari Ailus <sakari.ailus@maxwell.research.nokia.com>, Sumit Semwal <sumit.semwal@ti.com>, Jesse Barker <jesse.barker@linaro.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Rob Clark <rob@ti.com>, Pawel Osciak <pawel@osciak.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Tomasz Stanislawski <t.stanislaws@samsung.com>, Magnus Damm <magnus.damm@gmail.com>, Marcus Lorentzon <marcus.lorentzon@linaro.org>, Alexander Deucher <alexander.deucher@amd.com>, linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org

On Fri, 17 Feb 2012, Laurent Pinchart wrote:

[snip]

> ***  Synchronous pipeline changes ***
> 
>   Goal: Create an API to apply complex changes to a video pipeline atomically.
> 
>   Needed for complex camera use cases. On the DRM/KMS side, the approach is to
>   use one big ioctl to configure the whole pipeline.
> 
>   One solution is a commit ioctl, through the media controller device, that
>   would be dispatched to entities internally with a prepare step and a commit
>   step.
> 
>   Parameters to be committed need to be stored in a context. We can either use
>   one cross-device context, or per-device contexts that would then need to be
>   associated with the commit operation.
> 
>   Action points:
>   - Sakari will provide a proof-of-concept and/or proposal if needed.

I actually have been toying with a related idea, namely replacing the 
current ACTIVE / TRY configuration pair as not sufficiently clearly defined 
and too restrictive with a more flexible concept of an arbitrary number of 
configuration contexts. The idea was to allow the user to create such 
contexts and use atomic commands to instruct the pipeline to switch between 
them. However, as I started writing down an RFC, this was exactly the point, 
where I stopped: what defines a configuration and in which order shall 
configuration commands be executed when switching between them?

In short, my idea was to allow contexts to contain any configuration 
options: not only geometry and pixel format as what TRY is using ATM, but 
also any controls. The API would add commands like

	handle = context_alloc(mode);
	/*
	 * mode can be DEFAULT to start a new configuration, based on
	 * driver defaults, or CLONE to start with the currently active
	 * configuration
	 */
	context_configure(handle);
	/*
	 * all configuration commands from now on happen in the background
	 * and only affect the specified context
	 */
	/* perform any configuration */
	context_switch(handle);
	/* activate one of pre-configured contexts */

The problem, however, is, how to store contexts and how to perform the 
switch. We would, probably, have to define a notion of a "complete 
configuration," which would consist of some generic parameters and, 
optionally, driver-specific ones. Then the drivers (in the downstream 
order?) would just be instructed to switch to a specific configuration 
and each of them would then decide in which order they have to commit 
specific parameters. This must assume, that regardless in what state a 
device currently is, switching to context X always produces the same 
result.

Alternative approaches, like, store each context as a sequence of 
user-provided configuration commands, and play them back, when switching, 
would produce unpredictable results, depending on the state, before the 
switch, especially when using the CLONE context-creation mode.

Anyway, my tuppence to consider.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
