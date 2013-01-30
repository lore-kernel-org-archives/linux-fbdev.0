From: Alex Courbot <acourbot@nvidia.com>
Date: Wed, 30 Jan 2013 07:30:45 +0000
Subject: Re: [RFC 3/4] drm: tegra: use the Common Display Framework
Message-Id: <5108CC25.7080709@nvidia.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1359514939-15653-1-git-send-email-acourbot@nvidia.com> <1359514939-15653-4-git-send-email-acourbot@nvidia.com> <5108C298.1000500@gmail.com> <5108C55C.30104@nvidia.com> <20130130072406.GA17128@avionic-0098.mockup.avionic-design.de>
In-Reply-To: <20130130072406.GA17128-RM9K5IK7kjIQXX3q8xo1gnVAuStQJXxyR5q1nwbD4aMs9pC9oP6+/A@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Cc: Mark Zhang <nvmarkzhang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Mark Zhang <markz-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

On 01/30/2013 04:24 PM, Thierry Reding wrote:
>>> Could you pick up a somewhat meaningful name? You know, there are too
>>> many variables with name "drm/connector/output/encoder"... :)
>>
>> Well, it's supposed to be abstract. From the CDF point of view it
>> could be anything besides a panel. I know this makes it an output of
>> an output, but I can't think of anything better right now.
>
> How about renaming "this" to stream to match with what the output is in
> CDF speak.

Good idea.

> And the output's output is the panel, right? Why not just
> call it that? Even if it isn't directly connected to a panel entity but
> has indeed a whole pipeline in between, for tegra-drm it is still a
> panel.

Makes sense indeed. Besides the DT refer it as "panel" already.

Thanks,
Alex.
