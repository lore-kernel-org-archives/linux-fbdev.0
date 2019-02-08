From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Fri, 08 Feb 2019 17:31:54 +0000
Subject: Re: [PATCH] video/fbdev: refactor video= cmdline parsing
Message-Id: <57d664cc-7125-e274-307f-d0b36e032f8e@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190123093817.13964-1-jani.nikula@intel.com>
 <20190123105830.GF3271@phenom.ffwll.local>
 <CGME20190123111206epcas2p286b8e3a62951d6d5f8f261501583dc50@epcas2p2.samsung.com>
 <87ef9339vo.fsf@intel.com>
In-Reply-To: <87ef9339vo.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jani Nikula <jani.nikula@intel.com>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org


On 01/23/2019 12:12 PM, Jani Nikula wrote:
> On Wed, 23 Jan 2019, Daniel Vetter <daniel@ffwll.ch> wrote:
>> On Wed, Jan 23, 2019 at 11:38:17AM +0200, Jani Nikula wrote:
>>> Make the video_setup() function slightly easier to read by removing the
>>> repeated checks for !global. Remove the misleading return value comment
>>> while at it.
>>>
>>> I'm slightly hesitant to change any of this, but here goes anyway, with
>>> hopes that the next person to have to look at this has it a wee bit
>>> easier.
>>>
>>> Signed-off-by: Jani Nikula <jani.nikula@intel.com>
>>
>> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> 
> Thanks.
> 
> Just to be clear, I expect Bartlomiej to queue this via the fb tree
> (provided he agrees with the change, of course).

Patch queued for v5.1, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
