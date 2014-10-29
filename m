From: Michael Ellerman <mpe@ellerman.id.au>
Date: Wed, 29 Oct 2014 03:04:13 +0000
Subject: Re: [PATCH] drivers: depend on instead of select BACKLIGHT_CLASS_DEVICE and ACPI_VIDEO
Message-Id: <1414551853.7417.1.camel@concordia>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1413580403-16225-1-git-send-email-jani.nikula@intel.com>
	 <54476492.6090105@ti.com> <87a94hu3j0.fsf@intel.com>
	 <544E44E9.4040208@ti.com> <544FFC91.9040104@infradead.org>
In-Reply-To: <544FFC91.9040104@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Jani Nikula <jani.nikula@intel.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-fbdev@vger.kernel.org, Jingoo Han <jg1.han@samsung.com>, Daniel Drake <dsd@laptop.org>, Jens Frederich <jfrederich@gmail.com>, David Airlie <airlied@linux.ie>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jon Nettleton <jon.nettleton@gmail.com>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, platform-driver-x86@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Darren Hart <dvhart@infradead.org>, Daniel Vetter <daniel.vetter@intel.com>, Bryan Wu <cooloney@gmail.com>, linuxppc-dev@lists.ozlabs.org

On Tue, 2014-10-28 at 13:29 -0700, Randy Dunlap wrote:
> On 10/27/14 06:13, Tomi Valkeinen wrote:
> > I also think the 'depends on BACKLIGHT_CLASS_DEVICE ||
> > BACKLIGHT_CLASS_DEVICE=n' pattern is quite... interesting (i.e. sounds
> > like a hack to me =).
> 
> It does exactly what is needed and it is used in many places in kernel
> Kconfig files.

Is there any reason you can't do:

  depends on BACKLIGHT_CLASS_DEVICE != m

cheers


