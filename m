From: Mark Rutland <mark.rutland@arm.com>
Date: Fri, 04 Jul 2014 16:31:19 +0000
Subject: Re: [RFC v4 2/2] backlight: device tree: add new tps611xx backlight binding
Message-Id: <20140704163119.GB7106@leverpostej>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1404367277-12003-1-git-send-email-gshark.jeong@gmail.com>
 <1404367277-12003-3-git-send-email-gshark.jeong@gmail.com>
 <20140703090447.GC29837@leverpostej>
 <CAPqQCJUYqgireOiqK9DLpSAkw_4DdmKD+G7bXxVxf=bb0nTj6Q@mail.gmail.com>
In-Reply-To: <CAPqQCJUYqgireOiqK9DLpSAkw_4DdmKD+G7bXxVxf=bb0nTj6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Daniel Jeong <gshark.jeong@gmail.com>
Cc: Jingoo Han <jg1.han@samsung.com>, Bryan Wu <cooloney@gmail.com>, Lee Jones <lee.jones@linaro.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, Daniel Jeong <daniel.jeong@ti.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>

>     > +- rfa-enable: enable request for acknowledge.
>     > +  If RFA is enabled, the data byte includes the RFA bit and device will
>     wait
>     > +  and check acknowledge from device.
> 
>     You didn't answer my question as to why this should be in the DT.
> 
> 
> According to the RFA enable, the easy scale pin works differently.
> This value should be set before the first data transfer.

Sure, things works differently if this is set. That I understood.

What I haven't heard is a rationale as to why this configuration option
shuold be in the DT.

Can I enable this on all implementations, or not?

When would I enable this and when would I not?

The property reads like a switch to turn a feature on, rather than the
description of the presence of a feature.

Mark.
