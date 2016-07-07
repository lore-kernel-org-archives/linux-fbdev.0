From: Jiri Kosina <jikos@kernel.org>
Date: Thu, 07 Jul 2016 08:33:08 +0000
Subject: Re: [PATCH] backlight: Avoid double fbcon backlight handling
Message-Id: <alpine.LNX.2.00.1607071032280.24757@cbobk.fhfr.pm>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1467286256-8870-1-git-send-email-chris@chris-wilson.co.uk>
In-Reply-To: <1467286256-8870-1-git-send-email-chris@chris-wilson.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Chris Wilson <chris@chris-wilson.co.uk>
Cc: Milo Kim <milo.kim@ti.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, David Airlie <airlied@linux.ie>, nouveau@lists.freedesktop.org, Jon Nettleton <jon.nettleton@gmail.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Thierry Reding <thierry.reding@gmail.com>, Paul Mackerras <paulus@samba.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Daniel Vetter <daniel.vetter@intel.com>, Lee Jones <lee.jones@linaro.org>, Daniel Drake <dsd@laptop.org>, Jens Frederich <jfrederich@gmail.com>, linux-acpi@vger.kernel.org, =?ISO-8859-15?Q?Bruno_Pr=E9mont?= <bonbons@linux-vserver.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Ben Skeggs <bskeggs@redhat.com>, Zhang Rui <rui.zhang@intel.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Michael Hennerich <michael.hennerich@analog.com>, intel-gfx@lists.

On Thu, 30 Jun 2016, Chris Wilson wrote:

> Backlights controlled by i915.ko and only associated with its connectors
> and also only associated with the intel_drmfb fbcon, controlled by
> i915.ko. In this situation, we already handle adjusting the backlight
> when the fbcon is blanked/unblanked and do not require backlight trying
> to do the same.
> 
> Attempting to register with the fbdev as a client causes lockdep to warn
> about a dependency cycle:
[ ... snip ... ]
>  drivers/hid/hid-picolcd_backlight.c                  |  3 ++-

For this one:

	Acked-by: Jiri Kosina <jkosina@suse.cz>

-- 
Jiri Kosina
SUSE Labs

