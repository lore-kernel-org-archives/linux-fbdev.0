From: Hans de Goede <hdegoede@redhat.com>
Date: Mon, 24 Jul 2017 07:56:45 +0000
Subject: Re: [PATCH v2] video/console: Add dmi quirk table for x86 systems which need fbcon rotation
Message-Id: <1532ea23-c438-f274-e18a-2c0eac02e909@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170706142839.14659-1-hdegoede@redhat.com>
In-Reply-To: <20170706142839.14659-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi,

On 24-07-17 09:49, Jean Delvare wrote:
> Hi Hans,
> 
> On Sun, 23 Jul 2017 12:32:22 +0200, Hans de Goede wrote:
>> On 21-07-17 10:59, Jean Delvare wrote:
>>> On Thu, 20 Jul 2017 10:11:17 +0200, Jean Delvare wrote:
>>>> On Sat, 8 Jul 2017 15:33:09 +0200, Hans de Goede wrote:
>>>>> On 07-07-17 21:02, Jean Delvare wrote:
>>>>>> (...)
>>>>>> "dmi_match" should probably have been named "dmi_field_match" instead,
>>>>>> maybe it should be renamed to that now for consistency and clarity?
>>>>>
>>>>> Yes I think that would be good, but outside of the scope of this patch-set.
>>>>
>>>> Of course, I meant it that way. I'll take care of it separately.
>>>
>>> As I was looking into this, I noticed function dmi_first_match(), which
>>> seems to do what you need. Here's an untested proof-of-concept, what do
>>> you think?
>>
>> I already considered using dmi_first_match() but that will not work
>> because the 2 different GPD devices have identical DMI strings other then
>> their bios-dates (GRRR).
> 
> Doh. I noticed it, and found a way around it, and implemented it... and
> forgot to refresh the patch before posting it :-( Maybe no longer
> relevant as you have found yet another way, but here it is still for
> your consideration:

<snip>

Ah yes that will work too, but TBH I think my own solution is a bit
cleaner, so lets go with v4 as is (as I already posted it) assuming
no-one finds any issues with it.

Regards,

Hans
