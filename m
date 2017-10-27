From: Max Staudt <mstaudt@suse.de>
Date: Fri, 27 Oct 2017 11:21:26 +0000
Subject: Re: [RFC 08/14] bootsplash: Add file reading and picture rendering
Message-Id: <7066a986-cef2-bfd0-b968-2dc174688291@suse.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20171025124602.28292-1-mstaudt@suse.de>
 <20171025124602.28292-9-mstaudt@suse.de>
 <0b8c3644-1915-9a0a-696e-115742498cc2@infradead.org>
 <s5hzi8fm0r4.wl-tiwai@suse.de>
In-Reply-To: <s5hzi8fm0r4.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Takashi Iwai <tiwai@suse.de>, Randy Dunlap <rdunlap@infradead.org>
Cc: b.zolnierkie@samsung.com, linux-fbdev@vger.kernel.org, michal@markovi.net, Michal Srb <MSrb@suse.com>, Oliver Neukum <ONeukum@suse.com>, Stefan Dirsch <sndirsch@suse.com>, linux-kernel@vger.kernel.org

On 10/25/2017 10:27 PM, Takashi Iwai wrote:
> On Wed, 25 Oct 2017 19:32:53 +0200,
> Randy Dunlap wrote:
>>
>> On 10/25/17 05:45, Max Staudt wrote:
>>
>>> diff --git a/drivers/video/console/Kconfig b/drivers/video/console/Kconfig
>>> index a6617c07229a..c3496c5ac2bb 100644
>>> --- a/drivers/video/console/Kconfig
>>> +++ b/drivers/video/console/Kconfig
>>> @@ -175,6 +175,14 @@ config BOOTSPLASH
>>>            If unsure, say N.
>>>            This is typically used by distributors and system integrators.
>>>  
>>> +config BOOTSPLASH_FILE
>>> +        string "Default full path to bootsplash file"
>>> +        depends on BOOTSPLASH
>>> +        default "/bootsplash"
>>> +        help
>>> +          This file will be looked for in the initramfs and, if found, loaded
>>> +          and used as a bootsplash.
>>
>>
>> Some people try to avoid using initramfs.
>>
>> Can one have a bootsplash without initramfs?
> 
> The current code is apparently not capable, but it shouldn't be too
> difficult to re-use the built-in firmware.  i.e. essentially copying
> fw_get_builtin_firmware() in drivers/base/firmware_class.c.
> 
> Also the bootsplash can appear after mounting the rootfs, too.  Before
> that, it's simply a blank screen.  So it's not entirely useless even
> without initrd / initramfs.

Good point, I'll look into this.


Thanks

Max
