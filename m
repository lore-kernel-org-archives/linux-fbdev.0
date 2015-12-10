From: Robert Jarzmik <robert.jarzmik@free.fr>
Date: Thu, 10 Dec 2015 17:34:56 +0000
Subject: Re: [PATCH v5 2/2] video: fbdev: pxafb: initial devicetree conversion
Message-Id: <874mfqjjgf.fsf@belgarion.home>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1447792337-13876-1-git-send-email-robert.jarzmik@free.fr>
	<1447792337-13876-2-git-send-email-robert.jarzmik@free.fr>
	<5665B3C1.1080005@ti.com> <87bna2kmp7.fsf@belgarion.home>
	<56699A57.9030209@ti.com>
In-Reply-To: <56699A57.9030209@ti.com> (Tomi Valkeinen's message of "Thu, 10
	Dec 2015 17:29:27 +0200")
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Rob Herring <robh+dt@kernel.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

Tomi Valkeinen <tomi.valkeinen@ti.com> writes:

> On 07/12/15 22:50, Robert Jarzmik wrote:
>
>>> It seems that at least "depth" is missing from the binding document.
>> You're right.
>> 
>> Actually depth is not a "hardware" caracteristic. Moreover it's just used as an
>> overlay for pxafb_set_pixfmt() to superseed var->bits_per_pixel. I'm wondering
>> if the right path for of_get_pxafb_mode_info() would be to remove completely
>> depth, and leave it initialized at 0 for the DT case.
>> 
>> What do you think of this approach ? The other one would be to modify the
>> binding, and yet I feel this depth doesn't belong to the binding, it's my patch
>> which requires another spin IMHO.
>
> Yes, we should avoid non-hardware relate properties in the .dts files if
> at all possible. If the driver works fine without the property, I think
> it's fine to remove it. If it is required it needs to be added to the
> binding document.

Ok, agreed Tomi. That commits me for a v6, as the driver works fine on my
tests. I'll send it in the next couple of days.

Thanks for the review.

-- 
Robert
