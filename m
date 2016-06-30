From: Jani Nikula <jani.nikula@linux.intel.com>
Date: Thu, 30 Jun 2016 12:03:37 +0000
Subject: Re: [PATCH] backlight: Avoid double fbcon backlight handling
Message-Id: <8737nurihy.fsf@intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1467286256-8870-1-git-send-email-chris@chris-wilson.co.uk>
In-Reply-To: <1467286256-8870-1-git-send-email-chris@chris-wilson.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-gfx@lists.freedesktop.org
Cc: Chris Wilson <chris@chris-wilson.co.uk>, Imre Deak <imre.deak@intel.com>, Zhang Rui <rui.zhang@intel.com>, Alex Deucher <alexander.deucher@amd.com>, Christian =?utf-8?Q?K=C3=B6nig?= <christian.koenig@amd.com>, David Airlie <airlied@linux.ie>, Patrik Jakobsson <patrik.r.jakobsson@gmail.com>, Daniel Vetter <daniel.vetter@intel.com>, Ben Skeggs <bskeggs@redhat.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Bruno =?utf-8?Q?Pr=C3=A9mont?= <bonbons@linux-vserver.org>, Jiri Kosina <jikos@kernel.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Noralf =?utf-8?Q?Tr?= =?utf-8?Q?=C3=B8nnes?= <noralf@tronnes.org>, Jens Frederich <jfrederich@gmail.com>, Daniel Drake <dsd@laptop.org>, Jon Nettleton <jon.nettleton@gmail.com>, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, Jean-Christophe

On Thu, 30 Jun 2016, Chris Wilson <chris@chris-wilson.co.uk> wrote:
> Backlights controlled by i915.ko and only associated with its connectors
> and also only associated with the intel_drmfb fbcon, controlled by
> i915.ko. In this situation, we already handle adjusting the backlight
> when the fbcon is blanked/unblanked and do not require backlight trying
> to do the same.

Acked-by: Jani Nikula <jani.nikula@intel.com>

-- 
Jani Nikula, Intel Open Source Technology Center
