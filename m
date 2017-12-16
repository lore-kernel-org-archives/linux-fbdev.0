From: Robert Jarzmik <robert.jarzmik@free.fr>
Date: Sat, 16 Dec 2017 11:40:55 +0000
Subject: Re: [PATCH v2 3/3] backlight: tdo24m: add model and status sysfs entries
Message-Id: <87o9myew8o.fsf@belgarion.home>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20171013194250.9001-1-robert.jarzmik@free.fr>
        <20171013194250.9001-3-robert.jarzmik@free.fr>
        <20171215143200.sm22mkifqlskjddf@oak.lan>
In-Reply-To: <20171215143200.sm22mkifqlskjddf@oak.lan> (Daniel Thompson's
        message of "Fri, 15 Dec 2017 14:32:00 +0000")
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Lee Jones <lee.jones@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

Daniel Thompson <daniel.thompson@linaro.org> writes:

> On Fri, Oct 13, 2017 at 09:42:49PM +0200, Robert Jarzmik wrote:
>> Add entries to query the panel ASIC to acquire the model number and the
>> status field. This comes in handy to check that the SPI connection is
>> functional and that the panel's firmware is alive.
>> 
>> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
>
> This feels to me somewhat like debug information being pushed into sysfs.
> There are very few backlight drivers that add additional sysfs attributes
> meaning the extra info here is not commonly pushed into the ABI for a
> backlight and knowing the info in these properties does not really 
> help userspace to *use* the hardware.
>
> Does this kind of thing really belong in sysfs?
Ok, as you wish. Let's drop this patch from the serie for now.

Cheers.

--
Robert
