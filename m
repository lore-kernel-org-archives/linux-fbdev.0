From: Robert Jarzmik <robert.jarzmik@free.fr>
Date: Tue, 26 Jun 2018 09:04:43 +0000
Subject: Re: [PATCH 4/4] video: fbdev: pxafb: Add support for lcd-supply regulator
Message-Id: <874lhpnck4.fsf@belgarion.home>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180624153817.24387-4-daniel@zonque.org>
In-Reply-To: <20180624153817.24387-4-daniel@zonque.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Daniel Mack <daniel@zonque.org> writes:

> On Tuesday, June 26, 2018 10:27 AM, Robert Jarzmik wrote:
>> Daniel Mack <daniel@zonque.org> writes:
>>
>>> +	if (fbi->lcd_supply && fbi->lcd_supply_enabled != on) {
>> Mmh this looks weird ...
>> If lcd_supply_enabled = on, then the next block is never evaluated, and the
>> value of "on" is not considered in order to call regulator_disable() ...
>
> Hmm? This early bail just avoids unbalanced calls to the regulator core, which
> doesn't like that at all. IOW, the rest of this function is only executed if the
> desired supply state differs from our locally cached version.
>
> This also worked well in my tests. Am I missing something?
Ah yes, you're right.

My brain read : "if the cached value is not _on_ (ie. lcd_supply_enabled != 1),
then ..." instead of "if the cached value is not the new desired value" ...

> That should be done with devm_of_find_backlight() I figure, and not via a
> regulator. But it's trivial to do as a separate patch, yes.
Yep.

Reviewed-by: Robert Jarzmik <robert.jarzmik@free.fr>

Cheers.

-- 
Robert
