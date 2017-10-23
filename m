From: Hans de Goede <hdegoede@redhat.com>
Date: Mon, 23 Oct 2017 13:54:25 +0000
Subject: Re: [PATCH v3 1/7] fbcon: Add fbcon_rotate_hint to struct fb_info
Message-Id: <e67bcf49-3a08-6e6e-48a7-7e1a688394ca@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20171023071425.5090-1-hdegoede@redhat.com>
 <20171023071425.5090-2-hdegoede@redhat.com>
 <20171023124326.db5mbmtseblb4fj7@earth>
In-Reply-To: <20171023124326.db5mbmtseblb4fj7@earth>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>, Hans de Goede <j.w.r.degoede@gmail.com>
Cc: linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, intel-gfx <intel-gfx@lists.freedesktop.org>, Daniel Drake <drake@endlessm.com>, dri-devel@lists.freedesktop.org, Bastien Nocera <hadess@hadess.net>, Daniel Vetter <daniel.vetter@intel.com>

Hi,

On 23-10-17 14:43, Sebastian Reichel wrote:
> Hi Hans,
> 
> On Mon, Oct 23, 2017 at 09:14:19AM +0200, Hans de Goede wrote:
>> On some hardware the LCD panel is not mounted upright in the casing,
>> but upside-down or rotated 90 degrees. In this case we want the console
>> to automatically be rotated to compensate.
>>
>> The fbdev-driver may know about the need to rotate. Add a new
>> fbcon_rotate_hint field to struct fb_info, which gets initialized to -1.
>> If the fbdev-driver knows that some sort of rotation is necessary then
>> it can set this field to a FB_ROTATE_* value to tell the fbcon console
>> driver to rotate the console.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
> 
> Thanks for your work. I will give it a try with Droid 4 and N950
> once I find some time :)

Ah, I did not even realize that this work would be useful for those
too, but yes that makes sense.


> [...]
> 
>> +	p->con_rotate = initial_rotation;
>> +	if (p->con_rotate = -1)
>> +		p->con_rotate = info->fbcon_rotate_hint;
>> +	if (p->con_rotate = -1)
>>   		p->con_rotate = fbcon_platform_get_rotate(info);
> 
> [...]
> 
>> +	p->con_rotate = initial_rotation;
>> +	if (p->con_rotate = -1)
>> +		p->con_rotate = info->fbcon_rotate_hint;
>> +	if (p->con_rotate = -1)
>>   		p->con_rotate = fbcon_platform_get_rotate(info);
>> +
> 
> maybe add a little helper function to reduce code duplication?

Maybe, I took a look and there already is a fbcon_set_rotation()
helper which does something completely different, so it might
be best to just keep this as is to avoid confusion between
2 similar named functions.

Regards,

Hans
