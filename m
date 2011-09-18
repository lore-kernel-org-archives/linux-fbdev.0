From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Sun, 18 Sep 2011 19:29:57 +0000
Subject: Re: [PATCH 0/2] video: s3c-fb: Add window positioning support
Message-Id: <4E7646B5.6000000@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1314301917-9938-1-git-send-email-ajaykumar.rs@samsung.com>
	<4E5FB69E.2060907@gmx.de>
	<201109071731.02293.laurent.pinchart@ideasonboard.com>
In-Reply-To: <201109071731.02293.laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Laurent,

On 09/07/2011 03:31 PM, Laurent Pinchart wrote:
> Hi Florian,
> 
> On Thursday 01 September 2011 18:45:18 Florian Tobias Schandinat wrote:
>> Hi all,
>>
>> On 08/25/2011 07:51 PM, Ajay Kumar wrote:
>>> Just as a note, there are many drivers like mx3fb.c, au1200fb.c and OMAP
>>> seem to be doing window/plane positioning in their driver code.
>>> Is it possible to have this window positioning support at a common place?
>>
>> Good point. Congratulations for figuring out that I like to standardize
>> things. But I think your suggestion is far from being enough to be useful
>> for userspace (which is our goal so that applications can be reused along
>> drivers and don't need to know about individual drivers).
> 
> Beside standardizing things, do you also like to take them one level higher to 
> solve challenging issues ? I know the answer must be yes :-)
> 
> The problem at hand here is something we have solved in V4L2 (theoretically 
> only for part of it) with the media controller API, the V4L2 subdevs and their 
> pad-level format API.
> 
> In a nutshell, the media controller lets drivers model hardware as a graph of 
> buliding blocks connected through their pads and expose that description to 
> userspace applications. In V4L2 most of those blocks are V4L2 subdevs, which 
> are abstract building blocks that implement sets of standard operations. Those 
> operations are exposed to userspace through the V4L2 subdevs pad-level format 
> API, allowing application to configure sizes and selection rectangles at all 
> pads in the graph. Selection rectangles can be used to configure cropping and 
> composing, which is exactly what the window positioning API needs to do.
> 
> Instead of creating a new fbdev-specific API to do the same, shouldn't we try 
> to join forces ?

Okay, thanks for the pointer. After having a look at your API I understand that
it would solve the problem to discover how many windows (in this case) are there
and how they can be accessed. It looks fine for this purpose, powerful enough
and not too complex. So if I get it correct we still need at least a way to
configure the position of the windows/overlays/sink pads similar to what Ajay
proposed. Additionally a way to get and/or set the z-position of the overlays if
multiple overlays overlap and set/get how the overlays work (overdraw, constant
alpha, source/destination color keying). Normally I'd consider these link
properties but I think implementing them as properties of the source framebuffer
or sink pad would work as well.
Is this correct or did I miss something?


Best regards,

Florian Tobias Schandinat
