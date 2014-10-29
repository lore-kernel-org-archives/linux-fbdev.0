From: Jani Nikula <jani.nikula@intel.com>
Date: Wed, 29 Oct 2014 07:54:36 +0000
Subject: Re: [PATCH] drivers: depend on instead of select BACKLIGHT_CLASS_DEVICE and ACPI_VIDEO
Message-Id: <87tx2njooz.fsf@intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1413580403-16225-1-git-send-email-jani.nikula@intel.com>
 <54476492.6090105@ti.com> <87a94hu3j0.fsf@intel.com>
 <544E44E9.4040208@ti.com> <544FFC91.9040104@infradead.org>
 <1414551853.7417.1.camel@concordia>
In-Reply-To: <1414551853.7417.1.camel@concordia>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michael Ellerman <mpe@ellerman.id.au>, Randy Dunlap <rdunlap@infradead.org>
Cc: linux-fbdev@vger.kernel.org, linux-usb@vger.kernel.org, Daniel Drake <dsd@laptop.org>, Jens Frederich <jfrederich@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jon Nettleton <jon.nettleton@gmail.com>, Jingoo Han <jg1.han@samsung.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, platform-driver-x86@vger.kernel.org, Bryan Wu <cooloney@gmail.com>, linuxppc-dev@lists.ozlabs.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Daniel Vetter <daniel.vetter@intel.com>, Darren Hart <dvhart@infradead.org>, Lee Jones <lee.jones@linaro.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>

On Wed, 29 Oct 2014, Michael Ellerman <mpe@ellerman.id.au> wrote:
> On Tue, 2014-10-28 at 13:29 -0700, Randy Dunlap wrote:
>> On 10/27/14 06:13, Tomi Valkeinen wrote:
>> > I also think the 'depends on BACKLIGHT_CLASS_DEVICE ||
>> > BACKLIGHT_CLASS_DEVICE=n' pattern is quite... interesting (i.e. sounds
>> > like a hack to me =).
>> 
>> It does exactly what is needed and it is used in many places in kernel
>> Kconfig files.
>
> Is there any reason you can't do:
>
>   depends on BACKLIGHT_CLASS_DEVICE != m

That's not the same thing. The FOO || FOO=n allows for all options, but
forbids it being a module when the option depending on it is
built-in. Obviously something that's built-in can't depend on something
built as a module.

BR,
Jani.


-- 
Jani Nikula, Intel Open Source Technology Center
