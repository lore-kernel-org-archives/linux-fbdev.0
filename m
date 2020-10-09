From: stsp <stsp2@yandex.ru>
Date: Fri, 09 Oct 2020 14:14:42 +0000
Subject: Re: drmfb console switching problems/questions
Message-Id: <e3f40930-6927-042f-7857-e843e1e24236@yandex.ru>
List-Id: <linux-fbdev.vger.kernel.org>
References: <17980f58-c2d2-ac58-88ce-e21b5a56da39@yandex.ru>
 <df4d1918-dcb1-4951-6280-f178ecbbfc2f@suse.de>
 <70ce31ca-5922-584c-8631-3853c488f3c7@yandex.ru>
 <e2118f89-2c55-ec12-1e33-f2ba418af914@suse.de>
 <cacba527-fe32-e80c-4659-799452741791@yandex.ru>
 <050632f0-6440-1254-2aed-931dd515ff37@suse.de>
In-Reply-To: <050632f0-6440-1254-2aed-931dd515ff37@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Thomas Zimmermann <tzimmermann@suse.de>, linux-fbdev@vger.kernel.org, Linux kernel <linux-kernel@vger.kernel.org>

09.10.2020 16:31, Thomas Zimmermann пишет:
> I can't say for sure. IIRC SDL2 can use DRM directly.
Yes, that was a great hint indeed,
thanks. It didn't work for me in the past
(a year ago or so), so I added SDL1
support. But now I re-tried, and it indeed
works!
And, as far as I can tell, the hanging
behaviour does not happen, at least
not that simple.
Thank you.
