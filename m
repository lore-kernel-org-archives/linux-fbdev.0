From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Tue, 20 Sep 2011 20:19:25 +0000
Subject: Re: [PATCH] fbdev: sh_mobile_lcdc: Turn dot clock on before resuming
Message-Id: <4E78F54D.1070304@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1310387754-23033-1-git-send-email-laurent.pinchart@ideasonboard.com>
In-Reply-To: <1310387754-23033-1-git-send-email-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi Laurent,

On 09/20/2011 07:56 PM, Laurent Pinchart wrote:
> Hi Florian,
> 
> On Tuesday 20 September 2011 21:52:36 Florian Tobias Schandinat wrote:
>> On 09/20/2011 07:30 PM, Laurent Pinchart wrote:
>>> On Monday 11 July 2011 14:35:54 Laurent Pinchart wrote:
>>>> Resuming from runtime PM restores all LCDC registers. If the dot clock
>>>> is off at that time display panning information will be corrupted.
>>>>
>>>> Turn the dot clock on before resuming from runtime PM. Similarly,
>>>> turn the clock off after suspending the LCDC.
>>>
>>> Could you please pick this patch for v3.2 ?
>>
>> I assume you meant the currently developed 3.1? (as 3.2 is the next one for
>> which the patch is lying in my fbdev-next anyway)
> 
> No, I meant v3.2. As I haven't received any pull notification in response to 
> the patch, and as I had no way to check your fbdev-next tree on kernel.org, I 
> just wanted to make sure the patch would be queued for v3.2.

Just for your info, my tree [1] never was on kernel.org, you can see the patch
in it here [2] (webfrontend). Looks like the patch I got come from your pull
request "SH mobile LCDC cleanups and fixes", hope that's the right version.


Best regards,

Florian Tobias Schandinat


[1] git://github.com/schandinat/linux-2.6.git
[2]
https://github.com/schandinat/linux-2.6/commit/f1ad90da5c0fcb8841cc5e6d66c56f4005d8c960

