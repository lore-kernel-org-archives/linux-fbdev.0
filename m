From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 30 Apr 2018 07:06:11 +0000
Subject: Re: [PATCH] video: fbdev: omap2: remove rfbi
Message-Id: <cd513378-7be2-a5eb-adc5-bf04c789f1d4@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20180427150914eucas1p14dd8df4a215014ddac990b0ccdb1805c@eucas1p1.samsung.com>
 <2238944.jilJcacc6d@amdc3058>
 <20180427174714.bdvvlljk3txwu2bo@darkstar.musicnaut.iki.fi>
 <2055912.iuafLNK0IC@amdc3058>
 <20180427181243.o7ro63l6z7yatey7@darkstar.musicnaut.iki.fi>
In-Reply-To: <20180427181243.o7ro63l6z7yatey7@darkstar.musicnaut.iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Aaro Koskinen <aaro.koskinen@iki.fi>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-fbdev@vger.kernel.org, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-omap@vger.kernel.org

On 27/04/18 21:12, Aaro Koskinen wrote:

>> You should be targeting omapdrm driver instead, fbdev subsystem is closed
>> for the new hardware support.
> 
> AFAIK, based on N950 display support discussion, it's impossible to get
> anything new into omapdrm for a long time. And based on Tomi's comments,
> restoring RFBI support with omapfb should be a minor thing.

I was perhaps a bit vague, but I didn't say it should be a minor thing.
I meant that there should be no architectural obstacles in omapfb, and I
think all the generic plumbing to enable N800 display is there in omapfb.

That said, it still needs a real amount of work with the rfbi driver,
the encoder driver and the panel driver on N800 (the encoder and the
panel driver are not in mainline anymore).

Also, if I remember right, omapfb doesn't support automatic updates (or
"flushing") with manual update displays. omapfb was designed to depend
on the userspace to flush the framebuffer. This may limit its uses.

I personally do think that it would be better to target omapdrm, on top
of the manual update series, but as discussed, the schedule to support
manual update is still unclear.

 Tomi

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
