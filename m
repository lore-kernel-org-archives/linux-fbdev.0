From: stsp <stsp2@yandex.ru>
Date: Fri, 09 Oct 2020 12:16:25 +0000
Subject: Re: drmfb console switching problems/questions
Message-Id: <70ce31ca-5922-584c-8631-3853c488f3c7@yandex.ru>
List-Id: <linux-fbdev.vger.kernel.org>
References: <17980f58-c2d2-ac58-88ce-e21b5a56da39@yandex.ru>
 <df4d1918-dcb1-4951-6280-f178ecbbfc2f@suse.de>
In-Reply-To: <df4d1918-dcb1-4951-6280-f178ecbbfc2f@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Thomas Zimmermann <tzimmermann@suse.de>, linux-fbdev@vger.kernel.org, Linux kernel <linux-kernel@vger.kernel.org>

09.10.2020 14:59, Thomas Zimmermann пишет:
> Fbdev exposes the video ram (or a shadow buffer of it) to all
> applications. Only one can draw at the same time. It's a limitation of
> the design. To fix this, your application has to stop drawing when you
> switch consoles.
OK, thanks for info.
Quite a sad news, if you ask me.
Is there any ongoing work at solving that?

Anyway, the fact that fb can
permanently hang, is, I suppose,
another problem - the one that
can't be worked around in an app.
I suspect it is the result of sdl doing
ioctl(console_fd, KDSETMODE, KD_GRAPHICS);
After which, I think, redrawing on a
VC switch became disabled.
Would it make sense to improve SAK
to unfreeze from that? Otherwise its
too easy to hang the screen permanently,
and no way to recover.
