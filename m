From: Richard Weinberger <richard@nod.at>
Date: Tue, 15 Apr 2014 07:50:25 +0000
Subject: Re: [PATCH 07/28] Remove CPU_PXA988
Message-Id: <534CE4C1.9010507@nod.at>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1391971686-9517-1-git-send-email-richard@nod.at>		 <1391971686-9517-8-git-send-email-richard@nod.at>	 <1391984646.25855.79.camel@x220> <52F800B2.6010702@nod.at> <1397548054.1985.3.camel@x220>
In-Reply-To: <1397548054.1985.3.camel@x220>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Bolle <pebolle@tiscali.nl>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, FRAMEBUFFER LAYER <linux-fbdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>

Am 15.04.2014 09:47, schrieb Paul Bolle:
> Richard,
> 
> On Sun, 2014-02-09 at 23:26 +0100, Richard Weinberger wrote:
>> Am 09.02.2014 23:24, schrieb Paul Bolle:
>>> On Sun, 2014-02-09 at 19:47 +0100, Richard Weinberger wrote:
>>>> The symbol is an orphan, get rid of it.
>>>>
>>>> Signed-off-by: Richard Weinberger <richard@nod.at>
>>>
>>> This one first entered the tree in v3.9, with commit 59393bb94c10
>>> ("video: mmp display subsystem"). The Kconfig symbol has not yet been
>>> added.
>>
>> Thanks a lot for digging out the background info!
>> I'll add them to the commit message.
> 
> Did you ever find the time to update the commit message? If not, should
> I submit an updated version of this patch?

Sadly not.

Feel free to take this (and other related) patches over.
Thanks a lot for caring!

Thanks,
//richard
