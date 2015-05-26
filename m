From: Heiko Schocher <hs@denx.de>
Date: Tue, 26 May 2015 07:17:50 +0000
Subject: Re: [RFC PATCH] video/logo: introduce new system state for checking if logos are freed
Message-Id: <55641E1E.9010607@denx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1430896145-8887-1-git-send-email-hs@denx.de> <5562B9CE.7050807@ti.com> <5563EEF9.3080901@denx.de> <556418A9.8010603@ti.com>
In-Reply-To: <556418A9.8010603@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, linux-fbdev@vger.kernel.org, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>

Hello Tomi,

Am 26.05.2015 08:54, schrieb Tomi Valkeinen:
>
>
> On 26/05/15 06:56, Heiko Schocher wrote:
>
>>> Without locking, the initmem may be freed while fb_find_logo() is
>>> running.
>>
>> Yes, you are right, that must be added ... but has such a change a
>> chance to go in mainline?
>
> I don't know. To be honest, this whole thing feels a bit like hackery. I

Full Ack ;-)

> think initdata should only be accessed from initcalls, never asynchronously.

Yes.

>> BTW: Could this not be currently a problem on multicore systems?
>> If lets say core 2 just draws the logo, another core 1 calls
>> fb_logo_late_init() and later core 1 free_initmem(), while the core 2
>> still draws it?
>
> Yes, I think so...
>
> So, maybe it would be better to not even try to go forward with the
> current approach. Two approaches come to my mind:
>
> 1) Keep the logos in the memory, and don't even try to free them. I
> don't know many bytes they are in total, though.

That was my first thought too... but we waste memory ... not nice.

> 2) Make a copy of the logos to a kmalloced area at some early boot
> stage. Then manually free the logos at some point (after the first
> access to the logos? after a certain time (urgh...)?).

maybe yes ... or  ...

3) wait for all cores, until they reached SYSTEM_FREEING_MEM and
free init mem only than? But are all cores used/started when booting?

4) draw only one logo even on multicores ... why must every core draw
a logo? Currently each core draws the logo, and on a system with more
than 4 cores, I think this looks not really good ...

Hmm... I do not really have a lot experience in this area ... but why
is the logo only drawed when booting? Is there nothing like a "redraw"
of it?

Maybe others have here a good idea?

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
