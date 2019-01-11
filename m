From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Fri, 11 Jan 2019 12:53:39 +0000
Subject: Re: [PATCH] fbdev: offb: Fix OF node name handling
Message-Id: <c1ee1bb0-3144-6752-b4ae-d65c65f96543@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190107173132.27316-1-robh@kernel.org>
        <CGME20190107201154epcas5p4e94984fb6be9a3263e97c79d362048a5@epcas5p4.samsung.com>
        <CA+7wUswqMNc1js6hyszYKVOeXrVPVDYLxSmZ97Uaqqo7u0Z9vQ@mail.gmail.com>
In-Reply-To: <CA+7wUswqMNc1js6hyszYKVOeXrVPVDYLxSmZ97Uaqqo7u0Z9vQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mathieu Malaterre <malat@debian.org>, Rob Herring <robh@kernel.org>
Cc: Elimar Riesebieter <riesebie@lxtec.de>, LKML <linux-kernel@vger.kernel.org>, "# v4 . 11" <stable@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>


On 01/07/2019 09:11 PM, Mathieu Malaterre wrote:
> On Mon, Jan 7, 2019 at 6:31 PM Rob Herring <robh@kernel.org> wrote:
>>
>> Commit 5c63e407aaab ("fbdev: Convert to using %pOFn instead of
>> device_node.name") changed how the OF FB driver handles the OF node
>> name. This missed the case where the node name is passed to
>> offb_init_palette_hacks(). This results in a NULL ptr dereference
>> in strncmp and breaks any system except ones using bootx with no display
>> node.
>>
>> Fix this by making offb_init_palette_hacks() use the OF node pointer and
>> use of_node_name_prefix() helper function instead for node name
>> comparisons. This helps in moving all OF node name accesses to helper
>> functions in preparation to remove struct device_node.name pointer.
>>
>> Fixes: 5c63e407aaab ("fbdev: Convert to using %pOFn instead of device_node.name")
> 
> Looks good to me:
> 
> ...
> [    0.000000] Linux version 5.0.0-rc1+ (malat@debian.org) (gcc
> version 6.3.0 20170516 (Debian 6.3.0-18)) #21 Mon Jan 7 21:03:53 CET
> 2019
> ...
> 
> So here is my :
> 
> Tested-by: Mathieu Malaterre <malat@debian.org>

Patch queued for 5.0, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
