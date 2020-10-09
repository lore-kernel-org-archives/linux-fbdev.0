From: stsp <stsp2@yandex.ru>
Date: Fri, 09 Oct 2020 10:50:13 +0000
Subject: drmfb console switching problems/questions
Message-Id: <17980f58-c2d2-ac58-88ce-e21b5a56da39@yandex.ru>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, Linux kernel <linux-kernel@vger.kernel.org>

Hi!

I am trying to run my sdl1-based app
under linux kms framebuffer (amdgpudrmfb
in my case).
The app itself works perfectly, but
console switching is not.

If I switch the console while the app
is drawing, then it will corrupt the
VC I switched to. It will just draw on
top of the VC's content.
Question: is this expected? Is drm
framebuffer global, rather than per-vc?
If so, should I somehow freeze my
app when it is switched away? And
why would it be the case, with the
modern video cards that have multi
gigas of RAM on board?

If my app crashes without a clean
shutdown, then the framebuffer kinda
hangs. I can switch to other VCs but
I don't see their content. All I see is
the last drawing of my app. If I happen
to have an X server on some other VC,
then switching to it immediately unhangs
everything, and I can switch back.
In fact, even if I hit Ctrl-Alt-Del, then
fb immediately unhangs (by systemd
or plymouth or whoever else). But for
example SAK combo doesn't unhang.
So it seems to be very simple to hang
the framebuffer, and is quite difficult
to recover.
Question: is this an expected behaviour
or a drmfb bug?

Thanks!
