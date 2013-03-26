From: Tony Lindgren <tony@atomide.com>
Date: Tue, 26 Mar 2013 17:10:07 +0000
Subject: Re: [PATCH 00/26] DSS device model change
Message-Id: <20130326171006.GG25575@atomide.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1364304836-18134-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1364304836-18134-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

* Tomi Valkeinen <tomi.valkeinen@ti.com> [130326 06:38]:
> Hi,
> 
> To make it possible to add DT support to DSS, and later use the Common Display
> Framework, we need to change the DSS device model. We currently have a custom
> dss bus, and omap_dss_devices on that bus, and the aim is to get rid of that
> bus.
> 
> The panel devices will be converted occording to the control bus of the panel.
> For many panels this means that the panel device will become a platform_device.
> For some, it means the panel devices become i2c or spi devices.
> 
> This series takes the first step toward that goal. This series:
> 
> * Converts DPI, HDMI and DSI outputs to work with new style panels
> * Converts TFP410, Taal and generic-dpi panels to new model
> * Converts Panda, 4430SDP and Overo boards to use the new panels
> 
> The non-converted outputs and panels still work, so they can be converted in
> stages.

This is nice, it removes a merge dependency between ARM code and the driver :)
 
> Note about board files: I only convert a few board files here for example. I
> have a branch with board file changes for all the affected board files. I did
> not include them as they are more or less identical. If this series looks good,
> I will create an independent branch for the arch/arm stuff, so it can be pulled
> separately.

Great looks good to me thanks.

Tony
