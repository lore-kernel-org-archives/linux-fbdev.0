From: Rob Clark <rob.clark@linaro.org>
Date: Wed, 29 Feb 2012 14:52:18 +0000
Subject: Re: [PATCH 2/2] OMAPDSS: APPLY: make ovl_enable/disable synchronous
Message-Id: <CAF6AEGtaRwdSYsOh9qgBWmcOP5nm3hkkjbfT=BJFpgBZFwCS4w@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1330505302-8258-1-git-send-email-tomi.valkeinen@ti.com>
	<1330505302-8258-3-git-send-email-tomi.valkeinen@ti.com>
	<4F4DFA30.2040503@gmx.de>
	<1330511438.1934.95.camel@deskari>
	<4F4E0294.6000406@gmx.de>
In-Reply-To: <4F4E0294.6000406@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org

On Wed, Feb 29, 2012 at 4:48 AM, Florian Tobias Schandinat
<FlorianSchandinat@gmx.de> wrote:
> Hi Tomi,
>
> On 02/29/2012 10:30 AM, Tomi Valkeinen wrote:
>> On Wed, 2012-02-29 at 10:13 +0000, Florian Tobias Schandinat wrote:
>>> On 02/29/2012 08:48 AM, Tomi Valkeinen wrote:
>>>> ovl->enable/disable are meant to be synchronous so that they can handle
>>>> the configuration of fifo sizes. The current kernel doesn't configure
>>>> fifo sizes yet, and so the code doesn't need to block to function (from
>>>> omapdss driver's perspective).
>>>>
>>>> However, for the users of omapdss a non-blocking ovl->disable is
>>>> confusing, because they don't know when the memory area is not used
>>>> any more.
>>>>
>>>> Furthermore, when the fifo size configuration is added in the next mer=
ge
>>>> window, the change from non-blocking to blocking could cause side
>>>> effects to the users of omapdss. So by making the functions block
>>>> already will keep them behaving in the same manner.
>>>
>>> Is there any difference to doing it now?
>>> I agree that this should be fixed but if we can't avoid breaking users =
I'd
>>> prefer to break them in a merge window not in late rc stage. Or did we =
introduce
>>> these functions just in the last merge window?
>>
>> Yes, these were introduced in the merge window. And I explicitly said
>> the functions are blocking so that they can perform their job. And just
>> to clarify, the functions already use a mutex, so in that sense they are
>> blocking. They just don't currently wait until the HW has finished with
>> the overlay.
>
> okay, than I'll apply this patch as is. I was just worried about asking L=
inus to
> pull something that is labled as "Breaks existing users" now, but that do=
esn't
> look like an issue here.
>

I don't expect this change should break any existing users.. I think
it is safe to call this a bug fix

BR,
-R

> Best regards,
>
> Florian Tobias Schandinat
>
>>
>> The problem was raised by Rob Clark, who's writing the omapdrm driver,
>> as he doesn't have a way to ensure that the overlay has been truly
>> disabled and the memory is is no longer in use.
>>
>> (I forgot to cc him for the patch, adding him now).
>>
>> =A0Tomi
>>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
