From: Hans de Goede <hdegoede@redhat.com>
Date: Tue, 28 Oct 2014 11:08:04 +0000
Subject: Re: [PATCH v4 0/5] simplefb: add clock handling code
Message-Id: <544F7914.8090007@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1413996311-4287-1-git-send-email-hdegoede@redhat.com>
 <544F737A.7000109@ti.com>
In-Reply-To: <544F737A.7000109@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi,

On 10/28/2014 11:44 AM, Tomi Valkeinen wrote:
> On 22/10/14 19:45, Hans de Goede wrote:
> 
>> Since we seem to have broad agreement on how to move forward with this, I
>> would like to ask you to please merge this patch-set for 3.19.
>>
>> I know 3.19 is still somewhat ar away, but I would like to submit the u-boot
>> side of this to upstream ASAP, so can you please let me know if you plan to 
>> take this patch-set for 3.19 soon ?
> 
> This series looks fine to me, except patch 3 is missing a description,

Description for patch 3:

"Add a proper struct describing simplefb private data, with the palette in there,
instead of directly storing the palette in the fb_info->par pointer."

> and patch 4 makes the desc a continuation of the subject.

Description for patch 4:

"Use the usual kernel style of goto error_foo to free resources on probe
error. This is a preparation patch for adding clocks support.

While at it update ioremap_wc error return from ENODEV to ENOMEM."

> Each patch should have a description (independent from subject).

Ok, I'll remember that for future patches.

> No need to resend, I can cook up something for those, or I can edit the
> descs if you provide the text.

Descriptions provided above, thanks!

> So if there are no strong objections, I'll queue this for 3.19.

Regards,

Hans
