From: Brian Masney <masneyb@onstation.org>
Date: Tue, 02 Apr 2019 00:02:17 +0000
Subject: Re: [PATCH v2 3/3] backlight: lm3630a: add device tree supprt
Message-Id: <20190402000217.GA8315@basecamp>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190401103034.21062-1-masneyb@onstation.org>
 <20190401103034.21062-4-masneyb@onstation.org>
 <20190401214847.GE14681@amd>
In-Reply-To: <20190401214847.GE14681@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Pavel Machek <pavel@ucw.cz>
Cc: lee.jones@linaro.org, daniel.thompson@linaro.org, jingoohan1@gmail.com, robh+dt@kernel.org, jacek.anaszewski@gmail.com, mark.rutland@arm.com, b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, dmurphy@ti.com, jonathan@marek.ca

On Mon, Apr 01, 2019 at 11:48:47PM +0200, Pavel Machek wrote:
> So ... we can have multiple LEDs, each can have up to two
> sources.. and the settings are really per source, not per LED.
> 
> But you do not test for overlaps. What prevents me from having
> 
>    foo {
>        led_sources = <0>;
>        ti,linear-mapping-mode;
>    }
>    bar {
>        led_sources = <0>;
>    }
> 
> (I.e. conflicting settings for a source?)

In this case, it will go with the settings for 'bar'. I didn't check for
the conflicting settings since I was going for consistency with the
other two backlight drivers that already have the led-sources property:
arcxcnn_bl.c and sky81452-backlight.c. I can add the additional check
to fail if a source has already been encountered.

> Plus I do not see parsing of led labels etc...

OK... I can fix that up plus your other two comments.

Thanks,

Brian
