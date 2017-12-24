From: Robert Jarzmik <robert.jarzmik@free.fr>
Date: Sun, 24 Dec 2017 11:55:55 +0000
Subject: Re: [PATCH v2 2/3] backlight: tdo24m: add the reset line gpio
Message-Id: <874logbar8.fsf@belgarion.home>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20171013194250.9001-1-robert.jarzmik@free.fr>
        <20171013194250.9001-2-robert.jarzmik@free.fr>
        <20171215115309.ez7odo7sh5zz7vge@oak.lan>
        <87shcaewah.fsf@belgarion.home>
In-Reply-To: <87shcaewah.fsf@belgarion.home> (Robert Jarzmik's message of
        "Sat, 16 Dec 2017 12:39:50 +0100")
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Lee Jones <lee.jones@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

Robert Jarzmik <robert.jarzmik@free.fr> writes:

> Daniel Thompson <daniel.thompson@linaro.org> writes:
>
>> On Fri, Oct 13, 2017 at 09:42:48PM +0200, Robert Jarzmik wrote:
>> Also, this adds a new optional property, doesn't the devicetree binding 
>> docs need to be update to match this?
> Ah yes, that too. I'll add it for v3.
Actually I won't ... because there is no description for tdo24m I could find.

If that's a problem for you, I'll drop that patch as well.

Cheers.

-- 
Robert
