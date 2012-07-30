From: Stephen Warren <swarren@wwwdotorg.org>
Date: Mon, 30 Jul 2012 22:26:28 +0000
Subject: Re: [RFC][PATCH v3 1/3] runtime interpreted power sequences
Message-Id: <50170A14.6000201@wwwdotorg.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1343390750-3642-1-git-send-email-acourbot@nvidia.com> <1343390750-3642-2-git-send-email-acourbot@nvidia.com> <5016ABDD.5010809@gmail.com>
In-Reply-To: <5016ABDD.5010809-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Alexandre Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>, Simon Glass <sjg-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org

On 07/30/2012 09:44 AM, Rob Herring wrote:
> On 07/27/2012 07:05 AM, Alexandre Courbot wrote:
>> Some device drivers (panel backlights especially) need to follow precise
>> sequences for powering on and off, involving gpios, regulators, PWMs
>> with a precise powering order and delays to respect between each steps.
>> These sequences are board-specific, and do not belong to a particular
>> driver - therefore they have been performed by board-specific hook
>> functions to far.
>>
>> With the advent of the device tree and of ARM kernels that are not
>> board-tied, we cannot rely on these board-specific hooks anymore but
>> need a way to implement these sequences in a portable manner. This patch
>> introduces a simple interpreter that can execute such power sequences
>> encoded either as platform data or within the device tree.
>>
> 
> Why not? We'll always have some amount of board code. The key is to
> limit parts that are just data. I'm not sure this is something that
> should be in devicetree.
> 
> Perhaps what is needed is a better way to hook into the driver like
> notifiers?

I would answer that by asking the reverse question - why should we have
to put some data in DT, and some data into board files still?

I'd certainly argue that the sequence of which GPIOs/regulators/PWMs to
manipulate is just data.

To be honest, if we're going to have to put some parts of a board's
configuration into board files anyway, then the entirety of DT seems
useless; I'd far rather see all the configuration in one cohesive place
than arbitrarily split into two/n different locations - that would make
everything harder to maintain.
