From: Michael Ellerman <mpe@ellerman.id.au>
Date: Wed, 29 Oct 2014 08:27:42 +0000
Subject: Re: [PATCH] drivers: depend on instead of select BACKLIGHT_CLASS_DEVICE and ACPI_VIDEO
Message-Id: <1414571262.5922.0.camel@concordia>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1413580403-16225-1-git-send-email-jani.nikula@intel.com>
	 <54476492.6090105@ti.com> <87a94hu3j0.fsf@intel.com>
	 <544E44E9.4040208@ti.com> <544FFC91.9040104@infradead.org>
	 <1414551853.7417.1.camel@concordia> <87tx2njooz.fsf@intel.com>
In-Reply-To: <87tx2njooz.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jani Nikula <jani.nikula@intel.com>
Cc: Randy Dunlap <rdunlap@infradead.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-fbdev@vger.kernel.org, Jingoo Han <jg1.han@samsung.com>, Daniel Drake <dsd@laptop.org>, Jens Frederich <jfrederich@gmail.com>, David Airlie <airlied@linux.ie>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jon Nettleton <jon.nettleton@gmail.com>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, platform-driver-x86@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Darren Hart <dvhart@infradead.org>, Daniel Vetter <daniel.vetter@intel.com>, Bryan Wu <cooloney@gmail.com>, linuxppc-dev@lists.ozlabs.org

On Wed, 2014-10-29 at 09:54 +0200, Jani Nikula wrote:
> On Wed, 29 Oct 2014, Michael Ellerman <mpe@ellerman.id.au> wrote:
> > On Tue, 2014-10-28 at 13:29 -0700, Randy Dunlap wrote:
> >> On 10/27/14 06:13, Tomi Valkeinen wrote:
> >> > I also think the 'depends on BACKLIGHT_CLASS_DEVICE ||
> >> > BACKLIGHT_CLASS_DEVICE=n' pattern is quite... interesting (i.e. sounds
> >> > like a hack to me =).
> >> 
> >> It does exactly what is needed and it is used in many places in kernel
> >> Kconfig files.
> >
> > Is there any reason you can't do:
> >
> >   depends on BACKLIGHT_CLASS_DEVICE != m
> 
> That's not the same thing. The FOO || FOO=n allows for all options, but
> forbids it being a module when the option depending on it is
> built-in.

OK right. Because "BAR depends on FOO" is short for "depends on FOO=y || FOO=m",
but also adds the implicit condition that if FOO=m then BAR must also be m.

Thanks for clueing me in.

cheers


