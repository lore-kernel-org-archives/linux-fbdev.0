From: Mitch Bradley <wmb@firmworks.com>
Date: Mon, 08 Oct 2012 16:34:12 +0000
Subject: Re: [PATCH 1/2 v6] of: add helper to parse display timings
Message-Id: <50730084.3060805@firmworks.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1349373560-11128-1-git-send-email-s.trumtrar@pengutronix.de>
 <1349373560-11128-2-git-send-email-s.trumtrar@pengutronix.de>
 <Pine.LNX.4.64.1210042307300.3744@axis700.grange>
 <506F0833.1090704@wwwdotorg.org>
 <Pine.LNX.4.64.1210081000530.11034@axis700.grange>
 <1349686878.3227.40.camel@deskari>
In-Reply-To: <1349686878.3227.40.camel@deskari>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
Cc: linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Steffen Trumtrar <s.trumtrar-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 10/7/2012 11:01 PM, Tomi Valkeinen wrote:
> On Mon, 2012-10-08 at 10:25 +0200, Guennadi Liakhovetski wrote:
> 
>> In general, I might be misunderstanding something, but don't we have to 
>> distinguish between 2 types of information about display timings: (1) is 
>> defined by the display controller requirements, is known to the display 
>> driver and doesn't need to be present in timings DT. We did have some of 
>> these parameters in board data previously, because we didn't have proper 
>> display controller drivers... (2) is board specific configuration, and is 
>> such it has to be present in DT.
>>
>> In that way, doesn't "interlaced" belong to type (1) and thus doesn't need 
>> to be present in DT?
> 
> As I see it, this DT data is about the display (most commonly LCD
> panel), i.e. what video mode(s) the panel supports. If things were done
> my way, the panel's supported timings would be defined in the driver for
> the panel, and DT would be left to describe board specific data, but
> this approach has its benefits.
> 
> Thus, if you connect an interlaced panel to your board,


Do interlaced panels exist?  I have never seen one.


 you need to tell
> the display controller that this panel requires interlace signal. Also,
> pixel clock source doesn't make sense in this context, as this doesn't
> describe the actual used configuration, but only what the panel
> supports.
> 
> Of course, if this is about describing the hardware, the default-mode
> property doesn't really fit in...
> 
>  Tomi
> 
> 
> 
> _______________________________________________
> devicetree-discuss mailing list
> devicetree-discuss@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/devicetree-discuss
> 
