From: Stephen Warren <swarren@wwwdotorg.org>
Date: Thu, 16 Aug 2012 18:57:19 +0000
Subject: Re: [PATCH v4 1/3] Runtime Interpreted Power Sequences
Message-Id: <502D428F.1010901@wwwdotorg.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1345097337-24170-1-git-send-email-acourbot@nvidia.com>
 <1345097337-24170-2-git-send-email-acourbot@nvidia.com>
 <502D3E29.1010501@wwwdotorg.org>
 <20120816184703.GP15365@opensource.wolfsonmicro.com>
In-Reply-To: <20120816184703.GP15365-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Cc: linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Anton Vorontsov <cbou-JGs/UdohzUI@public.gmane.org>, Alexandre Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org

On 08/16/2012 12:47 PM, Mark Brown wrote:
> On Thu, Aug 16, 2012 at 12:38:33PM -0600, Stephen Warren wrote:
> 
>> Note that this somewhat conflicts with accessing the top-level power
>> sequence by name too; perhaps that should be re-thought too. I must
>> admit this DT rule kinda sucks.
> 
> Given that currently the information there is useless and ignored is
> there any reason we can't just change the rule?  It'd be rather more
> constructive...

I'll start a new thread on that topic and see. I would simplify matters
a lot...

