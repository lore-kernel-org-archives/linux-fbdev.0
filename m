From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Tue, 20 Sep 2011 19:52:36 +0000
Subject: Re: [PATCH] fbdev: sh_mobile_lcdc: Turn dot clock on before resuming
Message-Id: <4E78EF04.7000900@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1310387754-23033-1-git-send-email-laurent.pinchart@ideasonboard.com>
In-Reply-To: <1310387754-23033-1-git-send-email-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi Laurent,

On 09/20/2011 07:30 PM, Laurent Pinchart wrote:
> Hi Florian,
> 
> On Monday 11 July 2011 14:35:54 Laurent Pinchart wrote:
>> Resuming from runtime PM restores all LCDC registers. If the dot clock
>> is off at that time display panning information will be corrupted.
>>
>> Turn the dot clock on before resuming from runtime PM. Similarly,
>> turn the clock off after suspending the LCDC.
> 
> Could you please pick this patch for v3.2 ?

I assume you meant the currently developed 3.1? (as 3.2 is the next one for
which the patch is lying in my fbdev-next anyway)
Uhm, I originally didn't plan to ask Linus pulling anything before getting rid
of the old stuff, but okay, will go through my patches in the next days and look
what else is appropriate unless Linus beats me and releases 3.1 (although I do
not consider this likely as long as kernel.org is still down)


Best regards,

Florian Tobias Schandinat
