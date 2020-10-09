From: stsp <stsp2@yandex.ru>
Date: Fri, 09 Oct 2020 13:19:23 +0000
Subject: Re: drmfb console switching problems/questions
Message-Id: <cacba527-fe32-e80c-4659-799452741791@yandex.ru>
List-Id: <linux-fbdev.vger.kernel.org>
References: <17980f58-c2d2-ac58-88ce-e21b5a56da39@yandex.ru>
 <df4d1918-dcb1-4951-6280-f178ecbbfc2f@suse.de>
 <70ce31ca-5922-584c-8631-3853c488f3c7@yandex.ru>
 <e2118f89-2c55-ec12-1e33-f2ba418af914@suse.de>
In-Reply-To: <e2118f89-2c55-ec12-1e33-f2ba418af914@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Thomas Zimmermann <tzimmermann@suse.de>, linux-fbdev@vger.kernel.org, Linux kernel <linux-kernel@vger.kernel.org>

09.10.2020 15:58, Thomas Zimmermann пишет:
> Hi
>
> Am 09.10.20 um 14:16 schrieb stsp:
>> 09.10.2020 14:59, Thomas Zimmermann пишет:
>>> Fbdev exposes the video ram (or a shadow buffer of it) to all
>>> applications. Only one can draw at the same time. It's a limitation of
>>> the design. To fix this, your application has to stop drawing when you
>>> switch consoles.
>> OK, thanks for info.
>> Quite a sad news, if you ask me.
>> Is there any ongoing work at solving that?
> I don't think so. Both, SDL1 and fbdev, are pretty much dead these days.
> The solution to fbdev is DRM, which does not have these problems.
>
> You could your application under X11 to use SDL's X backend. X would do
> all the VC handling then.
That of course works.
I was trying w/o X.
Do you think it is possible for
me to test other techniques of
drawing under kms console?
Or fbcon and X are all that we
have?
