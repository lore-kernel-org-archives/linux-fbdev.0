From: Jyri Sarha <jsarha@ti.com>
Date: Fri, 28 Aug 2015 13:46:49 +0000
Subject: Re: [PATCH v2] OMAPDSS: hdmi: Reconfigure and restart audio when display is enabled
Message-Id: <55E06649.5070701@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1440764660-10417-1-git-send-email-jsarha@ti.com>
 <55E05C60.2090400@ti.com>
In-Reply-To: <55E05C60.2090400@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: peter.ujfalusi@ti.com

On 08/28/15 16:04, Tomi Valkeinen wrote:
...
> The question is (which was my point in the earlier mail), we already
> have mutex, so why a new spinlock?
>
> I think the answer is that audio start/stop (anything else?) are called
> in atomic context, so mutex cannot be used.
>

Yes, that is correct.

> Also (not exactly related to this patch), if the audio callbacks must be
> atomic, could we use a workqueue to run the audio start/stop work in
> non-atomic context? Protecting the whole hdmi state with a single mutex
> would be much nicer.

The reason why the audio start and stop are done in atomic context is 
for audio synchronization to other audio devices or video stream to be 
more accurate.

I guess in theory a work queue could be used to serialize the audio 
commands, but that would ruin the whole point of why the start and stop 
commands are atomic in the first place.

Cheers,
Jyri

