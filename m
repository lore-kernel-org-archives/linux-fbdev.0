From: Zhou Zhu <zzhu3@marvell.com>
Date: Fri, 21 Jun 2013 02:41:41 +0000
Subject: Re: MMP display subsystem questions
Message-Id: <51C3BD65.8070206@marvell.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CAMLZHHTmSzzcL-aqk6rMjuD8Ct2zno--p7tUGfVVsocWiyhf8A@mail.gmail.com>
In-Reply-To: <CAMLZHHTmSzzcL-aqk6rMjuD8Ct2zno--p7tUGfVVsocWiyhf8A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi, Daniel,

Thank you for using our soc/drivers and thank you for your suggestions.
Please see our comments below.

On 06/20/2013 01:26 AM, Daniel Drake wrote:
> Is there a design document available somewhere? There are very few
> explanatory comments in the code. I am interested in definitions and
> explanations of:
>   - Paths
>   - Overlays
>   - dmafetch (part of overlay configuration)
>   - path_config (part of path configuration)
>   - link_config (part of path configuration)
>
> Looking at the code for answers, I am a little confused.
I admit it's an issue of no documents. We would submit a patch to add 
description under Documentation soon later.
>
> A path is an output device (e.g. a panel or TV). There can be multiple
> outputs connected to the display controller. At the moment I am just
> working with a single dumb panel.
>
> A path can have many overlays, and according to the original commit
> message, an overlay is a buffer displayed on the path's output device.
> However, I simply cannot see how multiple overlays would be supported
> on a path. For example let's look at this function:
>
> static int overlay_set_addr(struct mmp_overlay *overlay, struct mmp_addr *addr)
> {
> struct lcd_regs *regs = path_regs(overlay->path);
>
> /* FIXME: assert addr supported */
> memcpy(&overlay->addr, addr, sizeof(struct mmp_win));
> writel(addr->phys[0], &regs->g_0);
>
> return overlay->addr.phys[0];
> }
>
> The overlay's address is written to a register that is specific to
> it's parent path. If we are dealing with two overlays, how does this
> work? We write both overlay addresses to the same register and the
> second one "wins"? I checked all of the other overlay-related
> functions and they all defer to the parent path as well.
>
> As an experiment I modified platform data to suggest that my path has
> 98 overlays and the framebuffer should run on overlay 33. Nonsense,
> but the framebuffer booted up as normal. It seems like there is
> something missing in this path/overlay relationship.
>
> What is the plan going forward for this overlay management? At the
> moment there is only one consumer of overlays in the kernel - the
> framebuffer driver. And the framebuffer will only ever use one. Who
> are the other intended in-kernel users of overlays?
We have already pushed patches to fix this issue and support overlays. 
Please see patches below:
[V2 7/7] video: mmp: add video layer set win/addr operations support
http://lists.infradead.org/pipermail/linux-arm-kernel/2013-June/175071.html
>
> Moving onto dmafetch_id. Can't find any documentation here. It looks
> like the only meaningful values are 0 and 1, and the only difference
> is that overlay_is_vid() returns 1 if dmafetch_id is 1, and 0
> otherwise. This causes some minor differences in the way registers get
> programmed, but I don't understand exactly what the consequences are
> here. My framebuffer works with dmafetch_id as both 0 and 1.
Yes it's a legacy config there. Please ignore it. We would submit a new 
patch totally remove it soon later.
>
> path_config: this value gets written to registers LCD_SCLK *and*
> IOPAD_CONTROL. The bit definitions in these registers are totally
> different. It seems like nonsense to share the same configuration
> value between two diversely different registers - what is going on
> here?
>
> link_config: Seems to have a dual meaning. Upper 4 bits can be used to
> specify dumb panel mode in registers like LCD_DUMB_CTRL. Bit 0 is
> totally unrelated and triggers "swap RB" i.e. use BGR instead of RGB,
> when dealing with totally different registers. Other bits are ignored.
> If "disorganised" bitfields are to be haphazardly invented in this way
> it would at least be nice to have documentation.
Actually we are using mixed configs here and it is not so clear.
We may update these config to separated configs with more clearly meanings.
Currently 4 fields is here:
SCLK source: select source clock for sclk. We have plan to remove it and 
move the source selection into common clock driver.
IOPAD CONTROL: for iopad control
DUMB CONTROL: for dumb panel mode
RB SWAP: for rb swaps in link. Actually it's do required as for some 
panels would swap r/b links.
We have 2 swaps there, one is after dma fetch for each overlay and 
another is in output after overlay mixing.
We could not simply use bgr format as input might be yuv for which yvu 
would not simple converted to bgr.
Also for input/output swap distinguish, a fix patch is there:
[V2 1/7] video: mmp: rb swap setting update for new LCD driver
http://lists.infradead.org/pipermail/linux-arm-kernel/2013-June/175070.html
We would push patches to make these configs more clear soon later and 
also these description would be added into adding Documentation patch.
>
> Moving onto the devicetree definition. It is clear that representing
> the display controller and the panel in the device tree makes sense;
> this can cause the appropriate probes to happen. But we additionally
> need to trigger the probe of the framebuffer driver. I am not sure if
> the framebuffer that Linux will setup is something that should be
> represented in the device tree (remember that we already have display
> controller and panel). Looking at the configuration items needed to
> setup the framebuffer:
>
> 1. Name - doesn't really matter.
>
> 2. Pixel format - surely this question applies to all framebuffer
> drivers. I guess there is a default, plus a standard framebuffer
> interface that allows it to be changed?
Yes you are right, it's just a default value and would be changed after 
system boot.
>
> 3. Which path to use - how do other framebuffer drivers deal with
> this? The question here is basically do we output to the laptop's
> inbuilt LCD panel, or to the externally connected HDMI TV? Again,
> maybe we can choose a sensible default and allow runtime
> configuration.
Actually in our usage mode, we'd rather prefer to make one fb connected 
to one path.
In many usage mode, we may need 2 or more devices (panel, external 
tv...) turned on together so 2 or more fb devices are required to 
connect to separate path.
>
> 4. Which overlay to use - according to my investigation above, this
> doesn't actually have any meaningful effect on the driver.
As overlay enabled in patch above now, this config is required to make 
fb show on some overlay and other interface(v4l2, private interface) to 
use others.
>
> 5. dmafetch_id - its not clear to me what this is.
>
>
> So, I don't think the framebuffer is something that should be defined
> by the platform (or the device tree). Instead, maybe it should just be
> initialized with good defaults when the first path becomes ready for
> use.
So according to comments above, fb buffer is still need to be configure 
in dts for path/overlay configs.
Also there still might be some settings in fb for some further settings 
like vsync usage or yres_virtual size in coming patches.
>
> Any clarifications appreciated.
>
> Thanks
> Daniel
>

-- 
Thanks,
-Zhou
