From: Julian Scheel <julian@jusst.de>
Date: Fri, 29 Jan 2016 12:00:52 +0000
Subject: Re: [PATCH] fbdev: ssd1307fb: Fix chargepump setting
Message-Id: <56AB5474.7070801@jusst.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1447337257-31232-1-git-send-email-julian@jusst.de>
In-Reply-To: <1447337257-31232-1-git-send-email-julian@jusst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Am 29.01.2016 um 12:55 schrieb Tomi Valkeinen:
>
> On 18/01/16 22:20, Julian Scheel wrote:
>> On 15.11.15 14:36, Julian Scheel wrote:
>>> The charge pump setting must have bit D4 set all time according to the
>>> SSD1306
>>> App Note. Instead of doing an logical and off shifted setting bit with
>>> 0x14 it
>>> must be an logical or with 0x10 to ensure D4 is set.
>
> The code change looks ok, but I can't quite decipher the commit
> description. "an logical and off shifted setting bit with 0x14"?

Appears I was not awake when writing the commit message. Besides that 
the sentence is really cludgy it must be "of" instead of "off".
It might be simplified to: "Applying logical and to 0x14 and the 
chargepump bit prevents bit 4 from being set. Fix it by or'ing bit 4 and 
the chargepump enable bit"

>>> Signed-off-by: Julian Scheel <julian@jusst.de>
>>> ---
>>>    drivers/video/fbdev/ssd1307fb.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/video/fbdev/ssd1307fb.c
>>> b/drivers/video/fbdev/ssd1307fb.c
>>> index 1611215..5965a9b 100644
>>> --- a/drivers/video/fbdev/ssd1307fb.c
>>> +++ b/drivers/video/fbdev/ssd1307fb.c
>>> @@ -389,7 +389,7 @@ static int ssd1307fb_init(struct ssd1307fb_par *par)
>>>            return ret;
>>>
>>>        ret = ssd1307fb_write_cmd(par->client,
>>> -        (par->device_info->need_chargepump & 0x1 << 2) & 0x14);
>>> +        0x10 | ((par->device_info->need_chargepump & 0x01) << 2));
>
> I presume 'need_chargepump' is really supposed to be a bool, instead of
> int. And if it's really bool, something like this makes it more readable
> to me:
>
> BIT(4) | (par->device_info->need_chargepump ? BIT(2) : 0)

Yes, this is easier to read.
Let me update the patch and send a v2.

-Julian

