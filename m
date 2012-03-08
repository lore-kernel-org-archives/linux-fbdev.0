From: James Simmons <jsimmons@infradead.org>
Date: Thu, 08 Mar 2012 16:55:53 +0000
Subject: Re: [RFC] FB_MODE_IS_* usage
Message-Id: <alpine.LFD.2.02.1203081649580.1375@casper.infradead.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <2317885.WEEKmd8lWO@avalon>
In-Reply-To: <2317885.WEEKmd8lWO@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

> Hi everybody,
> 
> While going through users of the fb_videomode structure, I realized that some 
> of the FB_MODE_IS_* flags didn't seem to be used for any practical purpose.
> 
> The flags are defined as
> 
> #define FB_MODE_IS_UNKNOWN      0
> #define FB_MODE_IS_DETAILED     1
> #define FB_MODE_IS_STANDARD     2
> #define FB_MODE_IS_VESA         4
> #define FB_MODE_IS_CALCULATED   8
> #define FB_MODE_IS_FIRST        16
> #define FB_MODE_IS_FROM_VAR     32
> 
> - FB_MODE_IS_UNKNOWN isn't used at all

This was for weird situations. 
 
> - FB_MODE_IS_DETAILED is set by the EDID parser for modes coming from detailed 
> timing descriptors, and checked right after to work around monitors that 
> report the "Preferred timing mode specified in descriptor block 1" bit in 
> their EDID block, but don't report any detailed timing descriptor. 
> FB_MODE_IS_DETAILED is thus only used internally in the EDID parser.
> 
> - FB_MODE_IS_STANDARD, FB_MODE_IS_VESA and FB_MODE_IS_CALCULATED are set but 
> never used.

The reasoning behind this was struct fb_info contains a struct fb_monspecs 
which had a private database of modes. So when the driver would unload 
that it would skip deleting this entries. That way if drivers needed 
special modes besides the standard modes it db could contain them.

> - FB_MODE_IS_FIRST is set by the EDID parser on the first detailed mode, and 
> checked by fb_find_best_display() and a couple of drivers (fsl-diu-fb, 
> sh_mobile_hdmi, aty and riva) to locate the first detailed mode (I will check 
> if I can modify those 4 drivers to use fb_find_best_display() or something 
> similar).

Okay.

> - FB_MODE_IS_FROM_VAR is set but never used.

Again in the case of using the private db the driver would mark that mode
with this flag so it would be aware that it is safe to delete.

> If I can remove direct use of the FB_MODE_IS_FIRST flag in the drivers 
> mentioned above, the FB_MODE_IS_DETAILED and FB_MODE_IS_FIRST flags will only 
> be used internally in the EDID parser. All the other flags are either not used 
> at all, or set but never read.
> 
> I'm working on sharing the EDID parser between DRM/KMS, FB and V4L2. The 
> FB_MODE_IS_FIRST and FB_MODE_IS_DETAILED flags will thus become unused. Is 
> there any objection to removing them then ?

Yah !!!

