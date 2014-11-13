From: Hans de Goede <hdegoede@redhat.com>
Date: Thu, 13 Nov 2014 14:47:31 +0000
Subject: Re: [PATCH v3 3/4] simplefb: Change simplefb_init from module_init to fs_initcall
Message-Id: <5464C483.4040507@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1415885645-24613-1-git-send-email-hdegoede@redhat.com>
 <1415885645-24613-3-git-send-email-hdegoede@redhat.com>
 <5464C10A.30709@ti.com>
In-Reply-To: <5464C10A.30709@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi,

On 11/13/2014 03:32 PM, Tomi Valkeinen wrote:
> On 13/11/14 15:34, Hans de Goede wrote:
>> One of the reasons for having the simplefb nodes in /chosen, and doing
>> explicit enumeration of the nodes there, is too allow enumerating them sooner,
>> so that we get a console earlier on.
>>
>> Doing this earlier then fs_initcall is not useful, since the fb only turns into
>> a console when fbcon intializes, which is a fs_initcall too.
> 
> The above text is slightly confusing, as fbcon initializes at
> module_init time. You only change it in the next patch. I can move the
> fbcon change to be the first patch when applying, if there are no more
> versions sent.

True, feel free to swap them when applying.

Regards,

Hans
