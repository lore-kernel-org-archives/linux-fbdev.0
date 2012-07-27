From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Fri, 27 Jul 2012 18:20:23 +0000
Subject: Re: [RFC][PATCH v3 1/3] runtime interpreted power sequences
Message-Id: <20120727182023.GC23564@kroah.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1343390750-3642-1-git-send-email-acourbot@nvidia.com>
 <1343390750-3642-2-git-send-email-acourbot@nvidia.com>
In-Reply-To: <1343390750-3642-2-git-send-email-acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alexandre Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>, Simon Glass <sjg-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org

On Fri, Jul 27, 2012 at 09:05:48PM +0900, Alexandre Courbot wrote:
> +++ b/include/linux/power_seq.h
> @@ -0,0 +1,139 @@
> +/*
> + * power_seq.h
> + *
> + * Simple interpreter for defining power sequences as platform data or device
> + * tree properties. Initially designed for use with backlight drivers.
> + *
> + * Power sequences are designed to replace the callbacks typically used in
> + * board-specific files that implement board-specific power sequences of devices
> + * such as backlights. A power sequence is an array of resources (which can a
> + * regulator, a GPIO, a PWM, ...) with an action to perform on it (enable or
> + * disable) and optional pre and post step delays. By having them interpreted
> + * instead of arbitrarily executed, it is possible to describe these in the
> + * device tree and thus remove board-specific code from the kernel.
> + *
> + * Author: Alexandre Courbot <acourbot@nvidia.com>
> + *
> + * Copyright (c) 2012 NVIDIA Corporation.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; version 2 of the License.
> + *
> + * This program is distributed in the hope that it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License along
> + * with this program; if not, write to the Free Software Foundation, Inc.,
> + * 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

As I always say:
	Unless you want to track the office movements of the FSF for the
	next 40 years, and keep this file up to date, drop that last
	paragraph, it's pointless.

