From: Mathieu Malaterre <malat@debian.org>
Date: Wed, 02 Nov 2016 10:28:54 +0000
Subject: Re: [PATCH] Fix loading of module radeonfb on PowerMac
Message-Id: <CA+7wUsy9AW6BvNd=Bmmwra-YfTMAqFwLMg7Z7ZNXpxORq9qtTg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1475928540-19647-1-git-send-email-malat@debian.org>
 <fbf3b5a3-efd9-0f85-c4fe-ae34ae1862b7@ti.com>
In-Reply-To: <fbf3b5a3-efd9-0f85-c4fe-ae34ae1862b7@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Lennart Sorensen <lsorense@csclub.uwaterloo.ca>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>

Tomi,

On Wed, Nov 2, 2016 at 9:28 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> On 08/10/16 15:09, Mathieu Malaterre wrote:
>> When the linux kernel is build with (typical kernel ship with Debian
>> installer):
>>
>> CONFIG_FB_OF=y
>> CONFIG_VT_HW_CONSOLE_BINDING=y
>> CONFIG_FB_RADEON=m
>>
>> The offb driver takes precedence over module radeonfb. It is then
>> impossible to load the module, error reported is:
>>
>> [   96.551486] radeonfb 0000:00:10.0: enabling device (0006 -> 0007)
>> [   96.551526] radeonfb 0000:00:10.0: BAR 0: can't reserve [mem 0x98000000-0x9fffffff pref]
>> [   96.551531] radeonfb (0000:00:10.0): cannot request region 0.
>> [   96.551545] radeonfb: probe of 0000:00:10.0 failed with error -16
>>
>> This patch reproduce the behavior of the module radeon, so as to make it
>> possible to load radeonfb when offb is first loaded.
>>
>> It should be noticed that `offb_destroy` is never called which explain the
>> need to skip error detection on the radeon side.
>
> Why is that? It sounds rather bad if two drivers claim the same resources.

This has been working great so far for `radeon.ko`, so I assumed I
could shamelessly copy the behavior over to `radeonfb.ko`.

The original reference I found was from Benjamin Herrenschmidt here:
https://lists.freedesktop.org/archives/dri-devel/2010-August/002907.html

I am of course willing to try something else, but I would need some guidance.

Thanks much.
