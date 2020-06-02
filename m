From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Tue, 02 Jun 2020 11:27:09 +0000
Subject: Re: [PATCH 1/2] video: fbdev: amifb: remove dead APUS support
Message-Id: <5cb15e20-e2e1-f79d-72af-74cc09debc19@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20200504232908eucas1p296927bc7c736ad924cefaea9a546459d@eucas1p2.samsung.com>
 <b1cf967015c5beafa475aaa30d8e21a58caff870.camel@perches.com>
 <839133dd-8ed4-5fec-c311-ce9f8abf3d5f@samsung.com>
 <72e0871c-d4bb-4887-4d6f-a60fd905bec1@physik.fu-berlin.de>
 <CAMuHMdXUD4PNndjtxz84pYMdXaM68g7vWiRd+Gf18a35T-oA=Q@mail.gmail.com>
 <6d17452e-29ee-76dd-759c-b39d87bb82b8@physik.fu-berlin.de>
In-Reply-To: <6d17452e-29ee-76dd-759c-b39d87bb82b8@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-m68k <linux-m68k@lists.linux-m68k.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, DRI Development <dri-devel@lists.freedesktop.org>, Al Viro <viro@zeniv.linux.org.uk>


On 6/2/20 1:07 PM, John Paul Adrian Glaubitz wrote:
> Hi!
> 
> On 6/2/20 1:04 PM, Geert Uytterhoeven wrote:
>>> What do you mean with the sentence "when arch/ppc/ was still king"?
>>
>> Ah, Bartl copied that from my email ;-)
>>
>> There used to be APUS support under arch/ppc/.
>> Later, 32-bit arch/ppc/ and 64-bit arch/ppc64/ were merged in a new\
>> architecture port under arch/powerpc/, and the old ones were dropped.
>> APUS was never converted, and thus dropped.
> 
> Ah, yes. Similar to the merge with x86.
> 
>>> Does that mean - in the case we would re-add APUS support in the future, that
>>> these particular changes would not be necessary?
>>
>> They would still be necessary, as PowerPC doesn't grok m68k instructions.
>> Alternatively, we could just drop the m68k inline asm, and retain the C
>> version instead?  I have no idea how big of a difference that would make
>> on m68k, using a more modern compiler than when the code was written
>> originally.
> 
> Hmm, no idea. I would keep the assembly for the time being. This was just
> a question out of curiosity. We could still consider such a change if
> someone should consider working on APUS support again.
> 
>> Note that all of this is used only for cursor handling, which I doubt is
>> actually used by any user space application. The only exception is the
>> DIVUL() macro, which is used once during initialization, thus also not
>> performance critical.
> I see, thanks.

Since the code in question is not performance critical it indeed seems to
be good idea to use C version. However it still would need be tested on
the hardware (or emulator at least) so for the time being I think that we
should just add another FIXME comment instead of doing real code changes..

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
