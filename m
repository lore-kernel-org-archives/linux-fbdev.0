From: Sachin Kamat <sachin.kamat@linaro.org>
Date: Wed, 08 Jan 2014 10:33:29 +0000
Subject: Re: [PATCH 1/4] video: ep93xx: Cleanup video-ep93xx.h header
Message-Id: <CAK9yfHzqrtyPcdgE0bNhOfQNSRuUAx3Tr4-gw+O1AmNp0qytWg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1388384533-20458-1-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1388384533-20458-1-git-send-email-sachin.kamat@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On 8 January 2014 15:12, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> On 2014-01-08 11:09, Sachin Kamat wrote:
>> Hi Tomi,
>>
>> On 30 December 2013 11:52, Sachin Kamat <sachin.kamat@linaro.org> wrote:
>>> Commit a3b2924547a7 ("ARM: ep93xx: move platform_data definitions")
>>> moved the file to the current location but forgot to remove the pointer
>>> to its previous location. Clean it up. While at it also change the header
>>> file protection macros appropriately.
>>>
>>> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>

>
> Thanks, queued the series for 3.14.

Thanks  Tomi.

-- 
With warm regards,
Sachin
