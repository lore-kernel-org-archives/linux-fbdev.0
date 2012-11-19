From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Mon, 19 Nov 2012 09:15:04 +0000
Subject: Re: [RFC] fbdev: arm has __raw I/O accessors, use them in fb.h
Message-Id: <20121119091504.GB3290@n2100.arm.linux.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1353057364-21214-1-git-send-email-archit@ti.com>
 <ADE657CA350FB648AAC2C43247A983F00206B2644F3F@AUSP01VMBX24.collaborationhost.net>
 <50A9C1C4.5070907@ti.com>
In-Reply-To: <50A9C1C4.5070907@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Mon, Nov 19, 2012 at 10:51:08AM +0530, Archit Taneja wrote:
> On Friday 16 November 2012 10:14 PM, H Hartley Sweeten wrote:
>> On Friday, November 16, 2012 2:16 AM, Archit Taneja wrote:
>>>
>>> This removes the sparse warnings on arm platforms:
>>>
>>> warning: cast removes address space of expression
>>>
>>> Signed-off-by: Archit Taneja <archit@ti.com>
>>
>> I submitted the same patch around early March 2012. So FWIW:
>>
>> Reviewed-by: H Hartley Sweeten <hsweeten@visionengravers.com>
>
> Thanks.
>
> Florian,
>
> Could you queue this for 3.8 merge window?

Actually no.  Has anyone checked whether this has any impact for the BE
ARM platforms?
