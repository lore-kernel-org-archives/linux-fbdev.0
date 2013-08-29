From: Archit Taneja <archit@ti.com>
Date: Thu, 29 Aug 2013 14:20:10 +0000
Subject: Re: [PATCH 06/15] OMAPDSS: remove all old panel drivers
Message-Id: <521F55CA.8050003@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1377783120-14001-1-git-send-email-tomi.valkeinen@ti.com> <1377783120-14001-7-git-send-email-tomi.valkeinen@ti.com> <521F53F0.4030203@ti.com> <521F555C.8090802@ti.com>
In-Reply-To: <521F555C.8090802@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

On Thursday 29 August 2013 07:36 PM, Tomi Valkeinen wrote:
> Hi,
>
> On 29/08/13 17:00, Archit Taneja wrote:
>> On Thursday 29 August 2013 07:01 PM, Tomi Valkeinen wrote:
>>> The board files now use the new panel drivers, making the old panel
>>> drivers obsolete.
>>>
>>> Remove the old panel drivers, Kconfig and Makefile entries, and the
>>> panels' platform data structs.
>>
>> Can we convert the picodlp driver to the new panel driver model, and
>> report it as broken for now?
>
> (please cut your quotes a bit, you just included some thousands of lines
> of code there =).

Oops, sure, will try to remember.

>
> We could, but I'm not sure what would be the point. The new picodlp
> would be (more or less) totally new driver, so we would still end up
> removing the old driver. We can as well add it later if we manage to get
> it working.

Okay. Let's do that then.

Archit

