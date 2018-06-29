From: Hans de Goede <hdegoede@redhat.com>
Date: Fri, 29 Jun 2018 10:10:34 +0000
Subject: Re: [PATCH] console: dummycon: export dummycon_[un]register_output_notifier
Message-Id: <1993d72a-6cec-ae80-0e9f-7c495e8f1b6c@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20180629093647epcas5p4753328d494b7926e40e4a7d403f0677f@epcas5p4.samsung.com>
 <20180629093627.14620-1-hdegoede@redhat.com> <2122931.M7oWVmMZAv@amdc3058>
In-Reply-To: <2122931.M7oWVmMZAv@amdc3058>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org

Hi,

On 29-06-18 12:06, Bartlomiej Zolnierkiewicz wrote:
> On Friday, June 29, 2018 11:36:27 AM Hans de Goede wrote:
>> Export dummycon_[un]register_output_notifier, the fbcon code needs this
>> and may be build as a module.
>>
>> Fixes: 83d83bebf401 ("console/fbcon: Add support for deferred console takeover")
>> Cc: Stephen Rothwell <sfr@canb.auug.org.au>
>> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> 
> Applied to fbdev-for-next, thanks.

You're welcome. And sorry about this, I should have gotten this right
from the start.

Regards,

Hans
