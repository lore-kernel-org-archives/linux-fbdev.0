From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 13 Mar 2020 13:56:56 +0000
Subject: Re: [PATCH] omapfb: Remove unused writeback code
Message-Id: <64b002c9-15df-2662-b969-e9696821b07a@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200313122410.7528-1-tomi.valkeinen@ti.com>
 <20200313132244.GB4751@pendragon.ideasonboard.com>
 <249364fc-bc83-6fe6-d3bf-f709505c299e@ti.com>
 <20200313133803.GA9070@pendragon.ideasonboard.com>
In-Reply-To: <20200313133803.GA9070@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

On 13/03/2020 15:38, Laurent Pinchart wrote:
> Hi Tomi,
> 
> On Fri, Mar 13, 2020 at 03:30:15PM +0200, Tomi Valkeinen wrote:
>> On 13/03/2020 15:22, Laurent Pinchart wrote:
>>> On Fri, Mar 13, 2020 at 02:24:10PM +0200, Tomi Valkeinen wrote:
>>>> Remove unused writeback code. This code will never be used, as omapfb is
>>>> being deprecated.
>>>
>>> I'm fine with that, but out of curiosity, is there any particular reason
>>> to remove that code now instead of letting omapfb bitrot slowly ?
>>
>> It conflicts with tidss's writeback code in TI kernel, when compiling tidss and omapfb into the
>> kernel. I thought this is the easiest way to resolve that, as all the removed code is dead code,
>> instead of trying to invent new names in tidss for a lot of functions.
>>
>> Probably the functions in tidss still could use some renaming in the future, but I didn't want to be
>> forced to do that because of omapfb's dead code...
> 
> Could you do both ? :-) It's not good using too generic names in tidss.
> You can just prefix the functions with tidss_. There's a risk of
> conflict with omapdrm too if the names are too generic.

I will, but I didn't want to start doing that right now. tidss has just been merged to mainline, and 
tidss is still under active development, so doing such a change is an invitation to conflicts. I'd 
like things to settle down a bit first.

  Tomi

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
